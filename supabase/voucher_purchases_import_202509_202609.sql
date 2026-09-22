-- Part C：補歷史商品券購買訂單（2025-09-22 ~ 2026-09-22 範圍內，共17筆訂單/27個品項），
-- 讓這些客人的「累計消費」正確包含買商品券的錢
-- Part D：8 筆商品券在「剩餘紀錄」裡查不到（代表已經用完/remaining=0），這裡補上 remaining=0 的紀錄
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  select id into v_customer_id from customers where phone = '0972155749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李金穎', '0972155749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-10-07T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 0, 'used', '(5送1)植物草三合一長髮', 6, 0, '2025-10-07', '2025-10-07T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 40800, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-10-08T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜12堂', 6000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮12堂', 4800, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'used', '蘊活再生角質露(贈4堂)', 4, 0, '2025-10-08', '2025-10-08T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-10-10T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 0, 'used', '蘊髮再生療程12堂', 12, 0, '2025-10-10', '2025-10-10T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-10-21T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 0, 'used', '蘊髮再生療程12堂', 12, 0, '2025-10-21', '2025-10-21T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-10-24T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 0, 'used', '(5送1)植物草三合一長髮', 6, 0, '2025-10-24', '2025-10-24T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0910688896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王奕之', '0910688896') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-11-20T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-11-25T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 16000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-12-01T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 16000, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-12-07T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2025-12-07', '2025-12-07T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 30000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2025-12-19T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 0, 'used', '蘊髮再生療程12堂', 12, 0, '2025-12-19', '2025-12-19T12:00:00+08:00');
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'used', '蘊活再生角質露(贈4堂)', 4, 0, '2025-12-19', '2025-12-19T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-02-04T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 16000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-02-21T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 16000, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-05-30T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-06-27T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 37000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-07-19T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 37000, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-07-19T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 40800, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-09-20T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮12堂', 4800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜12堂', 6000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);

end $do$;
