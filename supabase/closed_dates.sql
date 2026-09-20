-- 公休日：客人在這些日期完全約不到，用手動挑選的方式管理
create table if not exists closed_dates (
  id uuid primary key default gen_random_uuid(),
  date date not null unique,
  note text,
  created_at timestamptz not null default now()
);

alter table closed_dates enable row level security;
create policy "staff_all_closed_dates" on closed_dates for all to authenticated using (true) with check (true);
create policy "public_select_closed_dates" on closed_dates for select to anon using (true);
