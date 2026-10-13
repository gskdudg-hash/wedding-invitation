-- Supabase SQL Editor에서 한 번 실행하세요.
create extension if not exists pgcrypto;
create table if not exists public.rsvps (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) between 1 and 80),
  attendance text not null check (attendance in ('yes','no')),
  guest_count integer not null default 1 check (guest_count between 1 and 5),
  message text check (message is null or char_length(message) <= 1000),
  privacy_consent boolean not null default false check (privacy_consent = true),
  privacy_notice_version text not null,
  created_at timestamptz not null default now()
);
alter table public.rsvps enable row level security;
revoke all on public.rsvps from anon, authenticated;
grant insert (name, attendance, guest_count, message, privacy_consent, privacy_notice_version) on public.rsvps to anon, authenticated;
grant select, delete on public.rsvps to authenticated;
drop policy if exists "Guests can submit RSVP" on public.rsvps;
create policy "Guests can submit RSVP" on public.rsvps for insert to anon, authenticated with check (privacy_consent = true);

-- 관리자 계정은 Supabase Authentication에서 만든 뒤, 아래에 그 사용자의 UUID를 넣어 실행하세요.
create table if not exists public.invitation_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.invitation_admins enable row level security;
revoke all on public.invitation_admins from anon, authenticated;
grant select on public.invitation_admins to authenticated;
drop policy if exists "Admins can read their own admin record" on public.invitation_admins;
create policy "Admins can read their own admin record" on public.invitation_admins for select to authenticated using (user_id = auth.uid());
drop policy if exists "Admins can read RSVP" on public.rsvps;
create policy "Admins can read RSVP" on public.rsvps for select to authenticated using (exists (select 1 from public.invitation_admins a where a.user_id = auth.uid()));
drop policy if exists "Admins can delete RSVP" on public.rsvps;
create policy "Admins can delete RSVP" on public.rsvps for delete to authenticated using (exists (select 1 from public.invitation_admins a where a.user_id = auth.uid()));
