// Razorpay calls this after a payment. We verify the signature, unlock the book, then issue a GST invoice.
import { createClient } from "npm:@supabase/supabase-js@2";
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";
import { CODES, esc, inWords, rs } from "./common.ts";
import { handleShop } from "./shop.ts";

const hex = (b: ArrayBuffer) => [...new Uint8Array(b)].map((x) => x.toString(16).padStart(2, "0")).join("");
const TITLES: Record<string, string> = {
  "ai-agents-tamil": "Tamil AI Agents book (online access)",
  "claude-code-commands-ta": "Claude Code slash commands guide in Tamil (online access)",
};

// deno-lint-ignore no-explicit-any
function invoiceHtml(o: any, b: any): string {
  const date = new Date(o.invoice_date).toLocaleDateString("en-GB", { timeZone: "Asia/Kolkata" }).replace(/\//g, "-");
  const intra = o.igst === 0;
  const code = CODES[o.customer_state] ?? "";
  const taxHead = intra
    ? `<th class="r">CGST %</th><th class="r">CGST Amt</th><th class="r">SGST %</th><th class="r">SGST Amt</th>`
    : `<th class="r">IGST %</th><th class="r">IGST Amt</th>`;
  const taxCells = intra
    ? `<td class="r">9%</td><td class="r">${rs(o.cgst)}</td><td class="r">9%</td><td class="r">${rs(o.sgst)}</td>`
    : `<td class="r">18%</td><td class="r">${rs(o.igst)}</td>`;
  const taxRows = intra
    ? `<tr><td>CGST (9%)</td><td class="r">${rs(o.cgst)}</td></tr><tr><td>SGST (9%)</td><td class="r">${rs(o.sgst)}</td></tr>`
    : `<tr><td>IGST (18%)</td><td class="r">${rs(o.igst)}</td></tr>`;
  const title = TITLES[o.book_slug] ?? o.book_slug;
  return `<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Tax Invoice ${esc(o.invoice_no)}</title>
<style>body{font-family:Arial,Helvetica,sans-serif;color:#111;margin:0;padding:24px;font-size:13px}.box{max-width:760px;margin:0 auto;border:1px solid #bbb;padding:22px}
h1{font-size:26px;margin:0;text-align:right;letter-spacing:.5px}table{width:100%;border-collapse:collapse;margin-top:14px}td,th{padding:7px 8px;border:1px solid #ddd;text-align:left;vertical-align:top}th{background:#f4f4f4;font-size:12px}.r{text-align:right}.m{color:#555;font-size:12px}.two{display:flex;gap:24px;flex-wrap:wrap}.two>div{flex:1;min-width:240px}.tot{width:55%;margin-left:auto}.tot td{border:0;border-bottom:1px solid #ddd}</style></head><body><div class="box">
<div class="two"><div><b style="font-size:17px">${esc(b.trade_name)}</b><br>${esc(b.display_address ?? "Tamil Nadu, India")}<br>GSTIN: ${esc(b.gstin)}<br>${esc(b.email)}</div><div><h1>TAX INVOICE</h1><div class="m r">Original for recipient</div></div></div>
<table><tr><td><b>Invoice No:</b> ${esc(o.invoice_no)}<br><b>Invoice Date:</b> ${esc(date)}<br><b>Payment ID:</b> ${esc(o.razorpay_payment_id)}</td><td><b>Place of supply:</b> ${esc(o.customer_state)}${code ? " (" + code + ")" : ""}<br><b>Terms:</b> Paid online<br><b>Reverse charge:</b> No</td></tr></table>
<table><tr><td><b>Bill to</b><br><b>${esc(o.customer_name)}</b><br>${o.customer_address ? esc(o.customer_address) + "<br>" : ""}${esc(o.customer_state)}${o.customer_pincode ? " - " + esc(o.customer_pincode) : ""}<br>${esc(o.customer_email)}</td></tr></table>
<table><tr><th>#</th><th>Item &amp; description</th><th>SAC</th><th class="r">Qty</th><th class="r">Rate</th>${taxHead}<th class="r">Amount</th></tr>
<tr><td>1</td><td>${esc(title)}<div class="m">${esc(b.sac_desc)}</div></td><td>${esc(b.sac_code)}</td><td class="r">1</td><td class="r">${rs(o.base_amount)}</td>${taxCells}<td class="r">${rs(o.base_amount)}</td></tr></table>
<table class="tot"><tr><td>Sub total</td><td class="r">${rs(o.base_amount)}</td></tr>${taxRows}<tr><td><b>Total (INR)</b></td><td class="r"><b>${rs(o.amount)}</b></td></tr><tr><td>Payment made</td><td class="r">(-) ${rs(o.amount)}</td></tr><tr><td><b>Balance due</b></td><td class="r"><b>0.00</b></td></tr></table>
<p style="margin-top:14px"><b>Total in words:</b> <i>${esc(inWords(o.amount))}</i></p>
<p class="m" style="margin-top:12px">This is a computer generated invoice and does not require a signature. Online access only; no physical goods are delivered. Refunds as per the Refund Policy at valarodigital.com/refund/.</p>
</div></body></html>`;
}

Deno.serve(async (req) => {
  const body = await req.text();
  const sig = req.headers.get("x-razorpay-signature") ?? "";
  const key = await crypto.subtle.importKey("raw", new TextEncoder().encode(Deno.env.get("RAZORPAY_WEBHOOK_SECRET")!), { name: "HMAC", hash: "SHA-256" }, false, ["sign"]);
  const expected = hex(await crypto.subtle.sign("HMAC", key, new TextEncoder().encode(body)));
  if (expected.length !== sig.length || expected !== sig) return new Response("bad signature", { status: 400 });

  const ev = JSON.parse(body);
  if (ev.event !== "payment.captured" && ev.event !== "order.paid") return new Response("ignored", { status: 200 });

  const pay = ev.payload?.payment?.entity;
  const orderId = pay?.order_id ?? ev.payload?.order?.entity?.id;
  if (!orderId) return new Response("no order", { status: 200 });

  const admin = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
  const { data: order } = await admin.from("orders").select("*").eq("razorpay_order_id", orderId).maybeSingle();
  if (!order) {
    // Not a book order: it may be a shop order (same Razorpay account, same webhook).
    const { data: sorder } = await admin.from("shop_orders").select("*").eq("razorpay_order_id", orderId).maybeSingle();
    if (sorder) return await handleShop(admin, sorder, pay, orderId);
    return new Response("unknown order", { status: 200 });
  }
  if (pay?.amount !== undefined && pay.amount !== order.amount) return new Response("amount mismatch", { status: 200 });

  // Guests have no account until they have paid: create it now (email counts as verified, they still sign in with a code later).
  let uid: string | null = order.user_id ?? null;
  if (!uid) {
    const em = String(order.customer_email ?? "").trim().toLowerCase();
    if (!em) return new Response("no email", { status: 200 });
    const { data: f1 } = await admin.rpc("find_user_id", { p_email: em });
    uid = f1 ?? null;
    if (!uid) {
      const { data: made } = await admin.auth.admin.createUser({ email: em, email_confirm: true });
      uid = made?.user?.id ?? null;
      if (!uid) { const { data: f2 } = await admin.rpc("find_user_id", { p_email: em }); uid = f2 ?? null; }
    }
    if (!uid) return new Response("account failed", { status: 500 }); // Razorpay will retry
    await admin.from("orders").update({ user_id: uid }).eq("razorpay_order_id", orderId);
  }
  await admin.from("orders").update({ status: "paid", razorpay_payment_id: pay?.id ?? null }).eq("razorpay_order_id", orderId);
  await admin.from("entitlements").upsert({ user_id: uid, book_slug: order.book_slug, razorpay_payment_id: pay?.id ?? null });

  // Invoice: issued once per order. A failure here never blocks the unlock above.
  try {
    let o = { ...order, razorpay_payment_id: pay?.id ?? order.razorpay_payment_id };
    if (!o.invoice_no) {
      const now = new Date().toISOString();
      // Atomic: only the first event for this payment gets a number; a second event (payment.captured + order.paid both arrive) stops here.
      const { data: cl, error: ne } = await admin.rpc("claim_invoice_no", { p_order: orderId, p_date: now });
      const c = Array.isArray(cl) ? cl[0] : cl;
      if (ne || !c?.invoice_no) throw new Error("invoice number failed: " + (ne?.message ?? "empty"));
      if (!c.claimed) return new Response("ok", { status: 200 });
      const no = c.invoice_no;
      const base = o.base_amount ?? Math.round(o.amount / 1.18);
      const tax = o.amount - base;
      const intra = !o.customer_state || o.customer_state === "Tamil Nadu";
      const cgst = o.base_amount ? o.cgst : (intra ? Math.floor(tax / 2) : 0);
      const sgst = o.base_amount ? o.sgst : (intra ? tax - Math.floor(tax / 2) : 0);
      const igst = o.base_amount ? o.igst : (intra ? 0 : tax);
      o = { ...o, invoice_no: no, invoice_date: now, base_amount: base, cgst, sgst, igst, customer_name: o.customer_name ?? o.customer_email ?? "Customer", customer_state: o.customer_state ?? "Tamil Nadu" };
      const { data: prof } = await admin.from("business_profile").select("*").eq("id", 1).single();
      const html = invoiceHtml(o, prof);
      const { data: saved } = await admin.from("orders").update({ invoice_no: o.invoice_no, invoice_date: now, invoice_html: html, base_amount: base, cgst, sgst, igst, customer_name: o.customer_name, customer_state: o.customer_state }).eq("razorpay_order_id", orderId).is("invoice_html", null).select("razorpay_order_id");
      if (saved && saved.length) {
        const pass = Deno.env.get("SMTP_PASS");
        if (pass && o.customer_email) {
          const smtp = new SMTPClient({ connection: { hostname: "smtp.hostinger.com", port: 465, tls: true, auth: { username: "hello@valarodigital.com", password: pass } } });
          const intro = `<div style="font-family:Arial,Helvetica,sans-serif;max-width:760px;margin:0 auto 18px;padding:18px;border:1px solid #bbb;border-radius:8px;color:#111;font-size:14px"><p style="margin:0 0 10px"><b>Thank you for your purchase.</b> Your book is ready to read online.</p><p style="margin:0 0 14px">To read it, open My books and sign in with this email address (${esc(o.customer_email)}). We send you a 6-digit login code at that time. You can do this any time you like.</p><p style="margin:0"><a href="https://valarodigital.com/library/" style="display:inline-block;background:#ff6a2b;color:#fff;padding:11px 22px;border-radius:999px;text-decoration:none;font-weight:bold">Open My books</a></p></div>`;
          await smtp.send({ from: "Valarodigital <hello@valarodigital.com>", to: o.customer_email, subject: `Your tax invoice ${o.invoice_no} and your book | Valarodigital`, content: "Thank you for your purchase. To read your book, open https://valarodigital.com/library/ and sign in with this email address. Your tax invoice is below (open it in an HTML-capable mail app, or sign in at valarodigital.com/invoices/).", html: html.replace("<body>", "<body>" + intro) });
          await smtp.close();
          await admin.from("orders").update({ invoice_emailed: true }).eq("razorpay_order_id", orderId);
        }
      }
    }
  } catch (e) {
    console.error("invoice error", e);
  }
  return new Response("ok", { status: 200 });
});
