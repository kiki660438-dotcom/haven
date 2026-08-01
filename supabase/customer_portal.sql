create policy "public_select_vouchers" on vouchers for select to anon using (true);

create or replace function public.cancel_own_appointment(p_appointment_id uuid, p_customer_id uuid)
returns void
language sql
security definer
set search_path = public
as $$
  update appointments
  set status = 'cancelled'
  where id = p_appointment_id
    and customer_id = p_customer_id
    and status not in ('completed', 'cancelled');
$$;

grant execute on function public.cancel_own_appointment(uuid, uuid) to anon;
