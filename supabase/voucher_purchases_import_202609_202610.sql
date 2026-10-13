-- 補 2026-09-20 ~ 2026-10-13 的商品券購買（來自神美「2026-09-01-2026-10-31 商品券購買使用記錄」，3 位客人、合計 124,600）。
-- 1) 黃沐薇 9/20 那 4 張商品券在資料庫裡沒有（訂單之前已備好），這裡補上；
-- 2) 蔡慧勤 10/9、黃玉瑄 10/13 是新的，訂單與商品券都新增。
-- 注意：神美這份檔案只記「購買」，沒有記購買後用掉幾堂，所以新增的商品券堂數先填「全部堂數」。
--       如果這幾位 9/22 之後已經扣過堂，要再調整剩餘堂數（執行完後把用掉幾堂告訴我，或給我最新的商品券剩餘紀錄）。
-- 每一筆都先確認不存在才新增，重複執行不會產生重複資料。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-09-20T12:00:00+08:00' and total = 40800) then
    insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 40800, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-09-20T12:00:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮12堂', 4800, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜12堂', 6000, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 30000, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '洗髮12堂' and purchased_at = '2026-09-20') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 4800, 4800, 'active', '洗髮12堂', 12, 12, '2026-09-20', '2026-09-20T12:00:00+08:00', 400);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '凍膜12堂' and purchased_at = '2026-09-20') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 6000, 6000, 'active', '凍膜12堂', 12, 12, '2026-09-20', '2026-09-20T12:00:00+08:00', 500);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '蘊髮再生療程12堂' and purchased_at = '2026-09-20') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 30000, 30000, 'active', '蘊髮再生療程12堂', 12, 12, '2026-09-20', '2026-09-20T12:00:00+08:00', 2500);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '蘊活再生角質露(贈4堂)' and purchased_at = '2026-09-20') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 4, '2026-09-20', '2026-09-20T12:00:00+08:00', 0);
  end if;

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-09T12:00:00+08:00' and total = 32000) then
    insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 32000, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-10-09T12:00:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一中髮', 32000, 1);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '(10送3)植物草三合一中髮' and purchased_at = '2026-10-09') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 32000, 32000, 'active', '(10送3)植物草三合一中髮', 13, 13, '2026-10-09', '2026-10-09T12:00:00+08:00', 3200);
  end if;

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-13T12:00:00+08:00' and total = 51800) then
    insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 51800, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-10-13T12:00:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 51800, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮12堂', 0, 1);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '蘊活再生角質露(贈4堂)' and purchased_at = '2026-10-13') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '蘊活再生角質露(贈4堂)', 4, 4, '2026-10-13', '2026-10-13T12:00:00+08:00', 0);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '蘊髮再生療程12堂' and purchased_at = '2026-10-13') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 51800, 51800, 'active', '蘊髮再生療程12堂', 12, 12, '2026-10-13', '2026-10-13T12:00:00+08:00', 4317);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '洗髮12堂' and purchased_at = '2026-10-13') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 0, 0, 'active', '洗髮12堂', 12, 12, '2026-10-13', '2026-10-13T12:00:00+08:00', 0);
  end if;

end $do$;

-- 執行完請對照：應該有 8 張商品券（黃沐薇 4、蔡慧勤 1、黃玉瑄 3）
select c.name as 客人, v.service_name as 商品券, v.remaining_sessions as 剩餘, v.total_sessions as 共, v.purchased_at as 購買日
from vouchers v join customers c on c.id = v.customer_id
where c.phone in ('0974358358','0972003410','0912618908') and v.purchased_at >= '2026-09-20'
order by v.purchased_at, c.name;
