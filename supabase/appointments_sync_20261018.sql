-- 依神美 10/18 夜間匯出的預約記錄，同步三處差異
do $do$
declare
  v_customer_id uuid;
  v_appointment_id uuid;
begin
  -- 1) 吳婷喻 10/25 17:30：客人在神美取消了，Haven 也取消（客人自己取消，不通知）
  update appointments set status = 'cancelled'
  where customer_id in (select id from customers where phone = '0931200940')
    and start_time = '2026-10-25T17:30:00+08:00' and status <> 'cancelled';

  -- 2) 黃佩琪 10/23 10:00 蘊髮再生療程12堂（用商品券預約，神美手機APP 10/18 21:33 建立）
  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-23T10:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, created_at)
    values (v_customer_id, '31dea312-e081-4912-b2d4-db06c452c801', '2026-10-23T10:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '2026-10-18T21:33:00+08:00')
    returning id into v_appointment_id;
  end if;

  -- 3) 吳婷喻 10/31 18:00 剪髮（神美 LINE 10/18 20:29 建立，取代原本 10/25 那筆）
  select id into v_customer_id from customers where phone = '0931200940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷喻', '0931200940') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-31T18:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, created_at)
    values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-31T18:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '2026-10-18T20:29:00+08:00')
    returning id into v_appointment_id;
  end if;
end
$do$;

select to_char(a.start_time at time zone 'Asia/Taipei', 'MM/DD HH24:MI') as 預約時間, c.name as 客人, a.status as 狀態, a.party_size as 人數
from appointments a join customers c on c.id = a.customer_id
where a.start_time >= '2026-10-23T00:00:00+08:00' and a.start_time < '2026-11-01T00:00:00+08:00'
  and a.status <> 'cancelled' and a.start_time in ('2026-10-23T10:00:00+08:00','2026-10-25T17:30:00+08:00','2026-10-31T18:00:00+08:00')
order by a.start_time;
