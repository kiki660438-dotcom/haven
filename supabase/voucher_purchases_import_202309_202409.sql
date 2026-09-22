-- 匯入 2023-09-21 ~ 2024-09-20 商品券購買記錄：7筆歷史訂單，共 $126,000
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-07-14T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2024-07-14', '2024-07-14T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0909240707';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳韋如', '0909240707') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-08-26T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 37000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-04-04T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 37000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 37000, 0, 'used', '(10送3)植物草三合一長髮', 13, 0, '2024-04-04', '2024-04-04T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0922210176';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙庭涓', '0922210176') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 22000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-04-13T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一短髮', 22000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 22000, 0, 'used', '(10送3)植物草三合一短髮', 13, 0, '2024-04-13', '2024-04-13T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0972123863';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧雅云Jenny', '0972123863') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-04-11T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 10000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-06-01T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 10000, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 10000, 0, 'used', '(5送1)植物草二合一短髮', 6, 0, '2024-06-01', '2024-06-01T12:00:00+08:00');

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2024-05-04T12:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);
  insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 0, 'used', '(5送1)植物草三合一長髮', 6, 0, '2024-05-04', '2024-05-04T12:00:00+08:00');

end $do$;
