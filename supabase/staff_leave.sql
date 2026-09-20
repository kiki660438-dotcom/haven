-- 請假/排休：取代原本的 closed_dates（整天公休），改成可以指定「某位設計師」或「全門店」、
-- 可以整天或只擋某個時段，取代之前太簡單的公休日設定
create table if not exists staff_leave (
  id uuid primary key default gen_random_uuid(),
  staff_id uuid references staff(id) on delete cascade,
  start_date date not null,
  end_date date not null,
  all_day boolean not null default true,
  start_time time,
  end_time time,
  note text,
  created_at timestamptz not null default now()
);

alter table staff_leave enable row level security;
create policy "staff_all_staff_leave" on staff_leave for all to authenticated using (true) with check (true);
create policy "public_select_staff_leave" on staff_leave for select to anon using (true);
