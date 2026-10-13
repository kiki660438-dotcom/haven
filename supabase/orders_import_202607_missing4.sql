-- 2026 年 7 月補匯 4 筆訂單：之前匯入的是 7/30 匯出的版本，漏了 7/30 17:00 之後到 7/31 的這 4 筆。
-- 每一筆都先確認「同一時間、同一金額的訂單還不存在」才會新增，重複執行不會產生重複資料。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if not exists (select 1 from orders where created_at = '2026-07-30T17:00:00+08:00' and total = 4000) then
    insert into orders (customer_name, total, status, payment_method, created_at)
      values ('散客', 4000, 'paid', 'transfer', '2026-07-30T17:00:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  end if;

  if not exists (select 1 from orders where created_at = '2026-07-31T16:50:00+08:00' and total = 1200) then
    select id into v_customer_id from customers where phone = '0975225923';
    if v_customer_id is null then
      insert into customers (name, phone) values ('何絲雅', '0975225923') returning id into v_customer_id;
    end if;
    insert into orders (customer_id, total, status, payment_method, created_at)
      values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-31T16:50:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  end if;

  if not exists (select 1 from orders where created_at = '2026-07-31T16:50:00+08:00' and total = 700) then
    select id into v_customer_id from customers where phone = '0914035288';
    if v_customer_id is null then
      insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
    end if;
    insert into orders (customer_id, total, status, payment_method, created_at)
      values (v_customer_id, 700, 'paid', 'transfer', '2026-07-31T16:50:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  end if;

  if not exists (select 1 from orders where created_at = '2026-07-31T16:51:00+08:00' and total = 3860) then
    select id into v_customer_id from customers where phone = '0926052424';
    if v_customer_id is null then
      insert into customers (name, phone) values ('周秋燕', '0926052424') returning id into v_customer_id;
    end if;
    insert into orders (customer_id, total, status, payment_method, created_at)
      values (v_customer_id, 3860, 'paid', 'transfer', '2026-07-31T16:51:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  end if;
end $do$;

-- 執行完請跑這行對照：7 月應該變成 78 筆、金額合計 299,239（原本 74 筆、289,479，加上這 4 筆共 9,760）
select count(*) as 筆數, coalesce(sum(total), 0) as 金額合計
from orders
where created_at >= '2026-07-01T00:00:00+08:00' and created_at < '2026-08-01T00:00:00+08:00';
