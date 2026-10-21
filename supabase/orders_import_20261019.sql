-- 10/19 神美訂單（4 筆）：金額只算現場付款；彭佩雯那筆用商品券，同步扣 1 堂
-- 可重複執行：同一位客人同一時間同一金額的訂單已經存在就不會再新增，也不會再扣堂
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
  n int;
begin
  -- #1 2026-10-19 16:41 彭佩雯 現場付款 960（transfer）
  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-19T16:41:00+08:00' and total = 960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-10-19T16:41:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
    update vouchers set remaining_sessions = remaining_sessions - 1,
      remaining_value = greatest(0, round(remaining_value - initial_value::numeric / total_sessions)),
      status = case when remaining_sessions - 1 = 0 then 'used' else 'active' end
    where id = (select v.id from vouchers v join customers c on c.id = v.customer_id
                where c.phone = '0932937523' and v.service_name = '(5送1)植物草二合一短髮' and v.status = 'active' and v.remaining_sessions > 0
                order by v.purchased_at, v.issued_at limit 1);
    get diagnostics n = row_count;
    if n <> 1 then raise exception '找不到可扣堂的商品券：0932937523 (5送1)植物草二合一短髮，已取消'; end if;
  end if;

  -- #2 2026-10-19 17:15 Jenny 現場付款 960（cash）
  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-19T17:15:00+08:00' and total = 960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-10-19T17:15:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

  -- #3 2026-10-19 17:16 黃于倩 現場付款 4000（cash）
  select id into v_customer_id from customers where phone = '0901152368';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃于倩', '0901152368') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-19T17:16:00+08:00' and total = 4000) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-10-19T17:16:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  end if;

  -- #4 2026-10-19 17:18 林子禹 現場付款 2960（transfer）
  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-19T17:18:00+08:00' and total = 2960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2026-10-19T17:18:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

end
$do$;

select to_char(o.created_at at time zone 'Asia/Taipei', 'MM/DD HH24:MI') as 時間, coalesce(c.name, o.customer_name) as 客人, o.total as 金額, o.payment_method as 付款
from orders o left join customers c on c.id = o.customer_id
where o.created_at >= '2026-10-19T00:00:00+08:00' order by o.created_at;
