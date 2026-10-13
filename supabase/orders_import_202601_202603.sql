-- 匯入 2026-01 ~ 2026-03 訂單列表（來自神美匯出的每月訂單列表）
-- orders.total 只算「現場付款」的現金/匯款實收，商品券折抵的部分不重複算營業額（跟 9 月匯入的規則一致）；
-- 每一筆訂單照樣建立（total 可能是 0），客人的消費次數／最近消費才會正確。order_items.price 存的是「單價」。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if exists (select 1 from orders where created_at >= '2026-01-01T00:00:00+08:00' and created_at < '2026-04-01T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '這段期間的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0988452195';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Olive', '0988452195') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2026-01-01T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0920394686';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Gina', '0920394686') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-01-01T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933973450';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳台莉', '0933973450') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3380, 'paid', 'cash', '2026-01-01T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0936056500';
  if v_customer_id is null then
    insert into customers (name, phone) values ('莊絜晰', '0936056500') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8390, 'paid', 'transfer', '2026-01-01T19:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 3600, 2);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2026-01-02T21:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0921403949';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐淳雅', '0921403949') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'transfer', '2026-01-02T21:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0914066355';
  if v_customer_id is null then
    insert into customers (name, phone) values ('藍詠晴', '0914066355') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7800, 'paid', 'cash', '2026-01-02T21:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);

  select id into v_customer_id from customers where phone = '0975225923';
  if v_customer_id is null then
    insert into customers (name, phone) values ('何絲雅', '0975225923') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-01-02T21:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8520, 'paid', 'cash', '2026-01-03T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0988813025';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡佳威', '0988813025') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-01-03T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0972603230';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃聖雅', '0972603230') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-01-03T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-01-03T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0923368319';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖敏惠', '0923368319') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-01-03T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-03T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4340, 'paid', 'transfer', '2026-01-04T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0958265458';
  if v_customer_id is null then
    insert into customers (name, phone) values ('何宜', '0958265458') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-04T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0911403684';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝宛芝', '0911403684') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5130, 'paid', 'transfer', '2026-01-04T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'FOAM白光氣墊慕斯[4]180g', 630, 1);

  select id into v_customer_id from customers where phone = '0912667276';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳巧瑩', '0912667276') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'transfer', '2026-01-04T20:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2026-01-04T20:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0928520809';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張童千', '0928520809') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2026-01-05T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0975116166';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林貞岑', '0975116166') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3280, 'paid', 'transfer', '2026-01-05T17:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0937856809';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Adeline Lee', '0937856809') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-01-05T17:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-01-05T21:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0954039906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('饒翊平', '0954039906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'cash', '2026-01-08T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及腰）', 6000, 1);

  select id into v_customer_id from customers where phone = '0988268722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈佩臻', '0988268722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8600, 'paid', 'transfer', '2026-01-08T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0980988240';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林沂臻', '0980988240') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2280, 'paid', 'cash', '2026-01-08T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0983158131';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭寓懃', '0983158131') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-01-08T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988391471';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張嘉芬', '0988391471') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3000, 'paid', 'transfer', '2026-01-09T18:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0988933481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯語', '0988933481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1260, 'paid', 'cash', '2026-01-09T18:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0919787688';
  if v_customer_id is null then
    insert into customers (name, phone) values ('詹于箴', '0919787688') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-01-09T18:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0934029569';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方瀅雲', '0934029569') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-01-09T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0966297741';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林', '0966297741') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-01-09T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0912271251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李曉娟', '0912271251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'transfer', '2026-01-10T19:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0910121055';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美如', '0910121055') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'cash', '2026-01-10T19:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928269538';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳信彣', '0928269538') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10520, 'paid', 'cash', '2026-01-10T19:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0958020228';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳奕葭', '0958020228') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3580, 'paid', 'transfer', '2026-01-10T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0919377316';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳宛蓉', '0919377316') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5540, 'paid', 'transfer', '2026-01-10T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928566162';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏汶芳', '0928566162') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2320, 'paid', 'transfer', '2026-01-11T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);

  select id into v_customer_id from customers where phone = '0931290520';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊秀玲', '0931290520') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2026-01-11T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-11T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 11160, 'paid', 'cash', '2026-01-11T20:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 2);

  select id into v_customer_id from customers where phone = '0955691228';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇豈俐carrie', '0955691228') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5000, 'paid', 'transfer', '2026-01-12T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及腰）', 5000, 1);

  select id into v_customer_id from customers where phone = '0988124116';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳盈如', '0988124116') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'transfer', '2026-01-12T18:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'cash', '2026-01-13T14:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0900509652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('喻靖洧', '0900509652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2100, 'paid', 'cash', '2026-01-13T14:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-01-13T21:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0920036614';
  if v_customer_id is null then
    insert into customers (name, phone) values ('杜盈萱', '0920036614') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-01-13T21:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0987952059';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sabrina', '0987952059') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'cash', '2026-01-17T21:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3330, 'paid', 'transfer', '2026-01-17T21:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  select id into v_customer_id from customers where phone = '0926052424';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周秋燕', '0926052424') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2320, 'paid', 'transfer', '2026-01-17T21:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);

  select id into v_customer_id from customers where phone = '0975382650';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昱辰', '0975382650') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-17T21:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0987889685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖玉涵', '0987889685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4080, 'paid', 'transfer', '2026-01-17T21:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0937402735';
  if v_customer_id is null then
    insert into customers (name, phone) values ('傅喬', '0937402735') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'cash', '2026-01-18T19:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0928007269';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賴丁霞', '0928007269') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'cash', '2026-01-18T19:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-18T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0926632756';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊允禾', '0926632756') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'cash', '2026-01-18T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0933539826';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賈斯嘉', '0933539826') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2330, 'paid', 'transfer', '2026-01-18T19:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-01-19T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0911892048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余蘋', '0911892048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-01-19T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5920, 'paid', 'transfer', '2026-01-19T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2026-01-19T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'cash', '2026-01-19T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0919251667';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李冠儒', '0919251667') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6760, 'paid', 'cash', '2026-01-19T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  select id into v_customer_id from customers where phone = '0911003274';
  if v_customer_id is null then
    insert into customers (name, phone) values ('俞', '0911003274') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-01-20T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-01-20T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1800, 'paid', 'transfer', '2026-01-20T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 1800, 1);

  select id into v_customer_id from customers where phone = '0954039906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('饒翊平', '0954039906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-01-22T12:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-01-23T21:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-23T21:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-01-23T21:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0928520809';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張童千', '0928520809') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-01-23T21:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988293121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐紫絜', '0988293121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-01-23T21:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'transfer', '2026-01-24T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-01-24T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 12100, 'paid', 'cash', '2026-01-24T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 3);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0977719040';
  if v_customer_id is null then
    insert into customers (name, phone) values ('祈', '0977719040') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'cash', '2026-01-25T21:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0936720600';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐嫚謙', '0936720600') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-25T21:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937040832';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭又慈', '0937040832') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2026-01-25T21:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0928995183';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王詞雅', '0928995183') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5360, 'paid', 'transfer', '2026-01-25T21:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-01-25T21:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0978121503';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許庭瑄', '0978121503') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-01-25T21:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0984101221';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊靜慧', '0984101221') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-01-26T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0923868733';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊喬云', '0923868733') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-01-26T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0936335362';
  if v_customer_id is null then
    insert into customers (name, phone) values ('としえ', '0936335362') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-01-26T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0975075855';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daphnë', '0975075855') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-01-26T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-01-26T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0973240827';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子妍', '0973240827') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3040, 'paid', 'transfer', '2026-01-26T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2026-01-27T15:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0913319331';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱宇芝', '0913319331') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'cash', '2026-01-27T15:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(及肩)', 3200, 1);

  select id into v_customer_id from customers where phone = '0921754136';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昀蓁', '0921754136') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-01-27T15:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0937117489';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃宇涵', '0937117489') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-01-27T16:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-01-27T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0928972081';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃詩晴', '0928972081') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2026-01-28T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0937227828';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芳而', '0937227828') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3520, 'paid', 'transfer', '2026-01-28T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '挑染(肩上)', 2560, 1);

  select id into v_customer_id from customers where phone = '0933869750';
  if v_customer_id is null then
    insert into customers (name, phone) values ('烏少瑾', '0933869750') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 500, 'paid', 'cash', '2026-01-28T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 500, 1);

  select id into v_customer_id from customers where phone = '0912147891';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝依潔', '0912147891') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9800, 'paid', 'transfer', '2026-01-28T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0937033084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('于學慧', '0937033084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3700, 'paid', 'cash', '2026-01-28T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-01-30T18:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);

  select id into v_customer_id from customers where phone = '0919047071';
  if v_customer_id is null then
    insert into customers (name, phone) values ('歐小姐', '0919047071') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-01-30T18:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937556533';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭', '0937556533') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4240, 'paid', 'transfer', '2026-01-30T18:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 2160, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);

  select id into v_customer_id from customers where phone = '0963009722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡君', '0963009722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7320, 'paid', 'cash', '2026-01-30T18:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱精華液', 1590, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 4170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然力長效修護髮膜', 0, 1);

  select id into v_customer_id from customers where phone = '0928685432';
  if v_customer_id is null then
    insert into customers (name, phone) values ('湯璧禎', '0928685432') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 13930, 'paid', 'transfer', '2026-01-31T20:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 4170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然力長效修護髮膜', 0, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10560, 'paid', 'transfer', '2026-01-31T20:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 3020, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '超閃耀髪霧', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);

  select id into v_customer_id from customers where phone = '0977719040';
  if v_customer_id is null then
    insert into customers (name, phone) values ('祈', '0977719040') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'cash', '2026-01-31T20:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988224523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王薇嵐', '0988224523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'cash', '2026-01-31T20:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-01-31T20:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-02-01T19:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0976445882';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳家琪', '0976445882') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-02-02T19:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0970071906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('娟', '0970071906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-02-02T19:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 15610, 'paid', 'cash', '2026-02-02T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  select id into v_customer_id from customers where phone = '0910528819';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙昱璇', '0910528819') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'transfer', '2026-02-02T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2026-02-02T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-02-03T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0936056500';
  if v_customer_id is null then
    insert into customers (name, phone) values ('莊絜晰', '0936056500') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-03T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0905508672';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉芝佑', '0905508672') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-02-03T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0981998638';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林榆真', '0981998638') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-02-03T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0921516759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝嘉容', '0921516759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-02-03T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0937964399';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李柏儀', '0937964399') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3650, 'paid', 'cash', '2026-02-04T13:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1610, 1);

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-04T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3810, 'paid', 'cash', '2026-02-04T18:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 2850, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 0, 1);

  select id into v_customer_id from customers where phone = '0910731516';
  if v_customer_id is null then
    insert into customers (name, phone) values ('May', '0910731516') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'cash', '2026-02-04T18:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮淨化(含水飛梭)', 2000, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-04T18:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-06T18:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0983133923';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐詩婷', '0983133923') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10350, 'paid', 'transfer', '2026-02-06T18:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 2850, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 0, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3730, 'paid', 'transfer', '2026-02-06T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4460, 'paid', 'transfer', '2026-02-07T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9640, 'paid', 'transfer', '2026-02-08T22:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0930140800';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡良芸', '0930140800') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-02-08T22:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-02-08T22:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0989348320';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范欣瑜', '0989348320') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7420, 'paid', 'transfer', '2026-02-08T22:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0978261380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝巧羿', '0978261380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8020, 'paid', 'transfer', '2026-02-08T22:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1520, 'paid', 'transfer', '2026-02-08T22:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 360, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0975653693';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡欣如', '0975653693') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-09T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937176884';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭瑞文', '0937176884') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5250, 'paid', 'cash', '2026-02-09T19:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '超閃耀髪霧', 1250, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'transfer', '2026-02-09T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0911590202';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張怡婷', '0911590202') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 12500, 'paid', 'cash', '2026-02-10T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0913171309';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳靜怡', '0913171309') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-02-10T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975873231';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭允琦', '0975873231') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-02-10T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2026-02-10T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0985556652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳曉思', '0985556652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1360, 'paid', 'transfer', '2026-02-10T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3330, 'paid', 'transfer', '2026-02-10T19:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活在生頭皮精華-乾敏(綠)', 3330, 1);

  select id into v_customer_id from customers where phone = '0978285582';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱郁心', '0978285582') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-02-11T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-11T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988032481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭如君', '0988032481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6560, 'paid', 'transfer', '2026-02-11T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0981087713';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0981087713') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-02-11T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'transfer', '2026-02-13T17:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933933931';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃奕寧', '0933933931') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6410, 'paid', 'transfer', '2026-02-13T17:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3500, 'paid', 'transfer', '2026-02-13T17:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-13T17:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0934029569';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方瀅雲', '0934029569') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-02-13T17:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0928799066';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳岱蓉', '0928799066') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7800, 'paid', 'transfer', '2026-02-14T18:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-02-14T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0921222451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃淳靖', '0921222451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'transfer', '2026-02-14T18:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0918082672';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范書寧', '0918082672') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-02-14T18:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0931228196';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊景辰', '0931228196') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-02-15T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5100, 'paid', 'transfer', '2026-02-15T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '鉑金純銀洗髮露', 1140, 1);

  select id into v_customer_id from customers where phone = '0912012940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳逸芸', '0912012940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-15T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0986456581';
  if v_customer_id is null then
    insert into customers (name, phone) values ('翁瑋憶', '0986456581') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2210, 'paid', 'transfer', '2026-02-15T19:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '超閃耀髪霧', 1250, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-02-15T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0982877852';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張智雁', '0982877852') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2026-02-15T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 800, 1);

  select id into v_customer_id from customers where phone = '0935939312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉美憶', '0935939312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'cash', '2026-02-16T22:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0923876366';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭嘉茵', '0923876366') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'transfer', '2026-02-16T22:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0920890409';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉品安', '0920890409') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-02-16T22:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-02-17T19:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0909001988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余孟庭', '0909001988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-02-17T19:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-02-17T19:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972763177';
  if v_customer_id is null then
    insert into customers (name, phone) values ('風一揚', '0972763177') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-02-17T19:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-02-17T19:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0955168125';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Lindsey', '0955168125') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-02-17T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4340, 'paid', 'transfer', '2026-02-18T21:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0937996763';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Tiff', '0937996763') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'cash', '2026-02-18T21:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0975690102';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐郁昕', '0975690102') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 11100, 'paid', 'transfer', '2026-02-18T21:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2210, 'paid', 'transfer', '2026-02-19T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 1250, 1);

  select id into v_customer_id from customers where phone = '0928566162';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏汶芳', '0928566162') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-02-19T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0932456436';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江怡惠', '0932456436') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5200, 'paid', 'cash', '2026-02-19T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 2000, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1080, 'paid', 'cash', '2026-02-19T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0963307597';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儷安', '0963307597') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'transfer', '2026-02-20T21:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988452195';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Olive', '0988452195') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2026-02-20T21:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0975653693';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡欣如', '0975653693') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3280, 'paid', 'transfer', '2026-02-20T21:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2026-02-21T12:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-02-21T20:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0952690420';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱荷閔', '0952690420') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-02-21T20:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-02-21T20:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0972603230';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃聖雅', '0972603230') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2026-02-21T20:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-02-22T17:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930277185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王立文', '0930277185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2026-02-22T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0972343929';
  if v_customer_id is null then
    insert into customers (name, phone) values ('顏汝瑩', '0972343929') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-02-22T17:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0916184656';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張可薇', '0916184656') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3700, 'paid', 'cash', '2026-02-22T17:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-02-22T18:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 980, 'paid', 'transfer', '2026-02-22T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 980, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4200, 'paid', 'cash', '2026-02-23T17:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0978361882';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳嘉逸', '0978361882') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-02-24T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 3000, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-02-24T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-02-24T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921315697';
  if v_customer_id is null then
    insert into customers (name, phone) values ('梁馨月', '0921315697') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3900, 'paid', 'cash', '2026-02-24T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(肩上)', 2700, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-02-26T17:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0939606226';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃琳萱', '0939606226') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2026-02-26T17:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2026-02-26T17:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'transfer', '2026-02-26T17:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0903472026';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張旭珊', '0903472026') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'cash', '2026-02-27T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2026-02-27T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0920116657';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩凌', '0920116657') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5380, 'paid', 'transfer', '2026-02-27T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0978665271';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉采蕙', '0978665271') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-02-27T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988506961';
  if v_customer_id is null then
    insert into customers (name, phone) values ('侯彥淩', '0988506961') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5720, 'paid', 'transfer', '2026-02-27T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0919211445';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑜臻', '0919211445') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-02-27T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0980700179';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張嘉玲', '0980700179') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-02-28T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0926149889';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭小妍', '0926149889') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2026-02-28T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'transfer', '2026-02-28T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0910095445';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡佳吟', '0910095445') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7020, 'paid', 'transfer', '2026-02-28T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0958603566';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游媛婷', '0958603566') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2760, 'paid', 'transfer', '2026-02-28T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0963532123';
  if v_customer_id is null then
    insert into customers (name, phone) values ('倪家羚', '0963532123') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9120, 'paid', 'transfer', '2026-03-01T14:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-03-01T18:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0910121055';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美如', '0910121055') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-01T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0983682185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('房蔓君', '0983682185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-03-01T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0972155749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李金穎', '0972155749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-02T14:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0975728139';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾馨儀', '0975728139') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-03-02T17:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-02T17:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0930131185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐念琪', '0930131185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'cash', '2026-03-03T14:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2026-03-03T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0910397216';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江柔妮', '0910397216') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-03-04T18:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-04T18:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0982013249';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張慧中', '0982013249') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-04T18:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933477429';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡力伶', '0933477429') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7900, 'paid', 'transfer', '2026-03-04T18:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-03-04T19:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'transfer', '2026-03-06T18:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);

  select id into v_customer_id from customers where phone = '0930964133';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳玉君', '0930964133') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3800, 'paid', 'cash', '2026-03-06T18:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2600, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3960, 'paid', 'transfer', '2026-03-06T18:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0970604732';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱茜', '0970604732') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2026-03-06T18:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 12700, 'paid', 'cash', '2026-03-07T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 2);

  select id into v_customer_id from customers where phone = '0989382255';
  if v_customer_id is null then
    insert into customers (name, phone) values ('阮仕琳', '0989382255') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-03-07T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0988367591';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Ruwen', '0988367591') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-03-07T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1080, 'paid', 'cash', '2026-03-07T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-03-08T15:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-03-08T19:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2780, 'paid', 'transfer', '2026-03-08T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0911421595';
  if v_customer_id is null then
    insert into customers (name, phone) values ('粘蕙麗', '0911421595') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3840, 'paid', 'transfer', '2026-03-08T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0989427278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃鈺雅', '0989427278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-03-08T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921033528';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張雅晴', '0921033528') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-08T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-03-08T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-09T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921856701';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Michelle', '0921856701') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'cash', '2026-03-09T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-09T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958972965';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Yun', '0958972965') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8080, 'paid', 'cash', '2026-03-09T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);

  select id into v_customer_id from customers where phone = '0912399560';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佳蓉8126', '0912399560') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-10T14:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4040, 'paid', 'cash', '2026-03-10T15:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);

  select id into v_customer_id from customers where phone = '0936890683';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳孟筑', '0936890683') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-11T17:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0978163367';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳羿廷', '0978163367') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-11T17:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0989660438';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡安', '0989660438') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-03-11T17:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'cash', '2026-03-13T20:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988703707';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐語晨', '0988703707') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-03-13T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-03-14T14:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1540, 'paid', 'transfer', '2026-03-14T14:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 180, 1);

  select id into v_customer_id from customers where phone = '0937033084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('于學慧', '0937033084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-14T18:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2026-03-14T18:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0972755684';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱秀慧', '0972755684') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7200, 'paid', 'transfer', '2026-03-14T18:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'transfer', '2026-03-14T18:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4580, 'paid', 'transfer', '2026-03-15T17:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0931200940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷喻', '0931200940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-03-15T17:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0912197260';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾念蓁', '0912197260') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-15T17:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-03-15T17:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2026-03-15T17:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2026-03-15T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4820, 'paid', 'transfer', '2026-03-21T18:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮梳', 900, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4500, 'paid', 'transfer', '2026-03-21T18:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0910029905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Minnie', '0910029905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-03-21T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0930571516';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古庭榕', '0930571516') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-03-23T19:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-03-23T19:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0989626409';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯筠', '0989626409') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 11640, 'paid', 'transfer', '2026-03-23T19:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1190, 'paid', 'cash', '2026-03-23T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0988813025';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡佳威', '0988813025') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3960, 'paid', 'transfer', '2026-03-24T16:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0970715807';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅梓齊', '0970715807') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3280, 'paid', 'transfer', '2026-03-24T16:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0921882891';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭智萱', '0921882891') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-24T16:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'cash', '2026-03-24T19:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0973682048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雯文', '0973682048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1960, 'paid', 'cash', '2026-03-24T19:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 980, 2);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1100, 'paid', 'transfer', '2026-03-27T13:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3390, 'paid', 'transfer', '2026-03-27T13:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 32690, 'paid', 'cash', '2026-03-27T13:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 3);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 3);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0934323242';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳絜妤', '0934323242') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-03-28T13:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988933481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯語', '0988933481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-28T13:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0966297741';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林', '0966297741') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-03-28T15:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0979105175';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭曉君', '0979105175') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-03-28T15:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929106781';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佳真', '0929106781') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-03-28T16:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-03-28T19:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 3360, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2430, 'paid', 'transfer', '2026-03-28T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2220, 'paid', 'cash', '2026-03-29T16:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '日常抗老精華', 1220, 1);

  select id into v_customer_id from customers where phone = '0977719040';
  if v_customer_id is null then
    insert into customers (name, phone) values ('祈', '0977719040') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-03-29T18:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0900509652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('喻靖洧', '0900509652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2100, 'paid', 'cash', '2026-03-29T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0987288008';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉亭夆', '0987288008') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9200, 'paid', 'transfer', '2026-03-29T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及腰)', 3060, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1140, 1);

  select id into v_customer_id from customers where phone = '0926768886';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子筠', '0926768886') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5860, 'paid', 'transfer', '2026-03-29T18:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0936536912';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑞妤', '0936536912') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'cash', '2026-03-30T12:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 2160, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-03-31T16:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

end $do$;

-- 執行完請對照下面這行查詢結果（應該是 訂單數 = 291、現場實收合計 = 976570）
select count(*) as 訂單數, coalesce(sum(total), 0) as 現場實收合計 from orders where created_at >= '2026-01-01T00:00:00+08:00' and created_at < '2026-04-01T00:00:00+08:00' and (payment_method is not null or total = 0);
