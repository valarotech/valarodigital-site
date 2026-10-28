// Free Business Consultation: validation, spam checks and the request handler.
// No imports on purpose: index.ts supplies the database, the mailer and the clock, so this file can be tested without a server.

export const SERVICES = [
  "Business website", "Google Business Profile", "WhatsApp Business automation", "Business email & Google Workspace",
  "Workflow automation", "Online booking & appointments", "AI chatbot in Tamil & English", "Sales & stock dashboards",
  "IT care plan", "Workshops for colleges & teams", "Valarodigital Billing (early list)", "Android app development",
  "Custom software", "Get Online package", "Grow & Automate package", "Valarodigital Care plan",
  "DevOps / AWS online training", "Something else",
];

// The exact sentence the visitor agreed to. It is stored with every enquiry as proof of what they consented to.
export const CONSENT_TEXT =
  "I agree that Valarodigital (Valaro Enterprises) may contact me by phone, WhatsApp and email about my enquiry, and may store the details I entered for that purpose. I have read the Privacy Policy.";

export type Clean = { name: string; mobile: string; email: string; service: string; details: string | null };
export type Result = { ok: true; value: Clean } | { ok: false; errors: Record<string, string> };

const CTRL = /[\u0000-\u0008\u000B\u000C\u000E-\u001F\u007F\u2028\u2029]/g;

export function validate(b: Record<string, unknown>): Result {
  const errors: Record<string, string> = {};
  const str = (v: unknown) => (typeof v === "string" ? v : "");

  const name = str(b.name).replace(CTRL, "").replace(/\s+/g, " ").trim();
  if (name.length < 2 || name.length > 100 || !/^[\p{L}\p{M}][\p{L}\p{M} .'’-]*$/u.test(name)) errors.name = "Please enter your name (letters only).";

  const mobile = str(b.mobile).replace(/[\s-]/g, "").replace(/^(\+91|91|0)(?=[6-9][0-9]{9}$)/, "");
  if (!/^[6-9][0-9]{9}$/.test(mobile)) errors.mobile = "Please enter a valid 10-digit mobile number.";

  const email = str(b.email).trim().toLowerCase();
  const at = email.indexOf("@");
  if (email.length > 254 || at < 1 || at > 64 || !/^[a-z0-9._%+-]+@[a-z0-9-]+(\.[a-z0-9-]+)+$/.test(email) || email.includes("..")) errors.email = "Please enter a valid email address.";

  const service = str(b.service).trim();
  if (!SERVICES.includes(service)) errors.service = "Please choose a service.";

  let details: string | null = str(b.details).replace(CTRL, "").replace(/\r\n?/g, "\n").trim();
  if (details.length > 1000) errors.details = "Please keep your note under 1000 characters.";
  else if ((details.match(/https?:\/\/|www\./gi) ?? []).length > 1) errors.details = "Please do not add links.";
  if (!details) details = null;

  if (b.consent !== true) errors.consent = "Please tick the box so we can contact you.";

  return Object.keys(errors).length ? { ok: false, errors } : { ok: true, value: { name, mobile, email, service, details } };
}

export const esc = (v: unknown) => String(v ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]!));

export interface Deps {
  allowedOrigins: string[];
  now: () => Date;
  hash: (s: string) => Promise<string>;
  countRecent: (filter: { field: "ip_hash" | "mobile"; value: string } | null, sinceIso: string) => Promise<number>;
  insert: (row: Record<string, unknown>) => Promise<string>; // returns the new id; throws on failure
  markEmailed: (id: string) => Promise<void>;
  sendMail: (subject: string, text: string, html: string) => Promise<void>;
  log: (msg: string) => void;
}

const LIMITS = { perIpHour: 5, perMobileDay: 3, globalHour: 60, minFillMs: 2000, maxBody: 6000 };

export async function handleLead(req: Request, d: Deps): Promise<Response> {
  const origin = req.headers.get("origin");
  const originOk = !origin || d.allowedOrigins.includes(origin);
  const cors: Record<string, string> = { "Vary": "Origin", "Access-Control-Allow-Methods": "POST, OPTIONS", "Access-Control-Allow-Headers": "content-type" };
  if (origin && originOk) cors["Access-Control-Allow-Origin"] = origin;
  const json = (b: unknown, s = 200) => new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json", "Cache-Control": "no-store" } });

  if (req.method === "OPTIONS") return new Response(null, { status: originOk ? 204 : 403, headers: cors });
  if (req.method !== "POST") return json({ ok: false }, 405);
  if (!originOk) return json({ ok: false }, 403);

  const raw = await req.text();
  if (raw.length > LIMITS.maxBody) return json({ ok: false }, 413);
  let body: Record<string, unknown>;
  try { body = JSON.parse(raw); if (!body || typeof body !== "object" || Array.isArray(body)) throw 0; } catch { return json({ ok: false }, 400); }

  // Spam traps. A bot that fills the hidden field, or submits faster than a person can type, gets a fake "ok" and nothing is stored.
  if (typeof body.website === "string" && body.website.trim() !== "") return json({ ok: true });
  if (typeof body.t !== "number" || !isFinite(body.t)) return json({ ok: false }, 400);
  if (body.t < LIMITS.minFillMs) return json({ ok: true });

  const v = validate(body);
  if (!v.ok) return json({ ok: false, errors: v.errors }, 422);
  const c = v.value;

  const fwd = (req.headers.get("cf-connecting-ip") ?? req.headers.get("x-forwarded-for") ?? "").split(",")[0].trim();
  const ipHash = (await d.hash(fwd || "unknown")).slice(0, 32);
  const now = d.now();
  const iso = (ms: number) => new Date(now.getTime() - ms).toISOString();
  try {
    if ((await d.countRecent({ field: "ip_hash", value: ipHash }, iso(3600e3))) >= LIMITS.perIpHour) return json({ ok: false, error: "busy" }, 429);
    if ((await d.countRecent({ field: "mobile", value: c.mobile }, iso(86400e3))) >= LIMITS.perMobileDay) return json({ ok: false, error: "busy" }, 429);
    if ((await d.countRecent(null, iso(3600e3))) >= LIMITS.globalHour) return json({ ok: false, error: "busy" }, 429);
  } catch (e) { d.log("rate check failed: " + e); return json({ ok: false }, 500); }

  const page = typeof body.page === "string" ? body.page.slice(0, 200) : null;
  let id: string;
  try {
    id = await d.insert({
      name: c.name, mobile: c.mobile, email: c.email, service: c.service, details: c.details,
      consent: true, consent_text: CONSENT_TEXT, consent_at: now.toISOString(),
      source_page: page, ip_hash: ipHash, user_agent: (req.headers.get("user-agent") ?? "").slice(0, 300) || null,
    });
  } catch (e) { d.log("insert failed: " + e); return json({ ok: false }, 500); }

  // The enquiry is already saved. An email problem must never lose it or show the visitor an error.
  try {
    const lines = [`Name: ${c.name}`, `Mobile: ${c.mobile}`, `Email: ${c.email}`, `Service: ${c.service}`, `Note: ${c.details ?? "-"}`, `Consent: yes, given ${now.toISOString()}`, `Page: ${page ?? "-"}`];
    const html = `<div style="font-family:Arial,Helvetica,sans-serif;font-size:14px;color:#111"><p><b>New Free Business Consultation request</b></p><table cellpadding="6" style="border-collapse:collapse">` +
      [["Name", c.name], ["Mobile", c.mobile], ["Email", c.email], ["Service", c.service], ["Note", c.details ?? "-"], ["Consent", "Yes, given " + now.toISOString()], ["Page", page ?? "-"]]
        .map(([k, val]) => `<tr><td style="border:1px solid #ddd"><b>${k}</b></td><td style="border:1px solid #ddd;white-space:pre-wrap">${esc(val)}</td></tr>`).join("") +
      `</table><p style="color:#555">Call or WhatsApp them within one business day. Saved in Supabase: consultation_leads.</p></div>`;
    await d.sendMail(`New consultation request: ${c.service} (${c.name.slice(0, 40)})`, lines.join("\n"), html);
    await d.markEmailed(id);
  } catch (e) { d.log("notify email failed: " + e); }

  return json({ ok: true });
}
