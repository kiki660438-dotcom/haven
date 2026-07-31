create table if not exists staff (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  commission_rate numeric not null default 30,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

alter table orders add column if not exists staff_id uuid references staff(id);

alter table staff enable row level security;

create policy "staff_all_staff" on staff for all to authenticated using (true) with check (true);
