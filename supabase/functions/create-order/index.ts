// Creates a Razorpay order for the signed-in user. The price is fixed HERE, never taken from the browser.
import { createClient } from "npm:@supabase/supabase-js@2";

// Base prices in paise, fixed on the server. Rs 299 and Rs 199, plus GST added at checkout.
const GST_PERCENT = 18;
const BOOKS: Record<string, number> = { "ai-agents-tamil": 29900, "claude-code-commands-ta": 19900 };
const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) => new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json" } });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  try {
    const url = Deno.env.get("SUPABASE_URL")!;
    const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
    const jwt = (req.headers.get("Authorization") ?? "").replace("Bearer ", "");
    const { data: u, error: ue } = await admin.auth.getUser(jwt);
    if (ue || !u.user) return json({ error: "not signed in" }, 401);

    const { book_slug } = await req.json();
    const base = BOOKS[book_slug];
    if (!base) return json({ error: "unknown book" }, 400);
    const tax = Math.round((base * GST_PERCENT) / 100);
    const amount = base + tax; // total charged, in paise

    const { data: own } = await admin.from("entitlements").select("book_slug").eq("user_id", u.user.id).eq("book_slug", book_slug).maybeSingle();
    if (own) return json({ already: true });

    const keyId = Deno.env.get("RAZORPAY_KEY_ID")!, secret = Deno.env.get("RAZORPAY_KEY_SECRET")!;
    const r = await fetch("https://api.razorpay.com/v1/orders", {
      method: "POST",
      headers: { "Content-Type": "application/json", Authorization: "Basic " + btoa(`${keyId}:${secret}`) },
      body: JSON.stringify({ amount, currency: "INR", receipt: `${book_slug}-${Date.now()}`.slice(0, 40), notes: { user_id: u.user.id, book_slug, base_paise: String(base), gst_paise: String(tax) } }),
    });
    const o = await r.json();
    if (!r.ok) return json({ error: "razorpay" }, 502);

    await admin.from("orders").insert({ user_id: u.user.id, book_slug, razorpay_order_id: o.id, amount });
    return json({ order_id: o.id, amount, key_id: keyId });
  } catch (_e) {
    return json({ error: "server" }, 500);
  }
});
