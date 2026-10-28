# Backend setup (Supabase + Razorpay)

Secrets (Razorpay Key Secret, webhook secret) live ONLY in Supabase -> Edge Functions -> Secrets. Never commit them.

2. Authentication -> Email Templates -> "Magic Link": make the body show the code: `Your code is {{ .Token }}`.
3. Authentication -> URL Configuration: Site URL `https://valarodigital.com`.
4. Authentication -> SMTP: add a real SMTP sender. The built-in one allows only a few emails per hour.
5. Edge Functions: deploy `create-order` (JWT verification on) and `razorpay-webhook` (JWT verification OFF).
6. Edge Functions -> Secrets: `RAZORPAY_KEY_ID`, `RAZORPAY_KEY_SECRET`, `RAZORPAY_WEBHOOK_SECRET`.
7. Razorpay -> Webhooks: URL `https://<project>.supabase.co/functions/v1/razorpay-webhook`, events `payment.captured` and `order.paid`, secret = the same value as `RAZORPAY_WEBHOOK_SECRET`.

## Free Business Consultation form (submit-lead)
Not live until you do these steps, in this order:
1. Run `supabase/leads.sql` once in the Supabase SQL editor. It creates `consultation_leads` with Row Level Security ON and no public access.
2. Deploy the edge function `submit-lead` (files `index.ts` and `lead-core.ts`) with JWT verification OFF. It reuses the existing `SMTP_PASS` secret.
3. Optional secrets: `LEAD_NOTIFY_TO` (where the alert email goes, default valaroenterprises@gmail.com), `LEAD_HASH_SALT` (any long random text), `LEAD_ALLOWED_ORIGINS`.
4. Then publish the site files (homepage, `assets/js/main.js`, CSS, privacy page).
View enquiries in Supabase -> Table Editor -> `consultation_leads`. The `status` column (new, contacted, won, lost, spam) is for your own follow-up tracking.
