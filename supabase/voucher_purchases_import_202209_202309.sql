-- 匯入 2022-09-20 ~ 2023-09-20 商品券購買記錄：原始 9 筆，其中 1 筆為系統重複匯出（陳偉謙 2022-09-28 同一筆出現兩次），已去重，實際 8 筆訂單，共 $92,400
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  select id into v_customer_id from customers where phone = '0936228937';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳偉謙', '0936228937') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 20000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2022-09-28T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草二合一短髮', 20000, 1);

  select id into v_customer_id from customers where phone = '0963532123';
  if v_customer_id is null then
    insert into customers (name, phone) values ('倪家羚', '0963532123') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2022-10-18T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2022-10-18', '2022-10-18T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0920930501';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩璟', '0920930501') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2022-12-12T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0988982349';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭淳尹', '0988982349') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2022-12-28T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0932145131';
  if v_customer_id is null then
    insert into customers (name, phone) values ('伍紘葳', '0932145131') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 5700, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2023-01-05T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(3堂)植物草二合一短髮', 5700, 1);

  select id into v_customer_id from customers where phone = '0970988813';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡子銜', '0970988813') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 5700, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2023-01-19T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(3堂)植物草二合一短髮', 5700, 1);

  select id into v_customer_id from customers where phone = '0905925833';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張甄庭12819', '0905925833') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 11000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2023-02-03T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一短髮', 11000, 1);

  select id into v_customer_id from customers where phone = '0963532123';
  if v_customer_id is null then
    insert into customers (name, phone) values ('倪家羚', '0963532123') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 20000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2023-02-13T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草二合一短髮', 20000, 1);

end $do$;
