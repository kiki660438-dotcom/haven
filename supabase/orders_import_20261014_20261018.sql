-- 10/14～10/18 的神美訂單（共 16 筆），並補上林柔青 10/17 購買的 (5送1)植物草三合一長髮商品券
-- 訂單金額只算「現場付款」（現金／匯款），用商品券抵的不算營收；有用商品券的 3 筆會同步扣堂
-- 可重複執行：同一位客人同一時間同一金額的訂單已經存在就不會再新增，也不會再扣堂
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
  n int;
begin
  -- 林柔青 10/17 購買 (5送1)植物草三合一長髮 18,500（訂單與商品券）
  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-17T12:00:00+08:00' and total = 18500) then
    insert into orders (customer_id, total, status, staff_id, created_at) values (v_customer_id, 18500, 'paid', '65313ab8-44ff-484d-94c3-e69d204659d3', '2026-10-17T12:00:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 18500, 1);
  end if;
  if not exists (select 1 from vouchers where customer_id = v_customer_id and service_name = '(5送1)植物草三合一長髮' and purchased_at = '2026-10-17') then
    insert into vouchers (code, customer_id, initial_value, remaining_value, status, service_name, total_sessions, remaining_sessions, purchased_at, issued_at, unit_price) values (upper(substr(md5(random()::text || clock_timestamp()::text), 1, 8)), v_customer_id, 18500, 18500, 'active', '(5送1)植物草三合一長髮', 6, 6, '2026-10-17', '2026-10-17T12:00:00+08:00', 3700);
  end if;

  -- #11 2026-10-15 18:34 羅曼瑄 實收現場付款 3360（transfer）
  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-15T18:34:00+08:00' and total = 3360) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-10-15T18:34:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙染(價錢依現場判斷)', 2400, 1);
  end if;

  -- #12 2026-10-15 18:35 散客 實收現場付款 960（cash）
  if not exists (select 1 from orders where customer_name = '散客' and created_at = '2026-10-15T18:35:00+08:00' and total = 960) then
    insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'cash', '2026-10-15T18:35:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

  -- #13 2026-10-15 18:37 廖珮珊 實收現場付款 2960（cash）
  select id into v_customer_id from customers where phone = '0978658113';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖珮珊', '0978658113') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-15T18:37:00+08:00' and total = 2960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'cash', '2026-10-15T18:37:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  end if;

  -- #14 2026-10-15 18:39 徐念琪 實收現場付款 960（cash）
  select id into v_customer_id from customers where phone = '0930131185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐念琪', '0930131185') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-15T18:39:00+08:00' and total = 960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-10-15T18:39:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

  -- #15 2026-10-16 19:56 陳姿安 實收現場付款 960（transfer）
  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-16T19:56:00+08:00' and total = 960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-10-16T19:56:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

  -- #16 2026-10-16 19:56 許欣怡 實收現場付款 2800（cash）
  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-16T19:56:00+08:00' and total = 2800) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'cash', '2026-10-16T19:56:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  end if;

  -- #17 2026-10-17 13:30 林柔青 實收現場付款 1560（transfer）
  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-17T13:30:00+08:00' and total = 1560) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-10-17T13:30:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
    update vouchers set remaining_sessions = remaining_sessions - 1,
      remaining_value = greatest(0, round(remaining_value - initial_value::numeric / total_sessions)),
      status = case when remaining_sessions - 1 = 0 then 'used' else 'active' end
    where id = (select v.id from vouchers v join customers c on c.id = v.customer_id
                where c.phone = '0919102928' and v.service_name = '(5送1)植物草三合一長髮' and v.status = 'active' and v.remaining_sessions > 0
                order by v.purchased_at, v.issued_at limit 1);
    get diagnostics n = row_count;
    if n <> 1 then raise exception '找不到可扣堂的商品券：0919102928 (5送1)植物草三合一長髮，已取消'; end if;
  end if;

  -- #18 2026-10-17 18:16 李孟容 實收現場付款 800（transfer）
  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-17T18:16:00+08:00' and total = 800) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2026-10-17T18:16:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
    update vouchers set remaining_sessions = remaining_sessions - 1,
      remaining_value = greatest(0, round(remaining_value - initial_value::numeric / total_sessions)),
      status = case when remaining_sessions - 1 = 0 then 'used' else 'active' end
    where id = (select v.id from vouchers v join customers c on c.id = v.customer_id
                where c.phone = '0982876935' and v.service_name = '(5送1)植物草二合一短髮' and v.status = 'active' and v.remaining_sessions > 0
                order by v.purchased_at, v.issued_at limit 1);
    get diagnostics n = row_count;
    if n <> 1 then raise exception '找不到可扣堂的商品券：0982876935 (5送1)植物草二合一短髮，已取消'; end if;
  end if;

  -- #19 2026-10-17 18:16 陳 實收現場付款 1200（cash）
  select id into v_customer_id from customers where phone = '0931278005';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳', '0931278005') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-17T18:16:00+08:00' and total = 1200) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-10-17T18:16:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  end if;

  -- #20 2026-10-17 18:17 張家華 實收現場付款 1000（transfer）
  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-17T18:17:00+08:00' and total = 1000) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2026-10-17T18:17:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  end if;

  -- #21 2026-10-18 18:46 黃沐薇 實收現場付款 1200（cash）
  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-18T18:46:00+08:00' and total = 1200) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-10-18T18:46:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
    update vouchers set remaining_sessions = remaining_sessions - 1,
      remaining_value = greatest(0, round(remaining_value - initial_value::numeric / total_sessions)),
      status = case when remaining_sessions - 1 = 0 then 'used' else 'active' end
    where id = (select v.id from vouchers v join customers c on c.id = v.customer_id
                where c.phone = '0974358358' and v.service_name = '洗髮12堂' and v.status = 'active' and v.remaining_sessions > 0
                order by v.purchased_at, v.issued_at limit 1);
    get diagnostics n = row_count;
    if n <> 1 then raise exception '找不到可扣堂的商品券：0974358358 洗髮12堂，已取消'; end if;
    update vouchers set remaining_sessions = remaining_sessions - 1,
      remaining_value = greatest(0, round(remaining_value - initial_value::numeric / total_sessions)),
      status = case when remaining_sessions - 1 = 0 then 'used' else 'active' end
    where id = (select v.id from vouchers v join customers c on c.id = v.customer_id
                where c.phone = '0974358358' and v.service_name = '凍膜12堂' and v.status = 'active' and v.remaining_sessions > 0
                order by v.purchased_at, v.issued_at limit 1);
    get diagnostics n = row_count;
    if n <> 1 then raise exception '找不到可扣堂的商品券：0974358358 凍膜12堂，已取消'; end if;
    update vouchers set remaining_sessions = remaining_sessions - 1,
      remaining_value = greatest(0, round(remaining_value - initial_value::numeric / total_sessions)),
      status = case when remaining_sessions - 1 = 0 then 'used' else 'active' end
    where id = (select v.id from vouchers v join customers c on c.id = v.customer_id
                where c.phone = '0974358358' and v.service_name = '蘊髮再生療程12堂' and v.status = 'active' and v.remaining_sessions > 0
                order by v.purchased_at, v.issued_at limit 1);
    get diagnostics n = row_count;
    if n <> 1 then raise exception '找不到可扣堂的商品券：0974358358 蘊髮再生療程12堂，已取消'; end if;
  end if;

  -- #22 2026-10-18 18:46 昆 實收現場付款 2160（cash）
  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-18T18:46:00+08:00' and total = 2160) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'cash', '2026-10-18T18:46:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

  -- #23 2026-10-18 18:47 林儀柔 實收現場付款 960（transfer）
  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-18T18:47:00+08:00' and total = 960) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-10-18T18:47:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  end if;

  -- #24 2026-10-18 18:47 徐子鈞 實收現場付款 2900（transfer）
  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-18T18:47:00+08:00' and total = 2900) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'transfer', '2026-10-18T18:47:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);
  end if;

  -- #25 2026-10-18 18:48 王莨喻 實收現場付款 3800（transfer）
  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-18T18:48:00+08:00' and total = 3800) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3800, 'paid', 'transfer', '2026-10-18T18:48:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  end if;

  -- #26 2026-10-18 18:48 楊晴雯 實收現場付款 2400（transfer）
  select id into v_customer_id from customers where phone = '0988102112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊晴雯', '0988102112') returning id into v_customer_id;
  end if;
  if not exists (select 1 from orders where customer_id = v_customer_id and created_at = '2026-10-18T18:48:00+08:00' and total = 2400) then
    insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-10-18T18:48:00+08:00') returning id into v_order_id;
    insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);
  end if;

end
$do$;

select to_char(o.created_at at time zone 'Asia/Taipei', 'MM/DD HH24:MI') as 時間, coalesce(c.name, o.customer_name) as 客人, o.total as 金額, o.payment_method as 付款
from orders o left join customers c on c.id = o.customer_id
where o.created_at >= '2026-10-14T00:00:00+08:00' order by o.created_at;
