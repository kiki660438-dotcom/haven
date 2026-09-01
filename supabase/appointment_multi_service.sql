create table if not exists appointment_services (
  id uuid primary key default gen_random_uuid(),
  appointment_id uuid not null references appointments(id) on delete cascade,
  service_id uuid not null references services(id)
);

alter table appointment_services enable row level security;

create policy "staff_all_appointment_services" on appointment_services for all to authenticated using (true) with check (true);
create policy "public_select_appointment_services" on appointment_services for select to anon using (true);
create policy "public_insert_appointment_services" on appointment_services for insert to anon with check (true);
