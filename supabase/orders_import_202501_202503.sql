-- 匯入 2025-01 ~ 2025-03 訂單列表（來自神美匯出的每月訂單列表）
-- orders.total 只算「現場付款」的現金/匯款實收，商品券折抵的部分不重複算營業額（跟 9 月匯入的規則一致）；
-- 每一筆訂單照樣建立（total 可能是 0），客人的消費次數／最近消費才會正確。order_items.price 存的是「單價」。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if exists (select 1 from orders where created_at >= '2025-01-01T00:00:00+08:00' and created_at < '2025-04-01T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '這段期間的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2025-01-01T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 5980, 'paid', 'transfer', '2025-01-01T19:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0936547871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧芳郡', '0936547871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-01-01T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0989110421';
  if v_customer_id is null then
    insert into customers (name, phone) values ('奇倫', '0989110421') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'transfer', '2025-01-01T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '22合1修護噴霧150ml', 1080, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'cash', '2025-01-01T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0988367591';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Ruwen', '0988367591') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'cash', '2025-01-02T21:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1120, 'paid', 'transfer', '2025-01-02T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0982877852';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張智雁', '0982877852') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'cash', '2025-01-02T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-01-02T21:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4120, 'paid', 'cash', '2025-01-02T21:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 2);

  select id into v_customer_id from customers where phone = '0973682048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雯文', '0973682048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-01-02T21:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8900, 'paid', 'transfer', '2025-01-02T21:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0923362818';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家瑜', '0923362818') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-03T23:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988293121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐紫絜', '0988293121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5100, 'paid', 'cash', '2025-01-03T23:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0987952059';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sabrina', '0987952059') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6790, 'paid', 'cash', '2025-01-03T23:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0988136745';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳宜庭', '0988136745') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5620, 'paid', 'cash', '2025-01-03T23:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0934073826';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳映如', '0934073826') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-01-03T23:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0970420866';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐千雅', '0970420866') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4480, 'paid', 'transfer', '2025-01-03T23:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'cash', '2025-01-04T21:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0975110862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊景嵐', '0975110862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2025-01-04T21:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0978096652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊喬婷', '0978096652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5780, 'paid', 'transfer', '2025-01-04T21:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '22合1修護噴霧150ml', 1080, 1);

  select id into v_customer_id from customers where phone = '0928685432';
  if v_customer_id is null then
    insert into customers (name, phone) values ('湯璧禎', '0928685432') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2025-01-04T21:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0911876723';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許雅涵', '0911876723') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3060, 'paid', 'transfer', '2025-01-04T21:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0919218316';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林佩君', '0919218316') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'cash', '2025-01-04T21:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2400, 1);

  select id into v_customer_id from customers where phone = '0979501639';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佳容', '0979501639') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2025-01-05T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0936682621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏婕安', '0936682621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'cash', '2025-01-05T20:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928269538';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳信彣', '0928269538') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6680, 'paid', 'cash', '2025-01-05T20:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(及肩)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0921501907';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃富柔', '0921501907') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-05T20:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0917946885';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃郁婷', '0917946885') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-01-05T20:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919377316';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳宛蓉', '0919377316') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10500, 'paid', 'transfer', '2025-01-05T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 2);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 21680, 'paid', 'transfer', '2025-01-07T18:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0978615031';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Ellison Chen', '0978615031') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-01-07T18:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975176063';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芳如', '0975176063') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1120, 'paid', 'transfer', '2025-01-07T23:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0938640505';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張昊祺', '0938640505') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1120, 'paid', 'transfer', '2025-01-07T23:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0920930501';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩璟', '0920930501') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1170, 'paid', 'transfer', '2025-01-07T23:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 1170, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1170, 'paid', 'transfer', '2025-01-08T21:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2310, 'paid', 'transfer', '2025-01-08T22:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);

  select id into v_customer_id from customers where phone = '0952617112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉以婕', '0952617112') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6450, 'paid', 'transfer', '2025-01-08T22:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'cash', '2025-01-08T22:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0978233220';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳鈺婷', '0978233220') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-08T22:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0955623479';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡嘉馨', '0955623479') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2360, 'paid', 'cash', '2025-01-08T22:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1040, 1);

  select id into v_customer_id from customers where phone = '0916919116';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古如君', '0916919116') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-08T22:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0932168867';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許雅涵 zoie', '0932168867') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2025-01-08T22:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-01-08T22:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 4);

  select id into v_customer_id from customers where phone = '0910731516';
  if v_customer_id is null then
    insert into customers (name, phone) values ('May', '0910731516') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'cash', '2025-01-08T22:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0975141749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靖雅', '0975141749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-08T22:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2025-01-08T23:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0975543969';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林于雯', '0975543969') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5580, 'paid', 'transfer', '2025-01-14T21:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0929091006';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳彥宇', '0929091006') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-14T21:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6080, 'paid', 'cash', '2025-01-14T21:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0956130022';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉玉婷', '0956130022') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5460, 'paid', 'transfer', '2025-01-14T21:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0936050947';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾雨儂', '0936050947') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1120, 'paid', 'transfer', '2025-01-14T21:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0963536699';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃書英', '0963536699') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-14T21:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0979303134';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳安可', '0979303134') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4410, 'paid', 'cash', '2025-01-15T20:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '彩盾護色洗髮露', 1010, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2025-01-15T20:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2580, 'paid', 'transfer', '2025-01-15T20:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2025-01-15T20:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0931297387';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉姿君', '0931297387') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-01-15T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0935699793';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張瓊文', '0935699793') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2025-01-17T20:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0977095039';
  if v_customer_id is null then
    insert into customers (name, phone) values ('C', '0977095039') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1140, 'paid', 'cash', '2025-01-17T20:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 1140, 1);

  select id into v_customer_id from customers where phone = '0972523930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采築', '0972523930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-01-17T20:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958149117';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊婉伶', '0958149117') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5820, 'paid', 'transfer', '2025-01-17T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0977406722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Emma', '0977406722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4100, 'paid', 'transfer', '2025-01-17T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2025-01-17T21:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0916952365';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳雅旭', '0916952365') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2025-01-18T22:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5320, 'paid', 'transfer', '2025-01-18T22:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0922210176';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙庭涓', '0922210176') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-01-18T22:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'transfer', '2025-01-18T22:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928995183';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王詞雅', '0928995183') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2130, 'paid', 'cash', '2025-01-18T22:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1170, 'paid', 'transfer', '2025-01-18T22:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 1170, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2025-01-18T22:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'transfer', '2025-01-18T22:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0921082253';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雅淇', '0921082253') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4820, 'paid', 'transfer', '2025-01-18T22:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0987879867';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范雅智', '0987879867') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7320, 'paid', 'transfer', '2025-01-19T21:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0903894432';
  if v_customer_id is null then
    insert into customers (name, phone) values ('柯旻君', '0903894432') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2025-01-19T21:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988106810';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐芷芸', '0988106810') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-01-19T21:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7790, 'paid', 'cash', '2025-01-19T21:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'ILGA頭皮養護液200ml', 1160, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '每日溫和洗髮露', 940, 1);

  select id into v_customer_id from customers where phone = '0987889685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖玉涵', '0987889685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3680, 'paid', 'transfer', '2025-01-19T21:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0952250305';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳詠莉', '0952250305') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5600, 'paid', 'transfer', '2025-01-20T18:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0987955003';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳依珊', '0987955003') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-20T18:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988980106';
  if v_customer_id is null then
    insert into customers (name, phone) values ('梁芝瑜', '0988980106') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-20T18:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2800, 'paid', 'transfer', '2025-01-20T18:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0955653645';
  if v_customer_id is null then
    insert into customers (name, phone) values ('高寧憶', '0955653645') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-22T22:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972217400';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳芊萱', '0972217400') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3280, 'paid', 'transfer', '2025-01-22T22:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0910897033';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪紫瑜', '0910897033') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6800, 'paid', 'transfer', '2025-01-22T23:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0937360821';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭于庭', '0937360821') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8600, 'paid', 'transfer', '2025-01-23T20:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0952803218';
  if v_customer_id is null then
    insert into customers (name, phone) values ('莊雅婷', '0952803218') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2025-01-23T20:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);

  select id into v_customer_id from customers where phone = '0931080116';
  if v_customer_id is null then
    insert into customers (name, phone) values ('嫚真', '0931080116') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1540, 'paid', 'cash', '2025-01-23T20:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '每日溫和洗髮露', 940, 1);

  select id into v_customer_id from customers where phone = '0928007269';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賴丁霞', '0928007269') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3560, 'paid', 'cash', '2025-01-23T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0913171309';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳靜怡', '0913171309') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'cash', '2025-01-24T14:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-24T14:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0919287696';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游宛頤', '0919287696') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2025-01-24T14:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4320, 'paid', 'cash', '2025-01-24T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);

  select id into v_customer_id from customers where phone = '0988325251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('秦荷婷', '0988325251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 12600, 'paid', 'cash', '2025-01-24T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2025-01-24T19:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1360, 'paid', 'transfer', '2025-01-25T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);

  select id into v_customer_id from customers where phone = '0936547871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧芳郡', '0936547871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-01-25T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3300, 'paid', 'cash', '2025-01-25T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0987566511';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉苡安', '0987566511') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'transfer', '2025-01-25T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0968434711';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃薇竹', '0968434711') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-01-25T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 200, 'paid', 'cash', '2025-01-25T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 400, 'paid', 'transfer', '2025-01-25T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0972123863';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧雅云Jenny', '0972123863') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-01-26T22:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0963009722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡君', '0963009722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2690, 'paid', 'cash', '2025-01-26T23:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0989348320';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范欣瑜', '0989348320') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10120, 'paid', 'transfer', '2025-01-26T23:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5270, 'paid', 'transfer', '2025-01-26T23:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0977719040';
  if v_customer_id is null then
    insert into customers (name, phone) values ('祈', '0977719040') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2025-01-26T23:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3300, 'paid', 'transfer', '2025-01-26T23:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0979120610';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳思靜', '0979120610') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-01-26T23:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1600, 1);

  select id into v_customer_id from customers where phone = '0919251667';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李冠儒', '0919251667') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2025-01-26T23:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0970604732';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱茜', '0970604732') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4960, 'paid', 'transfer', '2025-01-27T20:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0912970550';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賴奕君', '0912970550') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6980, 'paid', 'transfer', '2025-01-27T20:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6020, 'paid', 'cash', '2025-01-27T20:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0920057450';
  if v_customer_id is null then
    insert into customers (name, phone) values ('任以心', '0920057450') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2025-01-28T16:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0923625162';
  if v_customer_id is null then
    insert into customers (name, phone) values ('柔安', '0923625162') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'cash', '2025-01-28T16:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0910517881';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張小倫', '0910517881') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3690, 'paid', 'cash', '2025-01-28T16:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0988390261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳昱安', '0988390261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-29T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0911214186';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉于嘉', '0911214186') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6200, 'paid', 'transfer', '2025-01-29T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0937402735';
  if v_customer_id is null then
    insert into customers (name, phone) values ('傅喬', '0937402735') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4700, 'paid', 'cash', '2025-01-29T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0937990374';
  if v_customer_id is null then
    insert into customers (name, phone) values ('駱盈惠', '0937990374') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'cash', '2025-01-29T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0937996763';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Tiff', '0937996763') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-01-29T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933973450';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳台莉', '0933973450') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3380, 'paid', 'cash', '2025-01-30T14:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0988552300';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daisy', '0988552300') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-01-30T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933550068';
  if v_customer_id is null then
    insert into customers (name, phone) values ('丁孟冬', '0933550068') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-30T21:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0926573680';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡宛真', '0926573680') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-01-30T21:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0989387627';
  if v_customer_id is null then
    insert into customers (name, phone) values ('丁巧蘋', '0989387627') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5320, 'paid', 'transfer', '2025-01-30T21:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0975176063';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芳如', '0975176063') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5700, 'paid', 'transfer', '2025-01-31T20:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0933176929';
  if v_customer_id is null then
    insert into customers (name, phone) values ('呂畇萱', '0933176929') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-01-31T20:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'cash', '2025-01-31T20:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3160, 'paid', 'cash', '2025-01-31T20:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);

  select id into v_customer_id from customers where phone = '0983890338';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Kelly', '0983890338') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2025-01-31T20:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910535791';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李曉嵐', '0910535791') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-01-31T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 3000, 'paid', 'cash', '2025-02-01T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0914066355';
  if v_customer_id is null then
    insert into customers (name, phone) values ('藍詠晴', '0914066355') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8020, 'paid', 'cash', '2025-02-01T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0936335362';
  if v_customer_id is null then
    insert into customers (name, phone) values ('としえ', '0936335362') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3240, 'paid', 'transfer', '2025-02-01T21:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0906895415';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝依劭', '0906895415') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-02-01T21:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0910121055';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美如', '0910121055') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'cash', '2025-02-01T21:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0908156465';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐靖雯', '0908156465') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-02-02T22:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0958871098';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳麗年', '0958871098') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-02T22:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0935939312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉美憶', '0935939312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-02-02T22:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0936050947';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾雨儂', '0936050947') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7700, 'paid', 'transfer', '2025-02-02T22:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2025-02-02T22:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0916829325';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊佳佳', '0916829325') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2600, 'paid', 'cash', '2025-02-02T22:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0937837896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃士德', '0937837896') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-02-02T22:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-02-03T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0927230633';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾椲涵', '0927230633') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8220, 'paid', 'transfer', '2025-02-03T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0978182618';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范筱君', '0978182618') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-02-03T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0979715989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0979715989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'cash', '2025-02-04T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 2800, 1);

  select id into v_customer_id from customers where phone = '0975075855';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daphnë', '0975075855') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7100, 'paid', 'transfer', '2025-02-04T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0929150208';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉瑾璇', '0929150208') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8820, 'paid', 'transfer', '2025-02-04T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0988268722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈佩臻', '0988268722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5620, 'paid', 'cash', '2025-02-05T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0925197885';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉叡芩', '0925197885') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'cash', '2025-02-05T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 3);

  select id into v_customer_id from customers where phone = '0911069147';
  if v_customer_id is null then
    insert into customers (name, phone) values ('怡晴', '0911069147') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-02-05T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919506866';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游雅淳', '0919506866') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-02-05T20:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0963305408';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭雅玲', '0963305408') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2025-02-05T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);

  select id into v_customer_id from customers where phone = '0963055205';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪珮華', '0963055205') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'cash', '2025-02-05T20:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);

  select id into v_customer_id from customers where phone = '0927230633';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾椲涵', '0927230633') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-02-08T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0958603566';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游媛婷', '0958603566') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2025-02-08T18:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919251667';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李冠儒', '0919251667') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2025-02-08T18:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'cash', '2025-02-08T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2025-02-08T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3490, 'paid', 'transfer', '2025-02-09T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0973682048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雯文', '0973682048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-02-09T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0928521791';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡冠芸', '0928521791') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'cash', '2025-02-09T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-09T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4350, 'paid', 'transfer', '2025-02-09T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);

  select id into v_customer_id from customers where phone = '0970310628';
  if v_customer_id is null then
    insert into customers (name, phone) values ('采潔', '0970310628') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'transfer', '2025-02-21T20:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0970071906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('娟', '0970071906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3210, 'paid', 'cash', '2025-02-21T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '塑捲調理霜', 1130, 1);

  select id into v_customer_id from customers where phone = '0938873027';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉欣怡', '0938873027') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-02-21T20:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0921019383';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李嘉玲', '0921019383') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8500, 'paid', 'transfer', '2025-02-21T20:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(加購)自然捲夾順', 1000, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3760, 'paid', 'transfer', '2025-02-23T18:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0937014371';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃淨音', '0937014371') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-02-23T18:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-02-23T18:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4100, 'paid', 'transfer', '2025-02-23T18:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2025-02-23T18:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0975717311';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱筱彤', '0975717311') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-02-24T19:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0987889685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖玉涵', '0987889685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5900, 'paid', 'transfer', '2025-02-24T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0987952059';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sabrina', '0987952059') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3870, 'paid', 'cash', '2025-02-24T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '塑捲調理霜', 1230, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'transfer', '2025-02-24T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1230, 'paid', 'transfer', '2025-02-24T19:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '塑捲調理霜', 1230, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'cash', '2025-02-25T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'transfer', '2025-02-25T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988452195';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Olive', '0988452195') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2025-02-25T17:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0955653645';
  if v_customer_id is null then
    insert into customers (name, phone) values ('高寧憶', '0955653645') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-02-25T17:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0963307597';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儷安', '0963307597') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5520, 'paid', 'transfer', '2025-02-26T16:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2560, 'paid', 'cash', '2025-02-26T16:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);

  select id into v_customer_id from customers where phone = '0975213768';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊旻芝', '0975213768') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5700, 'paid', 'cash', '2025-02-26T16:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2950, 'paid', 'transfer', '2025-02-26T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '硬漢持久髮膠(藍)150ml', 630, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0976396261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪銘陽', '0976396261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-27T20:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917241515';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0917241515') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-27T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-27T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0983899666';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃宇潔', '0983899666') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2025-02-27T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0921944787';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃卉儀', '0921944787') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-27T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2025-02-27T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0916269948';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Karen', '0916269948') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-02-27T20:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0933098614';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉彥君', '0933098614') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8880, 'paid', 'transfer', '2025-02-27T22:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '22合1修護噴霧150ml', 1080, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2025-02-28T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0912667276';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳巧瑩', '0912667276') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-02-28T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0909089719';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾佳欣', '0909089719') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-02-28T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2025-02-28T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0933904454';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采一', '0933904454') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-02-28T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'cash', '2025-02-28T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1360, 'paid', 'cash', '2025-03-01T13:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0985864709';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張晴芳', '0985864709') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-03-01T22:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0953313602';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉依潔', '0953313602') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2120, 'paid', 'cash', '2025-03-01T22:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0989151264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周晏綸', '0989151264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-03-01T22:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3780, 'paid', 'transfer', '2025-03-02T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0918783600';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sharon', '0918783600') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-03-02T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0973682048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雯文', '0973682048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-03-02T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0916348063';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佳汝', '0916348063') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7360, 'paid', 'transfer', '2025-03-02T19:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'cash', '2025-03-02T19:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975116166';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林貞岑', '0975116166') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3280, 'paid', 'transfer', '2025-03-03T20:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0965380484';
  if v_customer_id is null then
    insert into customers (name, phone) values ('ESTHER C.', '0965380484') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3840, 'paid', 'cash', '2025-03-03T22:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '保水面膜', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1240, 1);

  select id into v_customer_id from customers where phone = '0913757195';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周純', '0913757195') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-03-03T22:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0935576207';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曹雅晴', '0935576207') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8100, 'paid', 'transfer', '2025-03-03T22:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 630, 'paid', 'cash', '2025-03-06T15:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'FOAM白光氣墊慕斯[4]180g', 630, 1);

  select id into v_customer_id from customers where phone = '0937964399';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李柏儀', '0937964399') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-07T16:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-03-07T16:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0960357153';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林盈君', '0960357153') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-03-07T17:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3300, 'paid', 'transfer', '2025-03-08T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0925209871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳真如', '0925209871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2640, 'paid', 'cash', '2025-03-08T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0922210176';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙庭涓', '0922210176') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-03-08T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0937227828';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芳而', '0937227828') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-08T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933263787';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王梅蘭', '0933263787') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5620, 'paid', 'transfer', '2025-03-08T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0988032481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭如君', '0988032481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5320, 'paid', 'transfer', '2025-03-09T21:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0936335362';
  if v_customer_id is null then
    insert into customers (name, phone) values ('としえ', '0936335362') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-03-09T21:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988516806';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周彥廷', '0988516806') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'transfer', '2025-03-09T21:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0973933934';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江思眉', '0973933934') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5620, 'paid', 'cash', '2025-03-09T21:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1120, 1);

  select id into v_customer_id from customers where phone = '0975382650';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昱辰', '0975382650') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-03-10T20:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2520, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2025-03-10T20:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2025-03-10T20:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0963616156';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芯鈺', '0963616156') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-03-10T20:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2800, 1);

  select id into v_customer_id from customers where phone = '0908325157';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈昕潔', '0908325157') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7370, 'paid', 'transfer', '2025-03-10T20:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2250, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0979812660';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡育玲', '0979812660') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-03-10T20:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'transfer', '2025-03-10T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2800, 'paid', 'transfer', '2025-03-11T15:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 2800, 1);

  select id into v_customer_id from customers where phone = '0909240707';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳韋如', '0909240707') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-03-13T19:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0905508672';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉芝佑', '0905508672') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5880, 'paid', 'cash', '2025-03-13T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1140, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4900, 'paid', 'transfer', '2025-03-13T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5780, 'paid', 'cash', '2025-03-13T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0913359910';
  if v_customer_id is null then
    insert into customers (name, phone) values ('矯伊玲', '0913359910') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-03-14T20:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0921501907';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃富柔', '0921501907') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-03-14T20:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-14T20:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0906766979';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳秋甯', '0906766979') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'cash', '2025-03-14T20:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0917507243';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭芳慈', '0917507243') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-03-14T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0903472026';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張旭珊', '0903472026') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1280, 'paid', 'cash', '2025-03-14T21:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0926768886';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子筠', '0926768886') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6040, 'paid', 'cash', '2025-03-15T20:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);

  select id into v_customer_id from customers where phone = '0987288008';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉亭夆', '0987288008') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8580, 'paid', 'transfer', '2025-03-15T20:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0928566162';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏汶芳', '0928566162') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6820, 'paid', 'transfer', '2025-03-15T20:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3030, 'paid', 'transfer', '2025-03-15T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'ILGA平衡修護膜(M)200g', 710, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0912012940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳逸芸', '0912012940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4320, 'paid', 'transfer', '2025-03-15T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0979715989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0979715989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'cash', '2025-03-16T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 2800, 1);

  select id into v_customer_id from customers where phone = '0981718996';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李銓', '0981718996') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'cash', '2025-03-16T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0928690099';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊璦維', '0928690099') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'cash', '2025-03-16T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0988908027';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張曼琳', '0988908027') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6800, 'paid', 'transfer', '2025-03-16T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0911876723';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許雅涵', '0911876723') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-03-16T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0988268722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈佩臻', '0988268722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10780, 'paid', 'transfer', '2025-03-18T22:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'cash', '2025-03-18T22:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1620, 'paid', 'transfer', '2025-03-18T22:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0928553240';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江欣樺', '0928553240') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3240, 'paid', 'transfer', '2025-03-19T16:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0972523930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采築', '0972523930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2080, 'paid', 'cash', '2025-03-19T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0910517881';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張小倫', '0910517881') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7200, 'paid', 'cash', '2025-03-20T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0972521928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱貞禎', '0972521928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-03-20T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0934040128';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張譽馨', '0934040128') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2025-03-20T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2620, 'paid', 'transfer', '2025-03-20T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '日常抗老精華', 1220, 1);

  select id into v_customer_id from customers where phone = '0928877849';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾彤', '0928877849') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-20T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'transfer', '2025-03-21T21:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'cash', '2025-03-21T21:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0909001988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余孟庭', '0909001988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'cash', '2025-03-21T21:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草三合一', 2300, 1);

  select id into v_customer_id from customers where phone = '0936228937';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳偉謙', '0936228937') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-21T21:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928972081';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃詩晴', '0928972081') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2025-03-21T21:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6040, 'paid', 'cash', '2025-03-21T21:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脫洗髮精', 2880, 1);

  select id into v_customer_id from customers where phone = '0920701224';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭怡喬', '0920701224') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6740, 'paid', 'transfer', '2025-03-22T20:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6440, 'paid', 'transfer', '2025-03-22T20:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0987879867';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范雅智', '0987879867') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2025-03-22T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2025-03-22T20:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0930230518';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周胤汝', '0930230518') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2025-03-22T21:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0936682621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏婕安', '0936682621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-23T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-03-23T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921516759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝嘉容', '0921516759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'cash', '2025-03-23T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0930131185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐念琪', '0930131185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-23T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0931200940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷喻', '0931200940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-23T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-23T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0963367919';
  if v_customer_id is null then
    insert into customers (name, phone) values ('巫玟璇', '0963367919') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10400, 'paid', 'transfer', '2025-03-24T15:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0932312679';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭詩韋', '0932312679') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-03-24T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0987952059';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sabrina', '0987952059') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-26T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0932224387';
  if v_customer_id is null then
    insert into customers (name, phone) values ('朱怡 Elaine', '0932224387') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4700, 'paid', 'cash', '2025-03-26T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0920116657';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩凌', '0920116657') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4340, 'paid', 'transfer', '2025-03-26T20:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0955152621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范蓉姍', '0955152621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4480, 'paid', 'transfer', '2025-03-26T20:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0988192181';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃雯捷', '0988192181') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'transfer', '2025-03-26T20:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0987263969';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷嬋', '0987263969') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2025-03-27T19:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0978511132';
  if v_customer_id is null then
    insert into customers (name, phone) values ('顏曼娟', '0978511132') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3290, 'paid', 'transfer', '2025-03-27T19:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);

  select id into v_customer_id from customers where phone = '0937556533';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭', '0937556533') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8900, 'paid', 'transfer', '2025-03-27T19:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0954039906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('饒翊平', '0954039906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2025-03-27T19:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2025-03-28T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-03-28T20:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0972603230';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃聖雅', '0972603230') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3280, 'paid', 'cash', '2025-03-29T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3770, 'paid', 'transfer', '2025-03-29T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0928269538';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳信彣', '0928269538') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9840, 'paid', 'cash', '2025-03-29T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '每日溫和洗髮露', 940, 1);

  select id into v_customer_id from customers where phone = '0936536912';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑞妤', '0936536912') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6600, 'paid', 'transfer', '2025-03-29T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0963176318';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Kris', '0963176318') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-03-29T19:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0970310628';
  if v_customer_id is null then
    insert into customers (name, phone) values ('采潔', '0970310628') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3190, 'paid', 'transfer', '2025-03-30T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(短髮)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0975015350';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李怡萱', '0975015350') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-03-30T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2800, 1);

  select id into v_customer_id from customers where phone = '0910874590';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Rita', '0910874590') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2025-03-30T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-03-30T20:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

end $do$;

-- 執行完請對照下面這行查詢結果（應該是 訂單數 = 305、現場實收合計 = 1019520）
select count(*) as 訂單數, coalesce(sum(total), 0) as 現場實收合計 from orders where created_at >= '2025-01-01T00:00:00+08:00' and created_at < '2025-04-01T00:00:00+08:00' and (payment_method is not null or total = 0);
