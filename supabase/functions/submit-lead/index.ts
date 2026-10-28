// Free Business Consultation form. Validates, blocks spam, saves the enquiry and emails the owner.
// Deploy with JWT verification OFF (visitors are not signed in). Secrets: SMTP_PASS (already set for invoices).
// Optional secrets: TURNSTILE_SECRET (Cloudflare Turnstile secret key; while unset the check is skipped), LEAD_NOTIFY_TO (default below), LEAD_HASH_SALT (any random text), LEAD_ALLOWED_ORIGINS (comma separated).
import { createClient } from "npm:@supabase/supabase-js@2";
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";
import { handleLead } from "./lead-core.ts";

const admin = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
const NOTIFY_TO = Deno.env.get("LEAD_NOTIFY_TO") ?? "valaroenterprises@gmail.com";
const SALT = Deno.env.get("LEAD_HASH_SALT") ?? "valarodigital";
const ORIGINS = (Deno.env.get("LEAD_ALLOWED_ORIGINS") ?? "https://valarodigital.com,https://www.valarodigital.com").split(",").map((s) => s.trim()).filter(Boolean);
const TURNSTILE_SECRET = Deno.env.get("TURNSTILE_SECRET");
const mailer = () => new SMTPClient({ connection: { hostname: "smtp.hostinger.com", port: 465, tls: true, auth: { username: "hello@valarodigital.com", password: Deno.env.get("SMTP_PASS")! } } });
const hex = (b: ArrayBuffer) => [...new Uint8Array(b)].map((x) => x.toString(16).padStart(2, "0")).join("");

Deno.serve((req) =>
  handleLead(req, {
    allowedOrigins: ORIGINS,
    now: () => new Date(),
    hash: async (s) => hex(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(SALT + "|" + s))),
    countRecent: async (f, since) => {
      let q = admin.from("consultation_leads").select("id", { count: "exact", head: true }).gte("created_at", since);
      if (f) q = q.eq(f.field, f.value);
      const { count, error } = await q;
      if (error) throw new Error(error.message);
      return count ?? 0;
    },
    insert: async (row) => {
      const { data, error } = await admin.from("consultation_leads").insert(row).select("id").single();
      if (error || !data) throw new Error(error?.message ?? "no row");
      return data.id as string;
    },
    markEmailed: async (id) => { await admin.from("consultation_leads").update({ emailed: true }).eq("id", id); },
    sendMail: async (subject, text, html) => {
      const pass = Deno.env.get("SMTP_PASS");
      if (!pass) throw new Error("SMTP_PASS not set");
      const smtp = new SMTPClient({ connection: { hostname: "smtp.hostinger.com", port: 465, tls: true, auth: { username: "hello@valarodigital.com", password: pass } } });
      try { await smtp.send({ from: "Valarodigital Leads <hello@valarodigital.com>", to: NOTIFY_TO, subject, content: text, html }); } finally { await smtp.close(); }
    },
    sendConfirm: async (to, subject, text, html) => {
      if (!Deno.env.get("SMTP_PASS")) throw new Error("SMTP_PASS not set");
      const smtp = mailer();
      try { await smtp.send({ from: "Valarodigital <hello@valarodigital.com>", to, subject, content: text, html }); } finally { await smtp.close(); }
    },
    verifyCaptcha: TURNSTILE_SECRET ? async (token, ip) => {
      const form = new URLSearchParams({ secret: TURNSTILE_SECRET, response: token });
      if (ip) form.set("remoteip", ip);
      const r = await fetch("https://challenges.cloudflare.com/turnstile/v0/siteverify", { method: "POST", body: form });
      const j = await r.json();
      return j.success === true;
    } : undefined,
    log: (m) => console.error(m),
  })
);
