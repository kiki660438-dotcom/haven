create table fixed_expenses (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  amount integer not null,
  note text,
  expense_date date not null default current_date,
  created_at timestamptz not null default now()
);

alter table fixed_expenses enable row level security;

create policy "staff_all_fixed_expenses" on fixed_expenses for all to authenticated using (true) with check (true);
