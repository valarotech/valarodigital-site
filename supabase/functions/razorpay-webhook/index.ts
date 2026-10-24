// Razorpay calls this after a payment. We verify the signature, then unlock the book.
import { createClient } from "npm:@supabase/supabase-js@2";

const hex = (b: ArrayBuffer) => [...new Uint8Array(b)].map((x) => x.toString(16).padStart(2, "0")).join("");

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
  const { data: order } = await admin.from("orders").select("user_id, book_slug, amount").eq("razorpay_order_id", orderId).maybeSingle();
  if (!order) return new Response("unknown order", { status: 200 });
  if (pay?.amount !== undefined && pay.amount !== order.amount) return new Response("amount mismatch", { status: 200 });

  await admin.from("orders").update({ status: "paid", razorpay_payment_id: pay?.id ?? null }).eq("razorpay_order_id", orderId);
  await admin.from("entitlements").upsert({ user_id: order.user_id, book_slug: order.book_slug, razorpay_payment_id: pay?.id ?? null });
  return new Response("ok", { status: 200 });
});
