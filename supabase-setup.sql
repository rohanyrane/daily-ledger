-- Daily Ledger — Supabase setup
-- Paste this whole file into your Supabase project's SQL Editor and press Run.

create table if not exists public.ledger (
  space      text primary key,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.ledger enable row level security;

-- The site is public and has no login, so the anonymous role needs read/write.
-- Your rows are separated by the `space` value you type into Sync settings —
-- treat that name like a password: anyone who knows it can read that ledger.
drop policy if exists "ledger anon read"   on public.ledger;
drop policy if exists "ledger anon insert" on public.ledger;
drop policy if exists "ledger anon update" on public.ledger;

create policy "ledger anon read"   on public.ledger for select to anon using (true);
create policy "ledger anon insert" on public.ledger for insert to anon with check (true);
create policy "ledger anon update" on public.ledger for update to anon using (true) with check (true);
-- Note: no delete policy — nothing on the site can drop a ledger row.
