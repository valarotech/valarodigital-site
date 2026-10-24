// Razorpay calls this after a payment. We verify the signature, unlock the book, then issue a GST invoice.
import { createClient } from "npm:@supabase/supabase-js@2";
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

const hex = (b: ArrayBuffer) => [...new Uint8Array(b)].map((x) => x.toString(16).padStart(2, "0")).join("");
const esc = (v: unknown) => String(v ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]!));
const rs = (paise: number) => (paise / 100).toLocaleString("en-IN", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
const TITLES: Record<string, string> = {
  "ai-agents-tamil": "Tamil AI Agents book (online access)",
  "claude-code-commands-ta": "Claude Code slash commands guide in Tamil (online access)",
};

// deno-lint-ignore no-explicit-any
function invoiceHtml(o: any, b: any): string {
  const date = new Date(o.invoice_date).toLocaleDateString("en-GB", { timeZone: "Asia/Kolkata" }).replace(/\//g, "-");
  const intra = o.igst === 0;
  const taxRows = intra
    ? `<tr><td>CGST @ 9%</td><td class="r">${rs(o.cgst)}</td></tr><tr><td>SGST @ 9%</td><td class="r">${rs(o.sgst)}</td></tr>`
    : `<tr><td>IGST @ 18%</td><td class="r">${rs(o.igst)}</td></tr>`;
  return `<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Tax Invoice ${esc(o.invoice_no)}</title>
<style>body{font-family:Arial,Helvetica,sans-serif;color:#111;margin:0;padding:24px;font-size:14px}.box{max-width:720px;margin:0 auto;border:1px solid #bbb;padding:24px}
h1{font-size:20px;margin:0 0 4px}table{width:100%;border-collapse:collapse;margin-top:14px}td,th{padding:8px;border-bottom:1px solid #ddd;text-align:left;vertical-align:top}.r{text-align:right}.m{color:#555;font-size:12px}.two{display:flex;gap:24px;flex-wrap:wrap}.two>div{flex:1;min-width:240px}</style></head><body><div class="box">
<h1>TAX INVOICE</h1><div class="m">Original for recipient</div>
<div class="two" style="margin-top:14px"><div><b>${esc(b.trade_name)}</b><br>(Legal name: ${esc(b.legal_name)}, Proprietor)<br>${esc(b.address)}<br>GSTIN: ${esc(b.gstin)}<br>${esc(b.email)} | ${esc(b.phone)}</div>
<div><b>Invoice No:</b> ${esc(o.invoice_no)}<br><b>Invoice Date:</b> ${esc(date)}<br><b>Payment ID:</b> ${esc(o.razorpay_payment_id)}<br><b>Reverse charge:</b> No</div></div>
<div style="margin-top:14px"><b>Billed to:</b> ${esc(o.customer_name)}<br>${o.customer_address ? esc(o.customer_address) + "<br>" : ""}${esc(o.customer_email)}${o.customer_mobile ? " | +91 " + esc(o.customer_mobile) : ""}<br><b>Place of supply:</b> ${esc(o.customer_state)}${o.customer_pincode ? " - " + esc(o.customer_pincode) : ""}</div>
<table><tr><th>Description</th><th>SAC</th><th class="r">Taxable value (INR)</th></tr>
<tr><td>${esc(TITLES[o.book_slug] ?? o.book_slug)}<div class="m">${esc(b.sac_desc)}</div></td><td>${esc(b.sac_code)}</td><td class="r">${rs(o.base_amount)}</td></tr></table>
<table><tr><td>Taxable value</td><td class="r">${rs(o.base_amount)}</td></tr>${taxRows}<tr><td><b>Total (INR)</b></td><td class="r"><b>${rs(o.amount)}</b></td></tr></table>
<p class="m" style="margin-top:16px">This is a computer generated invoice and does not require a signature. Online access only; no physical goods are delivered. Refunds as per the Refund Policy at valarodigital.com/refund/.</p>
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
  if (!order) return new Response("unknown order", { status: 200 });
  if (pay?.amount !== undefined && pay.amount !== order.amount) return new Response("amount mismatch", { status: 200 });

  await admin.from("orders").update({ status: "paid", razorpay_payment_id: pay?.id ?? null }).eq("razorpay_order_id", orderId);
  await admin.from("entitlements").upsert({ user_id: order.user_id, book_slug: order.book_slug, razorpay_payment_id: pay?.id ?? null });

  // Invoice: issued once per order. A failure here never blocks the unlock above.
  try {
    let o = { ...order, razorpay_payment_id: pay?.id ?? order.razorpay_payment_id };
    if (!o.invoice_no) {
      const now = new Date().toISOString();
      const { data: no } = await admin.rpc("next_invoice_no", { p_date: now });
      const base = o.base_amount ?? Math.round(o.amount / 1.18);
      const tax = o.amount - base;
      const intra = !o.customer_state || o.customer_state === "Tamil Nadu";
      const cgst = o.base_amount ? o.cgst : (intra ? Math.floor(tax / 2) : 0);
      const sgst = o.base_amount ? o.sgst : (intra ? tax - Math.floor(tax / 2) : 0);
      const igst = o.base_amount ? o.igst : (intra ? 0 : tax);
      o = { ...o, invoice_no: no, invoice_date: now, base_amount: base, cgst, sgst, igst, customer_name: o.customer_name ?? o.customer_email ?? "Customer", customer_state: o.customer_state ?? "Tamil Nadu" };
      const { data: prof } = await admin.from("business_profile").select("*").eq("id", 1).single();
      const html = invoiceHtml(o, prof);
      const { data: saved } = await admin.from("orders").update({ invoice_no: o.invoice_no, invoice_date: now, invoice_html: html, base_amount: base, cgst, sgst, igst, customer_name: o.customer_name, customer_state: o.customer_state }).eq("razorpay_order_id", orderId).is("invoice_no", null).select("razorpay_order_id");
      if (saved && saved.length) {
        const pass = Deno.env.get("SMTP_PASS");
        if (pass && o.customer_email) {
          const smtp = new SMTPClient({ connection: { hostname: "smtp.hostinger.com", port: 465, tls: true, auth: { username: "hello@valarodigital.com", password: pass } } });
          await smtp.send({ from: "Valarodigital <hello@valarodigital.com>", to: o.customer_email, subject: `Your tax invoice ${o.invoice_no} | Valarodigital`, content: "Your tax invoice is below. Open it in an HTML-capable mail app, or sign in at valarodigital.com/invoices/ to view and print it.", html });
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
