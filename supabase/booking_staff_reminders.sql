alter table appointments add column if not exists staff_id uuid references staff(id);
alter table appointments add column if not exists reminder_sent_at timestamptz;

-- 讓客人在 /book 選「指定設計師」時看得到在職員工名單（只給姓名，不會洩漏抽成%等內部資料）
create policy "public_select_active_staff" on staff for select to anon using (active = true);

create or replace function public.reschedule_own_appointment(
  p_appointment_id uuid,
  p_customer_id uuid,
  p_start_time timestamptz
)
returns void
language sql
security definer
set search_path = public
as $$
  update appointments
  set start_time = p_start_time, status = 'pending'
  where id = p_appointment_id
    and customer_id = p_customer_id
    and status not in ('completed', 'cancelled');
$$;

grant execute on function public.reschedule_own_appointment(uuid, uuid, timestamptz) to anon;

-- 給每天自動提醒用的排程 (cron) 讀取「明天有哪些預約需要提醒」，
-- 用 security definer 讓這支排程可以查到 customers.line_user_id，
-- 但不需要開放 customers 表整個給 anon 讀取
create or replace function public.get_appointments_needing_reminder(p_start timestamptz, p_end timestamptz)
returns table (
  appointment_id uuid,
  start_time timestamptz,
  service_name text,
  line_user_id text
)
language sql
security definer
set search_path = public
as $$
  select a.id, a.start_time, s.name, c.line_user_id
  from appointments a
  join services s on s.id = a.service_id
  join customers c on c.id = a.customer_id
  where a.status in ('pending', 'confirmed')
    and a.reminder_sent_at is null
    and c.line_user_id is not null
    and a.start_time >= p_start
    and a.start_time <= p_end;
$$;

grant execute on function public.get_appointments_needing_reminder(timestamptz, timestamptz) to anon;

create or replace function public.mark_reminder_sent(p_appointment_id uuid)
returns void
language sql
security definer
set search_path = public
as $$
  update appointments set reminder_sent_at = now() where id = p_appointment_id;
$$;

grant execute on function public.mark_reminder_sent(uuid) to anon;
