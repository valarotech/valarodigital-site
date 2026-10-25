// Shop orders (physical goods): mark paid, issue a GST tax invoice, email the buyer, and tell the shop owner what to pack.
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";
import { CODES, esc, inWords, rs } from "./common.ts";

const ADMIN_EMAIL = "valaroenterprises@gmail.com";

// deno-lint-ignore no-explicit-any
export function shopInvoiceHtml(o: any, b: any): string {
  const date = new Date(o.invoice_date).toLocaleDateString("en-GB", { timeZone: "Asia/Kolkata" }).replace(/\//g, "-");
  const intra = o.igst === 0;
  const code = CODES[o.customer_state] ?? "";
  // Shipping is not shown as its own line: it is folded into the highest-rate goods line (same tax as before, totals unchanged).
  // deno-lint-ignore no-explicit-any
  const all = (o.items as any[]).map((l) => ({ ...l }));
  const ship = all.find((l) => l.id === "shipping");
  const goods = all.filter((l) => l.id !== "shipping");
  if (ship && goods.length) {
    const t = goods.reduce((m, l) => (l.rate > m.rate ? l : m), goods[0]);
    t.base += ship.base; t.cgst += ship.cgst; t.sgst += ship.sgst; t.igst += ship.igst; t.incl += ship.incl;
  }
  const lines = ship && !goods.length ? all : goods;
  // Same layout as the courier-style bills the shop owner is used to: Item, Qty, Rate (before tax), GST %, Amount (before tax), then Sub Total, SGST, CGST, Total Net Amount.
  const rows = lines.map((l, i) =>
    `<tr><td>${i + 1}</td><td>${esc(l.name)}</td><td class="r">${l.qty}</td><td class="r">${rs(Math.round(l.base / l.qty))}</td><td class="r">${l.rate}</td><td class="r">${rs(l.base)}</td></tr>`
  ).join("");
  // Tax per rate (usually one rate). Labels carry the rate only when the cart mixes rates.
  const byRate: Record<number, { cgst: number; sgst: number; igst: number }> = {};
  for (const l of lines) { const t = (byRate[l.rate] ??= { cgst: 0, sgst: 0, igst: 0 }); t.cgst += l.cgst; t.sgst += l.sgst; t.igst += l.igst; }
  const many = Object.keys(byRate).length > 1;
  const taxRows = Object.keys(byRate).map(Number).sort((x, y) => x - y).map((r) => {
    const t = byRate[r], lab = (n: string, p: number) => n + (many ? ` (${p}%)` : "");
    return intra
      ? `<tr><td>${lab("SGST", r / 2)}</td><td class="r">${rs(t.sgst)}</td></tr><tr><td>${lab("CGST", r / 2)}</td><td class="r">${rs(t.cgst)}</td></tr>`
      : `<tr><td>${lab("IGST", r)}</td><td class="r">${rs(t.igst)}</td></tr>`;
  }).join("");
  const mob = o.customer_mobile ? `<br>Cell No: ${esc(o.customer_mobile)}` : "";
  return `<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Tax Invoice ${esc(o.invoice_no)}</title>
<style>body{font-family:Arial,Helvetica,sans-serif;color:#111;margin:0;padding:24px;font-size:13px}.box{max-width:720px;margin:0 auto;border:1px solid #bbb;padding:22px}
h1{font-size:24px;margin:0;text-align:right;letter-spacing:.5px}table{width:100%;border-collapse:collapse;margin-top:14px}.items td,.items th{padding:7px 8px;border-top:1px solid #333;border-bottom:1px solid #333;text-align:left;vertical-align:top}.items th{font-size:12px}.r{text-align:right}.m{color:#555;font-size:12px}.two{display:flex;gap:24px;flex-wrap:wrap}.two>div{flex:1;min-width:240px}.tot{width:55%;margin-left:auto}.tot td{padding:5px 8px}.net td{font-size:16px;font-weight:bold;border-top:1px solid #333;border-bottom:1px solid #333}.sc{overflow-x:auto}</style></head><body><div class="box">
<div class="two"><div><u><i>To Delivery Address:</i></u><br><b>${esc(o.customer_name)}</b><br>${esc(o.ship_address)}<br>${esc(o.customer_state)} - ${esc(o.customer_pincode)}${mob}<br>${esc(o.customer_email)}</div><div><h1>TAX INVOICE</h1><div class="r">Invoice No: <b>${esc(o.invoice_no)}</b><br>Date: ${esc(date)}<br>Place of supply: ${esc(o.customer_state)}${code ? " (" + code + ")" : ""}<br>Paid online: ${esc(o.razorpay_payment_id)}</div></div></div>
<div class="sc"><table class="items"><tr><th>S.No</th><th>Item Details</th><th class="r">Qty</th><th class="r">Rate</th><th class="r">GST %</th><th class="r">Amount</th></tr>${rows}</table></div>
<table class="tot"><tr><td>Sub Total</td><td class="r">${rs(o.base_total)}</td></tr>${taxRows}<tr class="net"><td>Total Net Amount</td><td class="r">${rs(o.amount)}</td></tr></table>
<p class="m" style="margin-top:6px"><i>${esc(inWords(o.amount))}</i></p>
<p style="margin-top:18px"><b>From Sender: ${esc(b.trade_name)}</b><br>${esc(b.display_address ?? "Tamil Nadu, India")}<br>GSTIN: ${esc(b.gstin)}<br>${esc(b.email)}</p>
<p class="m" style="margin-top:12px">Dear Customer, thank you for shopping with us. Prices include GST and delivery. This is a computer generated invoice and does not require a signature. Returns and refunds as per the policy on our website.</p>
<p class="r"><b>For ${esc(b.trade_name)}</b></p>
</div></body></html>`;
}

// deno-lint-ignore no-explicit-any
export async function handleShop(admin: any, order: any, pay: any, orderId: string): Promise<Response> {
  const ok = () => new Response("ok", { status: 200 });
  if (pay?.amount !== undefined && pay.amount !== order.amount) return new Response("amount mismatch", { status: 200 });
  await admin.from("shop_orders").update({ status: "paid", razorpay_payment_id: pay?.id ?? order.razorpay_payment_id }).eq("razorpay_order_id", orderId);
  try {
    if (order.invoice_html) return ok();
    const now = new Date().toISOString();
    // Atomic: only the first event for this payment gets an invoice number.
    const { data: cl, error: ne } = await admin.rpc("claim_shop_invoice_no", { p_order: orderId, p_date: now });
    const c = Array.isArray(cl) ? cl[0] : cl;
    if (ne || !c?.invoice_no) throw new Error("shop invoice number failed: " + (ne?.message ?? "empty"));
    if (!c.claimed) return ok();
    const o = { ...order, razorpay_payment_id: pay?.id ?? order.razorpay_payment_id, invoice_no: c.invoice_no, invoice_date: now };
    const { data: prof } = await admin.from("business_profile").select("*").eq("id", 1).single();
    const html = shopInvoiceHtml(o, prof);
    const { data: saved } = await admin.from("shop_orders").update({ invoice_html: html }).eq("razorpay_order_id", orderId).is("invoice_html", null).select("razorpay_order_id");
    if (!saved || !saved.length) return ok();

    const pass = Deno.env.get("SMTP_PASS");
    if (!pass) return ok();
    const smtp = new SMTPClient({ connection: { hostname: "smtp.hostinger.com", port: 465, tls: true, auth: { username: "hello@valarodigital.com", password: pass } } });
    try {
      // deno-lint-ignore no-explicit-any
      const goods = (o.items as any[]).filter((l) => l.id !== "shipping");
      const intro = `<div style="font-family:Arial,Helvetica,sans-serif;max-width:820px;margin:0 auto 18px;padding:18px;border:1px solid #bbb;border-radius:8px;color:#111;font-size:14px"><p style="margin:0 0 10px"><b>Thank you for your order.</b> We have received your payment and will pack your parcel.</p><p style="margin:0">We will send the tracking details to this email and by WhatsApp when it ships. Your tax invoice is below.</p></div>`;
      await smtp.send({ from: "Valaro Enterprises <hello@valarodigital.com>", to: o.customer_email, subject: `Your order is confirmed. Tax invoice ${o.invoice_no}`, content: `Thank you for your order. Your tax invoice ${o.invoice_no} is below (open it in an HTML-capable mail app).`, html: html.replace("<body>", "<body>" + intro) });
      await admin.from("shop_orders").update({ invoice_emailed: true }).eq("razorpay_order_id", orderId);
      const lines = goods.map((l) => `- ${l.name} x ${l.qty}`).join("\n");
      await smtp.send({
        from: "Valaro Shop <hello@valarodigital.com>", to: ADMIN_EMAIL, subject: `NEW ORDER ${o.invoice_no}: Rs ${(o.amount / 100).toFixed(2)} (${o.customer_state})`,
        html: `<div style="font-family:Arial,Helvetica,sans-serif;max-width:820px;margin:0 auto 18px;padding:16px;border:2px solid #ff6a2b;border-radius:8px;font-size:14px"><b>NEW PAID ORDER. Pack and ship.</b><br>Items: ${esc(goods.map((l) => l.name + " x " + l.qty).join(", "))}<br>Ship to: ${esc(o.customer_name)}, ${esc(o.ship_address)}, ${esc(o.customer_state)} - ${esc(o.customer_pincode)}<br>Mobile: +91 ${esc(o.customer_mobile)} | Email: ${esc(o.customer_email)}<br>Print the invoice below and put it in the parcel.</div>` + html,
        content: `A paid shop order needs packing.\n\nInvoice: ${o.invoice_no}\nAmount: Rs ${(o.amount / 100).toFixed(2)} (shipping Rs ${(o.shipping_paise / 100).toFixed(0)})\n\nItems:\n${lines}\n\nShip to:\n${o.customer_name}\n${o.ship_address}\n${o.customer_state} - ${o.customer_pincode}\nPhone: +91 ${o.customer_mobile}\nEmail: ${o.customer_email}\n\nRazorpay payment: ${o.razorpay_payment_id}`,
      });
      await admin.from("shop_orders").update({ admin_notified: true }).eq("razorpay_order_id", orderId);
    } finally {
      await smtp.close();
    }
  } catch (e) {
    console.error("shop invoice error", e);
  }
  return ok();
}
