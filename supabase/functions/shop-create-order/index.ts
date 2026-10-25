// Creates a Razorpay order for the shop. Prices, GST rates and shipping are fixed HERE (from shop_products), never taken from the browser.
// Product prices are GST-inclusive. Shipping: Rs 50 inside Tamil Nadu, Rs 80 to other states (GST-inclusive, taxed at the highest rate in the cart).
import { createClient } from "npm:@supabase/supabase-js@2";

const SHIP_TN = 5000, SHIP_OTHER = 8000; // paise
const STATES = ["Andaman and Nicobar Islands","Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh","Chhattisgarh","Dadra and Nagar Haveli and Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Ladakh","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) => new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json" } });

// One invoice line from a GST-inclusive amount. Same state as the seller (Tamil Nadu): CGST + SGST, otherwise IGST.
function splitLine(inclPaise: number, rate: number, intra: boolean) {
  const base = Math.round((inclPaise * 100) / (100 + rate));
  const tax = inclPaise - base;
  const cgst = intra ? Math.floor(tax / 2) : 0;
  const sgst = intra ? tax - cgst : 0;
  const igst = intra ? 0 : tax;
  return { incl: inclPaise, base, rate, cgst, sgst, igst };
}

// deno-lint-ignore no-explicit-any
function priceOrder(cart: { id: string; qty: number }[], products: Record<string, any>, state: string) {
  const intra = state === "Tamil Nadu";
  let maxRate = 0;
  const lines = cart.map((c) => {
    const p = products[c.id];
    const l = splitLine(p.price_paise * c.qty, Number(p.gst_percent), intra);
    maxRate = Math.max(maxRate, l.rate);
    return { id: c.id, name: p.name, hsn: p.hsn, qty: c.qty, unit_incl: p.price_paise, ...l };
  });
  const goods = lines.reduce((t, l) => t + l.incl, 0);
  const shipIncl = intra ? SHIP_TN : SHIP_OTHER;
  const ship = { id: "shipping", name: "Shipping charges", hsn: "9965", qty: 1, unit_incl: shipIncl, ...splitLine(shipIncl, maxRate, intra) };
  const all = [...lines, ship];
  const sum = (k: "base" | "cgst" | "sgst" | "igst") => all.reduce((t, l) => t + l[k], 0);
  return { lines: all, goods, shipping: shipIncl, amount: goods + shipIncl, base_total: sum("base"), cgst: sum("cgst"), sgst: sum("sgst"), igst: sum("igst") };
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  try {
    const admin = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
    const b = await req.json();
    const name = String(b.customer_name ?? "").trim().slice(0, 100);
    if (name.length < 2) return json({ error: "name required" }, 400);
    const em = String(b.customer_email ?? "").trim().toLowerCase();
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(em) || em.length > 200) return json({ error: "email required" }, 400);
    const mobile = String(b.customer_mobile ?? "").replace(/[\s-]/g, "").replace(/^(\+91|91|0)(?=[6-9][0-9]{9}$)/, "");
    if (!/^[6-9][0-9]{9}$/.test(mobile)) return json({ error: "mobile required" }, 400);
    const state = String(b.customer_state ?? "");
    if (!STATES.includes(state)) return json({ error: "state required" }, 400);
    const pin = String(b.customer_pincode ?? "").trim();
    if (!/^[1-9][0-9]{5}$/.test(pin)) return json({ error: "pincode required" }, 400);
    const addr = String(b.customer_address ?? "").trim().slice(0, 400);
    if (addr.length < 8) return json({ error: "address required" }, 400);

    // Cart: merge duplicates, whole quantities only.
    const merged: Record<string, number> = {};
    for (const it of Array.isArray(b.items) ? b.items.slice(0, 30) : []) {
      const q = Math.floor(Number(it?.qty));
      if (!it?.id || !(q >= 1)) return json({ error: "bad cart" }, 400);
      merged[String(it.id)] = (merged[String(it.id)] ?? 0) + q;
    }
    const ids = Object.keys(merged);
    if (!ids.length) return json({ error: "empty cart" }, 400);
    const { data: rows } = await admin.from("shop_products").select("*").in("id", ids).eq("active", true);
    const products: Record<string, any> = {}; // deno-lint-ignore no-explicit-any
    for (const r of rows ?? []) products[r.id] = r;
    for (const id of ids) {
      const p = products[id];
      if (!p) return json({ error: "unknown product", id }, 400);
      if (!p.rate_confirmed) return json({ error: "not open" }, 409); // GST rate not yet confirmed: ordering stays closed for this product
      if (merged[id] > p.max_qty) return json({ error: "too many", id }, 400);
    }
    const priced = priceOrder(ids.map((id) => ({ id, qty: merged[id] })), products, state);

    const keyId = Deno.env.get("RAZORPAY_KEY_ID")!, secret = Deno.env.get("RAZORPAY_KEY_SECRET")!;
    const r = await fetch("https://api.razorpay.com/v1/orders", {
      method: "POST",
      headers: { "Content-Type": "application/json", Authorization: "Basic " + btoa(`${keyId}:${secret}`) },
      body: JSON.stringify({ amount: priced.amount, currency: "INR", receipt: `shop-${Date.now()}`.slice(0, 40), notes: { kind: "shop", items: String(ids.length) } }),
    });
    const o = await r.json();
    if (!r.ok) return json({ error: "razorpay" }, 502);

    const { error: ie } = await admin.from("shop_orders").insert({
      razorpay_order_id: o.id, customer_name: name, customer_email: em, customer_mobile: mobile, customer_state: state, customer_pincode: pin, ship_address: addr,
      items: priced.lines, goods_paise: priced.goods, shipping_paise: priced.shipping, amount: priced.amount,
      base_total: priced.base_total, cgst: priced.cgst, sgst: priced.sgst, igst: priced.igst,
    });
    if (ie) return json({ error: "save" }, 500);
    return json({ order_id: o.id, amount: priced.amount, shipping: priced.shipping, key_id: keyId });
  } catch (_e) {
    return json({ error: "server" }, 500);
  }
});
