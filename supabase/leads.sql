-- Free Business Consultation enquiries.
-- Written ONLY by the submit-lead edge function (service role). The browser can neither read nor write this table.
-- Run once in the Supabase SQL editor (safe to run again).

create table if not exists public.consultation_leads (
  id           uuid primary key default gen_random_uuid(),
  created_at   timestamptz not null default now(),
  name         text not null check (char_length(name) between 2 and 100),
  mobile       text not null check (mobile ~ '^[6-9][0-9]{9}$'),
  email        text not null check (char_length(email) between 5 and 254),
  service      text not null check (char_length(service) between 2 and 80),
  details      text check (details is null or char_length(details) <= 1000),
  consent      boolean not null check (consent = true),
  consent_text text not null,
  consent_at   timestamptz not null default now(),
  source_page  text check (source_page is null or char_length(source_page) <= 200),
  ip_hash      text,
  user_agent   text check (user_agent is null or char_length(user_agent) <= 300),
  status       text not null default 'new' check (status in ('new','contacted','won','lost','spam')),
  emailed      boolean not null default false
);

create index if not exists consultation_leads_created_idx on public.consultation_leads (created_at desc);
create index if not exists consultation_leads_ip_idx      on public.consultation_leads (ip_hash, created_at desc);
create index if not exists consultation_leads_mobile_idx  on public.consultation_leads (mobile, created_at desc);

-- Row Level Security ON with NO policies = nobody using the public (anon) or signed-in keys can touch it.
-- The service role used by the edge function bypasses RLS.
alter table public.consultation_leads enable row level security;
revoke all on public.consultation_leads from anon, authenticated;
