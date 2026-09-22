-- 匯入商品券剩餘紀錄 PDF（匯出時間 2026-09-22 19:42，已反映所有歷史使用紀錄）
-- 共 35 張商品券，一次到位設定正確的「剩餘堂數」，不需要額外扣減
do $do$
declare
  v_customer_id uuid;
begin
  select id into v_customer_id from customers where phone = '0905925833';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張甄庭12819', '0905925833') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 11000, 5500, 'active', '(5送1)植物草三合一短髮', 6, 3, '2023-02-03', '2023-02-03T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0963358165';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭宛陵', '0963358165') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 1667, 'active', '(5送1)植物草二合一短髮', 6, 1, '2022-08-23', '2022-08-23T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0920930501';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩璟', '0920930501') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 1667, 'active', '(5送1)植物草二合一短髮', 6, 1, '2022-12-12', '2022-12-12T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0972123863';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧雅云Jenny', '0972123863') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 1667, 'active', '(5送1)植物草二合一短髮', 6, 1, '2024-04-11', '2024-04-11T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 1667, 'active', '(5送1)植物草二合一短髮', 6, 1, '2025-03-29', '2025-03-29T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 1667, 'active', '(5送1)植物草二合一短髮', 6, 1, '2025-11-25', '2025-11-25T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 5000, 'active', '(5送1)植物草二合一短髮', 6, 3, '2026-02-04', '2026-02-04T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 5000, 'active', '(5送1)植物草二合一短髮', 6, 3, '2026-07-19', '2026-07-19T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 13500, 11250, 'active', '(5送1)植物草二合一短髮', 6, 5, '2022-06-25', '2022-06-25T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0988982349';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭淳尹', '0988982349') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 8333, 'active', '(5送1)植物草二合一短髮', 6, 5, '2022-12-28', '2022-12-28T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 8333, 'active', '(5送1)植物草二合一短髮', 6, 5, '2026-05-30', '2026-05-30T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 8333, 'active', '(5送1)植物草二合一短髮', 6, 5, '2026-06-27', '2026-06-27T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0987590680';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈季樺', '0987590680') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 20000, 1538, 'active', '(10送3)植物草二合一短髮', 13, 1, '2022-08-25', '2022-08-25T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0905396827';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Kerri', '0905396827') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 20000, 9231, 'active', '(10送3)植物草二合一短髮', 13, 6, '2022-08-28', '2022-08-28T12:00:00+08:00', 1538);

  select id into v_customer_id from customers where phone = '0936228937';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳偉謙', '0936228937') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 20000, 13846, 'active', '(10送3)植物草二合一短髮', 13, 9, '2022-09-28', '2022-09-28T12:00:00+08:00', 2000);

  select id into v_customer_id from customers where phone = '0963532123';
  if v_customer_id is null then
    insert into customers (name, phone) values ('倪家羚', '0963532123') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 20000, 13846, 'active', '(10送3)植物草二合一短髮', 13, 9, '2023-02-13', '2023-02-13T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0932145131';
  if v_customer_id is null then
    insert into customers (name, phone) values ('伍紘葳', '0932145131') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 5700, 3800, 'active', '(3堂)植物草二合一短髮', 3, 2, '2023-01-05', '2023-01-05T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0970988813';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡子銜', '0970988813') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 5700, 3800, 'active', '(3堂)植物草二合一短髮', 3, 2, '2023-01-19', '2023-01-19T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 16000, 5333, 'active', '(5送1)植物草三合一中髮', 6, 2, '2026-02-21', '2026-02-21T12:00:00+08:00', 2667);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 16000, 8000, 'active', '(5送1)植物草三合一中髮', 6, 3, '2025-12-01', '2025-12-01T12:00:00+08:00', 2667);

  select id into v_customer_id from customers where phone = '0909240707';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳韋如', '0909240707') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 3083, 'active', '(5送1)植物草三合一長髮', 6, 1, '2024-08-26', '2024-08-26T12:00:00+08:00', 3083);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 37000, 28462, 'active', '(10送3)植物草三合一長髮', 13, 10, '2026-07-19', '2026-07-19T12:00:00+08:00', 2846);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 2500, 'active', '蘊髮再生療程12堂', 12, 1, '2025-10-08', '2025-10-08T12:00:00+08:00', 2500);

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 5000, 'active', '蘊髮再生療程12堂', 12, 2, '2025-06-05', '2025-06-05T12:00:00+08:00', 2500);

  select id into v_customer_id from customers where phone = '0910688896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王奕之', '0910688896') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 20000, 'active', '蘊髮再生療程12堂', 12, 8, '2025-11-20', '2025-11-20T12:00:00+08:00', 2500);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 30000, 'active', '蘊髮再生療程12堂', 12, 12, '2026-09-20', '2026-09-20T12:00:00+08:00', 2500);

  select id into v_customer_id from customers where phone = '0912233152';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宣妤', '0912233152') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 1, '2025-06-05', '2025-06-05T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 1, '2025-10-10', '2025-10-10T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 1, '2025-10-21', '2025-10-21T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0910688896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王奕之', '0910688896') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 2, '2025-11-20', '2025-11-20T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 4, '2026-09-20', '2026-09-20T12:00:00+08:00', 0);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 6000, 500, 'active', '凍膜12堂', 12, 1, '2025-10-08', '2025-10-08T12:00:00+08:00', 500);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 6000, 6000, 'active', '凍膜12堂', 12, 12, '2026-09-20', '2026-09-20T12:00:00+08:00', 500);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 4800, 400, 'active', '洗髮12堂', 12, 1, '2025-10-08', '2025-10-08T12:00:00+08:00', 400);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 4800, 4800, 'active', '洗髮12堂', 12, 12, '2026-09-20', '2026-09-20T12:00:00+08:00', 400);

end $do$;
