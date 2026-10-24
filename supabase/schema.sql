-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.book_chapters (
  id bigint generated always as identity primary key,
  book_slug text not null,
  position int not null,
  title text not null,
  content text not null,            -- plain text: blank line = paragraph, "## " = heading, "- " = bullet
  is_sample boolean not null default false,
  unique (book_slug, position)
);

create table if not exists public.orders (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  book_slug text not null,
  razorpay_order_id text not null unique,
  razorpay_payment_id text,
  amount int not null,
  status text not null default 'created',   -- created | paid
  created_at timestamptz not null default now()
);

create table if not exists public.entitlements (
  user_id uuid not null references auth.users(id) on delete cascade,
  book_slug text not null,
  razorpay_payment_id text,
  created_at timestamptz not null default now(),
  primary key (user_id, book_slug)
);

alter table public.book_chapters enable row level security;
alter table public.orders        enable row level security;
alter table public.entitlements  enable row level security;

-- Chapters: free sample for any signed-in user; everything for people who bought the book.
drop policy if exists "read chapters" on public.book_chapters;
create policy "read chapters" on public.book_chapters for select to authenticated
using (
  is_sample
  or exists (select 1 from public.entitlements e
             where e.user_id = auth.uid() and e.book_slug = book_chapters.book_slug)
);

-- Users can see only their own purchase records. Nobody can write from the browser;
-- only the server functions (service role) insert orders and entitlements.
drop policy if exists "own entitlements" on public.entitlements;
create policy "own entitlements" on public.entitlements for select to authenticated using (user_id = auth.uid());
drop policy if exists "own orders" on public.orders;
create policy "own orders" on public.orders for select to authenticated using (user_id = auth.uid());

-- Placeholder sample chapter. Replace with the real chapter once the book file is ready.
insert into public.book_chapters (book_slug, position, title, content, is_sample) values
('ai-agents-tamil', 1, 'Sample chapter (placeholder)',
 E'This is a placeholder for the free sample chapter.\n\n## A heading\n\nThe real chapter text will go here.', true)
on conflict (book_slug, position) do nothing;
