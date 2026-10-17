-- 補進神美 10/17 之後、Haven 還沒有的預約（共 21 筆，依神美 10/16 匯出的預約記錄）
-- 可重複執行：同一位客人同一時間已經有預約就不會再新增
do $do$
declare
  v_customer_id uuid;
  v_appointment_id uuid;
  n_new int := 0;
begin
  -- 2026-10-17 13:30 陳（神美：剪髮）
  select id into v_customer_id from customers where phone = '0931278005';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳', '0931278005') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-17T13:30:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-17T13:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-19 17:00 謝依潔（神美：染髮(及肩)）
  select id into v_customer_id from customers where phone = '0912147891';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝依潔', '0912147891') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-19T17:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-19T17:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '想調整髮色') returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c');
    n_new := n_new + 1;
  end if;

  -- 2026-10-19 18:00 林子禹（神美：剪髮）
  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-19T18:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-19T18:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-21 10:00 黃玉瑄（神美：蘊髮再生療程）
  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-21T10:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '7e5aad3f-430f-4cf7-87b4-9f443193e799', '2026-10-21T10:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '7e5aad3f-430f-4cf7-87b4-9f443193e799');
    n_new := n_new + 1;
  end if;

  -- 2026-10-21 16:00 曾愛（神美：燙瀏海（價錢依現場判斷））
  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-21T16:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a6bec99b-d689-43d3-87b2-2a6e6875c64d', '2026-10-21T16:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'a6bec99b-d689-43d3-87b2-2a6e6875c64d');
    n_new := n_new + 1;
  end if;

  -- 2026-10-21 18:00 陳守倫（神美：剪髮）
  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-21T18:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-21T18:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-23 13:00 許欣怡（神美：染髮(及肩)）
  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-23T13:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-23T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c');
    n_new := n_new + 1;
  end if;

  -- 2026-10-23 15:00 彭婉婷（神美：剪髮）
  select id into v_customer_id from customers where phone = '0989327585';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭婉婷', '0989327585') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-23T15:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-23T15:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-23 16:00 陳怡安（神美：溫塑燙(及肩)）
  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-23T16:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-23T16:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '伶伶') returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce');
    n_new := n_new + 1;
  end if;

  -- 2026-10-24 11:00 王藝錚（神美：染髮(短髮),剪髮）
  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-24T11:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a603a563-fe64-414f-a819-e0429da258a5', '2026-10-24T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'a603a563-fe64-414f-a819-e0429da258a5'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-24 13:00 房蔓君（神美：縮毛矯正(及肩),剪髮）
  select id into v_customer_id from customers where phone = '0983682185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('房蔓君', '0983682185') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-24T13:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '688341c6-2772-4323-af8f-69226faf3809', '2026-10-24T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '688341c6-2772-4323-af8f-69226faf3809'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-24 16:30 陳小姐（神美：溫塑燙(及肩)）
  select id into v_customer_id from customers where phone = '0968561094';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳小姐', '0968561094') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-24T16:30:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-24T16:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '24號當天，如可提早請再告知，謝謝。') returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce');
    n_new := n_new + 1;
  end if;

  -- 2026-10-25 17:30 吳婷喻（神美：剪髮）
  select id into v_customer_id from customers where phone = '0931200940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷喻', '0931200940') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-25T17:30:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-25T17:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-26 13:30 麥子君（神美：剪髮）
  select id into v_customer_id from customers where phone = '0911031335';
  if v_customer_id is null then
    insert into customers (name, phone) values ('麥子君', '0911031335') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-26T13:30:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-26T13:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-26 17:00 彭曉君（神美：剪髮）
  select id into v_customer_id from customers where phone = '0979105175';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭曉君', '0979105175') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-26T17:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-26T17:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-30 10:00 黃玉瑄（神美：蘊髮再生療程）
  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-30T10:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '7e5aad3f-430f-4cf7-87b4-9f443193e799', '2026-10-30T10:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '7e5aad3f-430f-4cf7-87b4-9f443193e799');
    n_new := n_new + 1;
  end if;

  -- 2026-10-30 14:30 吳岱蓉（神美：溫塑燙(及肩),剪髮）
  select id into v_customer_id from customers where phone = '0928799066';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳岱蓉', '0928799066') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-30T14:30:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-30T14:30:00+08:00', 'pending', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');
    n_new := n_new + 1;
  end if;

  -- 2026-10-30 14:30 鄭淳尹（神美：剪髮,縮毛矯正(及肩),植物草頭皮養護二合一(短髮),Vegan深層護髮(及肩)）
  select id into v_customer_id from customers where phone = '0988982349';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭淳尹', '0988982349') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-30T14:30:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-30T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, '688341c6-2772-4323-af8f-69226faf3809'), (v_appointment_id, 'bbed80e2-15d6-46c1-b9d8-666248b5ffe1'), (v_appointment_id, '2b7eb46e-c11a-4d33-975b-ecd817142d21');
    n_new := n_new + 1;
  end if;

  -- 2026-10-31 15:00 廖凡儀（神美：植物草修飾白髮三合一(及肩)）
  select id into v_customer_id from customers where phone = '0918037770';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖凡儀', '0918037770') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-31T15:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4', '2026-10-31T15:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4');
    n_new := n_new + 1;
  end if;

  -- 2026-10-31 16:00 馮若涵（神美：剪髮,染髮(及腰)）
  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-10-31T16:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-31T16:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, 'ca375191-eb2e-4421-8bf8-666d30082184');
    n_new := n_new + 1;
  end if;

  -- 2026-11-01 12:00 陳怡安（神美：冷塑燙(肩上)）
  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  if not exists (select 1 from appointments where customer_id = v_customer_id and start_time = '2026-11-01T12:00:00+08:00' and status <> 'cancelled') then
    insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '707d3a51-57bb-400b-bd42-cae3a3404b99', '2026-11-01T12:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '姿姿朋友肩上$5000') returning id into v_appointment_id;
    insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '707d3a51-57bb-400b-bd42-cae3a3404b99');
    n_new := n_new + 1;
  end if;

  if n_new not in (0, 21) then
    raise exception '預期新增 21 筆（或 0 筆代表之前已經跑過），實際新增 % 筆，已取消', n_new;
  end if;
end
$do$;

select to_char(a.start_time at time zone 'Asia/Taipei', 'MM/DD HH24:MI') as 時間, c.name as 客人, a.status as 狀態,
       (select string_agg(s.name, ', ') from appointment_services x join services s on s.id = x.service_id where x.appointment_id = a.id) as 項目
from appointments a join customers c on c.id = a.customer_id
where a.status <> 'cancelled' and a.start_time >= '2026-10-17T00:00:00+08:00'
order by a.start_time;
