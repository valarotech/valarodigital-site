# Backend setup (Supabase + Razorpay)

Secrets (Razorpay Key Secret, webhook secret) live ONLY in Supabase -> Edge Functions -> Secrets. Never commit them.

2. Authentication -> Email Templates -> "Magic Link": make the body show the code: `Your code is {{ .Token }}`.
3. Authentication -> URL Configuration: Site URL `https://valarodigital.com`.
4. Authentication -> SMTP: add a real SMTP sender. The built-in one allows only a few emails per hour.
5. Edge Functions: deploy `create-order` (JWT verification on) and `razorpay-webhook` (JWT verification OFF).
6. Edge Functions -> Secrets: `RAZORPAY_KEY_ID`, `RAZORPAY_KEY_SECRET`, `RAZORPAY_WEBHOOK_SECRET`.
7. Razorpay -> Webhooks: URL `https://<project>.supabase.co/functions/v1/razorpay-webhook`, events `payment.captured` and `order.paid`, secret = the same value as `RAZORPAY_WEBHOOK_SECRET`.
