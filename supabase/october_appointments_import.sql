-- 先確保 appointments 有 note 欄位可以存放神美的原始備註與比對說明
alter table appointments add column if not exists note text;

-- 從神美匯入 2026-10-01 ~ 2026-10-31 的預約記錄（排除已拒絕/已刪除/會員取消的，排除無電話的散客）
-- 共 62 筆，服務項目名稱已盡量比對 Haven 目前的服務項目，少數無法完全對應的已在備註註明原始項目名稱
do $do$
declare
  v_customer_id uuid;
  v_appointment_id uuid;
begin
  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '2bb06df4-f2e7-486f-bc0b-e57978673109', '2026-10-02T11:00:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '神美原始項目：頭皮隔離') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '2bb06df4-f2e7-486f-bc0b-e57978673109'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0972343929';
  if v_customer_id is null then
    insert into customers (name, phone) values ('顏汝瑩', '0972343929') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-02T14:00:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, '0de7ab63-2f1f-4b11-9111-7a42a3016262');

  select id into v_customer_id from customers where phone = '0978930702';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭博營', '0978930702') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-03T11:00:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, '0de7ab63-2f1f-4b11-9111-7a42a3016262');

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'bbed80e2-15d6-46c1-b9d8-666248b5ffe1', '2026-10-03T13:00:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'bbed80e2-15d6-46c1-b9d8-666248b5ffe1'), (v_appointment_id, 'bf03d969-7fc0-4950-8d38-47052a84d586');

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-03T13:16:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '神美原始項目：剪劉海 / (原始服務「剪劉海」無法對應，暫用剪髮代替，請到checkout時手動調整)') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0934327003';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬瑜', '0934327003') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-05T14:00:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '看看長度夠不夠燙捲，如果不夠的話，想說補燙直較好，如果夠長，想燙捲同時染頭髮 / 神美原始項目：自然捲夾順(加購、價格依現場判斷)') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce'), (v_appointment_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c');

  select id into v_customer_id from customers where phone = '0934029569';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方瀅雲', '0934029569') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '688341c6-2772-4323-af8f-69226faf3809', '2026-10-06T11:00:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-06T14:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, 'buster 媽咪') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0909665289';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Iris', '0909665289') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'd592f477-1005-4763-9871-7c71aa2d015e', '2026-10-07T15:30:00+08:00', 'completed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'd592f477-1005-4763-9871-7c71aa2d015e'), (v_appointment_id, 'e928aa8d-2a02-4814-aad1-2a44c5dc6549');

  select id into v_customer_id from customers where phone = '0955038711';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許家慈', '0955038711') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '688341c6-2772-4323-af8f-69226faf3809', '2026-10-08T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-08T12:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0972235070';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭琬純', '0972235070') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '2bb06df4-f2e7-486f-bc0b-e57978673109', '2026-10-08T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-08T15:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0909091400';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王郁雯', '0909091400') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a603a563-fe64-414f-a819-e0429da258a5', '2026-10-08T16:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4', '2026-10-09T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0921082253';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雅淇', '0921082253') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '3f921ecf-4e2b-43d1-a447-f786d524371a', '2026-10-09T11:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '皮皮妞妞剪頭髮
我頭皮保養') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '3f921ecf-4e2b-43d1-a447-f786d524371a'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-09T15:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0979501639';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佳容', '0979501639') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332632a4-7289-4c49-9a91-7b2c4b0eb724', '2026-10-09T16:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332632a4-7289-4c49-9a91-7b2c4b0eb724'), (v_appointment_id, '3564fb31-7745-4e71-b96d-aa80f1c8af38');

  select id into v_customer_id from customers where phone = '0989348320';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范欣瑜', '0989348320') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-10T11:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c'), (v_appointment_id, '2b7eb46e-c11a-4d33-975b-ecd817142d21');

  select id into v_customer_id from customers where phone = '0912667276';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳巧瑩', '0912667276') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-10T14:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '03a80d0f-9d26-4584-8583-07ec96b0e8f2', '2026-10-10T15:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '03a80d0f-9d26-4584-8583-07ec96b0e8f2'), (v_appointment_id, '2b7eb46e-c11a-4d33-975b-ecd817142d21');

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'cd3f28ae-c37f-4596-bf1d-9e76eb415b70', '2026-10-11T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'cd3f28ae-c37f-4596-bf1d-9e76eb415b70'), (v_appointment_id, 'bf03d969-7fc0-4950-8d38-47052a84d586'), (v_appointment_id, '31dea312-e081-4912-b2d4-db06c452c801');

  select id into v_customer_id from customers where phone = '0920701224';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭怡喬', '0920701224') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-11T12:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c'), (v_appointment_id, '688341c6-2772-4323-af8f-69226faf3809');

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-11T14:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-12T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '住國外amber') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0918037770';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖凡儀', '0918037770') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-12T14:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce'), (v_appointment_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0967052032';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭芳屏', '0967052032') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-12T18:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0911471215';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Mei', '0911471215') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '26c5cced-eadd-4503-b199-900e36a8deec', '2026-10-13T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '26c5cced-eadd-4503-b199-900e36a8deec'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0970655129';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李雅娟', '0970655129') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'd592f477-1005-4763-9871-7c71aa2d015e', '2026-10-13T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'd592f477-1005-4763-9871-7c71aa2d015e'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '31dea312-e081-4912-b2d4-db06c452c801', '2026-10-13T17:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '1位療程 1位剪劉海') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-15T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, 'wei姐') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0930131185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐念琪', '0930131185') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-15T14:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '會帶狗狗') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4', '2026-10-17T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '6903d722-f166-4d9b-9f47-33ce8ba25af4'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'bbed80e2-15d6-46c1-b9d8-666248b5ffe1', '2026-10-17T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '+毛流矯正
謝謝Kiki設計師(///▽///)') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'bbed80e2-15d6-46c1-b9d8-666248b5ffe1'), (v_appointment_id, '31dea312-e081-4912-b2d4-db06c452c801');

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a6bec99b-d689-43d3-87b2-2a6e6875c64d', '2026-10-17T17:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '92ca2921-c54b-4f84-9054-84d942b3f1b9', '2026-10-18T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '92ca2921-c54b-4f84-9054-84d942b3f1b9'), (v_appointment_id, 'bf03d969-7fc0-4950-8d38-47052a84d586'), (v_appointment_id, 'cd3f28ae-c37f-4596-bf1d-9e76eb415b70'), (v_appointment_id, '31dea312-e081-4912-b2d4-db06c452c801');

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-18T12:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-18T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '8665f494-596f-434d-b373-70e04ed89694', '2026-10-18T14:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0988102112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊晴雯', '0988102112') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-18T15:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-18T17:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-19T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a603a563-fe64-414f-a819-e0429da258a5', '2026-10-19T13:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '3564fb31-7745-4e71-b96d-aa80f1c8af38', '2026-10-19T15:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-19T16:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '想帶米米，當天會有其他客人帶狗狗嗎？') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0900509652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('喻靖洧', '0900509652') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a6bec99b-d689-43d3-87b2-2a6e6875c64d', '2026-10-20T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'a6bec99b-d689-43d3-87b2-2a6e6875c64d'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '94360a71-0b2c-4790-bc91-e3af8e13448d', '2026-10-20T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-20T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, 'bbed80e2-15d6-46c1-b9d8-666248b5ffe1');

  select id into v_customer_id from customers where phone = '0975272080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林玉屏', '0975272080') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-20T17:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0903520773';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王詩瑜', '0903520773') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c', '2026-10-21T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, 'e9fb7acd-c903-410c-aeb0-9752d67b5e6c'), (v_appointment_id, '332632a4-7289-4c49-9a91-7b2c4b0eb724');

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-21T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0953173218';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪', '0953173218') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '11821d56-cb8c-43e2-a7a9-599fd14392ce', '2026-10-23T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0937312481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭宇珊', '0937312481') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '8aaddc6b-2e93-4349-ad69-6263482f5ffb', '2026-10-24T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0928007269';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賴丁霞', '0928007269') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'a603a563-fe64-414f-a819-e0429da258a5', '2026-10-25T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, 'd592f477-1005-4763-9871-7c71aa2d015e', '2026-10-25T12:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0937040832';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭又慈', '0937040832') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '03a80d0f-9d26-4584-8583-07ec96b0e8f2', '2026-10-25T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '需要現場討論 染髮是否一起') returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0937076545';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Liv', '0937076545') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '0c93ecd2-ef07-4a25-ba8e-a39c3f9883ff', '2026-10-26T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '屆時應該會需要彩護髮根和剪大約5-10公分頭髮～再麻煩你了') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '0c93ecd2-ef07-4a25-ba8e-a39c3f9883ff'), (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b');

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-26T14:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-30T11:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, 'KiKi不好意思，請以10/30為主，10/23屬於誤觸。') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, '0dec58e0-0cc6-4f7f-ab1b-bcbae1d15afb');

  select id into v_customer_id from customers where phone = '0936228937';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳偉謙', '0936228937') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-30T13:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-31T11:30:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, null) returning id into v_appointment_id;

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into appointments (customer_id, service_id, start_time, status, staff_id, buffer_minutes, note) values (v_customer_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b', '2026-10-31T13:00:00+08:00', 'confirmed', '65313ab8-44ff-484d-94c3-e69d204659d3', 0, '染髮是之前染的想要補染髮根') returning id into v_appointment_id;
  insert into appointment_services (appointment_id, service_id) values (v_appointment_id, '332aa3f8-f7c8-4020-8055-3ad74d9ed14b'), (v_appointment_id, '2bb06df4-f2e7-486f-bc0b-e57978673109');

end $do$;
