-- 匯入 2026-09-23 ~ 2026-10-13 訂單（來自神美「2026-01-01-2026-10-14 訂單列表」，9/22 以前的早就匯入過），並補上這段期間用掉的商品券堂數。
-- 營業額規則跟之前一致：orders.total 只算現場付款的現金/匯款，商品券折抵的不重複算。order_items.price 存單價。
-- 必須在 E-voucher_purchases_import_202609_202610.sql 執行「之後」才能跑（蔡慧勤、黃玉瑄的商品券要先存在）。
-- 保護：訂單那段若發現這段期間已經有匯入過就整段取消；扣堂那段每一張都先確認「目前剩餘堂數」跟預期一樣才扣，
--       任何一項對不上，整段取消、什麼都不改。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
  n int;
begin
  if exists (select 1 from orders where created_at >= '2026-09-23T00:00:00+08:00' and created_at < '2026-10-15T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '9/23 之後的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0937556533';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭', '0937556533') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3040, 'paid', 'transfer', '2026-09-24T17:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);

  select id into v_customer_id from customers where phone = '0987799556';
  if v_customer_id is null then
    insert into customers (name, phone) values ('夏琳喬', '0987799556') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-09-24T17:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0973240827';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子妍', '0973240827') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-09-24T17:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921156691';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑋萱', '0921156691') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-09-24T17:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0916337403';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾明瑄', '0916337403') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3800, 'paid', 'cash', '2026-09-24T18:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-09-25T13:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-09-25T13:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'cash', '2026-09-25T13:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0989900971';
  if v_customer_id is null then
    insert into customers (name, phone) values ('朱子涵', '0989900971') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5500, 'paid', 'transfer', '2026-09-25T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-09-25T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'cash', '2026-09-25T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0988516806';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周彥廷', '0988516806') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-09-26T15:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0958960102';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林詩婷', '0958960102') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-09-26T15:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0931290520';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊秀玲', '0931290520') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'cash', '2026-09-26T18:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0972603230';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃聖雅', '0972603230') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2026-09-26T18:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'transfer', '2026-09-27T18:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0988933481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯語', '0988933481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-09-27T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-09-27T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988352640';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許芳瑾', '0988352640') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-09-27T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0978430084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林彥妤', '0978430084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8000, 'paid', 'transfer', '2026-09-27T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'transfer', '2026-09-28T17:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0963213218';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳映樺', '0963213218') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2026-09-28T18:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-09-28T18:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917241515';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0917241515') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-09-28T18:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0972104864';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭美彤', '0972104864') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-09-29T17:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0912929435';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾尹宣', '0912929435') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-09-29T17:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0930277185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王立文', '0930277185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2026-09-29T17:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0988390261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳昱安', '0988390261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3480, 'paid', 'transfer', '2026-09-29T19:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-10-02T13:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0972343929';
  if v_customer_id is null then
    insert into customers (name, phone) values ('顏汝瑩', '0972343929') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1260, 'paid', 'cash', '2026-10-02T13:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0978930702';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭博營', '0978930702') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-10-03T12:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 5100, 'paid', 'cash', '2026-10-03T12:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1700, 3);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-10-03T13:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-10-03T15:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0934327003';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬瑜', '0934327003') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9880, 'paid', 'transfer', '2026-10-05T16:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然捲夾順(加購,價格依現場判斷)', 2500, 1);

  select id into v_customer_id from customers where phone = '0934029569';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方瀅雲', '0934029569') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-10-06T17:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'transfer', '2026-10-06T17:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0909665289';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Iris', '0909665289') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-10-07T16:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1000, 'paid', 'transfer', '2026-10-07T16:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0955038711';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許家慈', '0955038711') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-10-08T15:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0972235070';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭琬純', '0972235070') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2026-10-08T15:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-10-08T15:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-10-08T17:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0909091400';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王郁雯', '0909091400') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5400, 'paid', 'transfer', '2026-10-08T18:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-10-09T13:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一中髮', 2462, 1);

  select id into v_customer_id from customers where phone = '0921082253';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雅淇', '0921082253') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4880, 'paid', 'transfer', '2026-10-09T15:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 3);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-10-09T18:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0979501639';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佳容', '0979501639') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2026-10-09T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6300, 'paid', 'transfer', '2026-10-10T17:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0912667276';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳巧瑩', '0912667276') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-10-10T18:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0989348320';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范欣瑜', '0989348320') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6740, 'paid', 'transfer', '2026-10-10T18:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2026-10-11T18:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0920701224';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭怡喬', '0920701224') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 16020, 'paid', 'transfer', '2026-10-11T18:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-10-11T18:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1610, 'paid', 'cash', '2026-10-11T18:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1610, 1);

  select id into v_customer_id from customers where phone = '0918037770';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖凡儀', '0918037770') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4660, 'paid', 'transfer', '2026-10-12T17:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 9500, 'paid', 'transfer', '2026-10-12T17:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0967052032';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭芳屏', '0967052032') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-10-12T19:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0970655129';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李雅娟', '0970655129') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-10-13T17:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0911471215';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Mei', '0911471215') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'cash', '2026-10-13T17:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 3000, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2026-10-13T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 4317, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-豐健', 0, 1);

  -- ===== 商品券扣堂（9/22 19:42 剩餘紀錄匯出之後用掉的）=====
  -- Amor Huang：(5送1)植物草二合一短髮（2026-06-27 購買）10/9 用 1 堂，剩餘 5 → 4
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0910033140' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2026-06-27' and v.remaining_sessions = 5;
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Amor Huang 的「(5送1)植物草二合一短髮」目前剩餘堂數不是預期的 5（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 陳怡萍：(5送1)植物草三合一中髮（2025-12-01 購買）10/10 用 1 堂，剩餘 3 → 2
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0919363431' and v.service_name = '(5送1)植物草三合一中髮' and v.purchased_at = '2025-12-01' and v.remaining_sessions = 3;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '陳怡萍 的「(5送1)植物草三合一中髮」目前剩餘堂數不是預期的 3（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 黃沐薇：蘊髮再生療程12堂（2025-10-08 購買）10/11 用 1 堂（最舊的那張，剩 1 堂用完），剩餘 1 → 0
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2025-10-08' and v.remaining_sessions = 1;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '黃沐薇 的「蘊髮再生療程12堂」目前剩餘堂數不是預期的 1（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 黃沐薇：凍膜12堂（2025-10-08 購買）10/11 用 1 堂（最舊的那張，剩 1 堂用完），剩餘 1 → 0
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '凍膜12堂' and v.purchased_at = '2025-10-08' and v.remaining_sessions = 1;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '黃沐薇 的「凍膜12堂」目前剩餘堂數不是預期的 1（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 黃沐薇：洗髮12堂（2025-10-08 購買）10/11 用 1 堂（最舊的那張，剩 1 堂用完），剩餘 1 → 0
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '洗髮12堂' and v.purchased_at = '2025-10-08' and v.remaining_sessions = 1;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '黃沐薇 的「洗髮12堂」目前剩餘堂數不是預期的 1（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 蔡慧勤：(10送3)植物草三合一中髮（2026-10-09 購買）10/9 買完當天用 1 堂，剩餘 13 → 12
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0972003410' and v.service_name = '(10送3)植物草三合一中髮' and v.purchased_at = '2026-10-09' and v.remaining_sessions = 13;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '蔡慧勤 的「(10送3)植物草三合一中髮」目前剩餘堂數不是預期的 13（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 黃玉瑄：蘊髮再生療程12堂（2026-10-13 購買）10/13 買完當天用 1 堂，剩餘 12 → 11
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0912618908' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2026-10-13' and v.remaining_sessions = 12;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '黃玉瑄 的「蘊髮再生療程12堂」目前剩餘堂數不是預期的 12（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 黃玉瑄：洗髮12堂（2026-10-13 購買）10/13 用 1 堂（贈送），剩餘 12 → 11
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0912618908' and v.service_name = '洗髮12堂' and v.purchased_at = '2026-10-13' and v.remaining_sessions = 12;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '黃玉瑄 的「洗髮12堂」目前剩餘堂數不是預期的 12（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

  -- 黃玉瑄：蘊活再生角質露(贈4堂)（2026-10-13 購買）10/13 用 1 堂（贈送），剩餘 4 → 3
  update vouchers v set remaining_sessions = v.remaining_sessions - 1,
    remaining_value = round(v.initial_value::numeric * (v.remaining_sessions - 1) / v.total_sessions),
    status = case when v.remaining_sessions - 1 = 0 then 'used' else 'active' end
  from customers c where c.id = v.customer_id and c.phone = '0912618908' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2026-10-13' and v.remaining_sessions = 4;
  get diagnostics n = row_count;
  if n <> 1 then raise exception '黃玉瑄 的「蘊活再生角質露(贈4堂)」目前剩餘堂數不是預期的 4（或找不到這張商品券），已全部取消，沒有任何資料被修改。'; end if;

end $do$;

-- 執行完請對照：訂單應該是 61 筆、現場實收合計 199690（下面第一個查詢）；扣堂結果請看第二個查詢。
select count(*) as 訂單數, coalesce(sum(total),0) as 現場實收合計 from orders where created_at >= '2026-09-23T00:00:00+08:00' and created_at < '2026-10-15T00:00:00+08:00' and (payment_method is not null or total = 0);
select c.name as 客人, v.service_name as 商品券, v.remaining_sessions as 剩餘, v.total_sessions as 共, v.status as 狀態, v.purchased_at as 購買日
from vouchers v join customers c on c.id = v.customer_id
where c.phone in ('0910033140','0919363431','0974358358','0972003410','0912618908')
  and v.service_name in ('(5送1)植物草二合一短髮','(5送1)植物草三合一中髮','蘊髮再生療程12堂','凍膜12堂','洗髮12堂','(10送3)植物草三合一中髮','蘊活再生角質露(贈4堂)')
  and v.purchased_at in ('2026-06-27','2025-12-01','2025-10-08','2026-09-20','2026-10-09','2026-10-13')
order by c.name, v.service_name, v.purchased_at;
