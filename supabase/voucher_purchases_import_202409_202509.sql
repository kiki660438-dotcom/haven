-- 匯入 2024-09-21 ~ 2025-09-21 商品券購買記錄：14筆歷史訂單，共 $255,000
-- 已跟 part1 的商品券剩餘快照核對過：3個品項目前還有剩餘堂數（不重複建商品券），
-- 其餘15個品項在剩餘快照裡查不到，判定為已用完，補上 remaining=0 的紀錄
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  select id into v_customer_id from customers where phone = '0963009722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡君', '0963009722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-12-14T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 0, 'used', '(5送1)植物草三合一長髮', 6, 0, '2024-12-14', '2024-12-14T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0973682048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雯文', '0973682048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 16000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-12-20T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 16000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 16000, 0, 'used', '(5送1)植物草三合一中髮', 6, 0, '2024-12-20', '2024-12-20T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-01-08T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2025-01-08', '2025-01-08T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 16000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-03-23T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 16000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 16000, 0, 'used', '(5送1)植物草三合一中髮', 6, 0, '2025-03-23', '2025-03-23T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-03-29T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-04-06T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2025-04-06', '2025-04-06T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-05-03T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2025-05-03', '2025-05-03T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0936335362';
  if v_customer_id is null then
    insert into customers (name, phone) values ('としえ', '0936335362') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-05-15T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 0, 'used', '(5送1)植物草三合一長髮', 6, 0, '2025-05-15', '2025-05-15T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-06-05T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'used', '蘊活再生角質露(贈4堂)', 4, 0, '2025-06-05', '2025-06-05T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0912233152';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宣妤', '0912233152') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-06-05T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 0, 'used', '蘊髮再生療程12堂', 12, 0, '2025-06-05', '2025-06-05T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-06-20T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'used', '蘊活再生角質露(贈4堂)', 4, 0, '2025-06-20', '2025-06-20T12:00:00+08:00');
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 0, 'used', '蘊髮再生療程12堂', 12, 0, '2025-06-20', '2025-06-20T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-07-13T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2025-07-13', '2025-07-13T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-07-16T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 0, 'used', '蘊髮再生療程12堂', 12, 0, '2025-07-16', '2025-07-16T12:00:00+08:00');
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'used', '蘊活再生角質露(贈4堂)', 4, 0, '2025-07-16', '2025-07-16T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 16000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-08-07T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 16000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 16000, 0, 'used', '(5送1)植物草三合一中髮', 6, 0, '2025-08-07', '2025-08-07T12:00:00+08:00');

end $do$;
