-- 匯入 2026-04 ~ 2026-06 訂單列表（來自神美匯出的每月訂單列表）
-- orders.total 只算「現場付款」的現金/匯款實收，商品券折抵的部分不重複算營業額（跟 9 月匯入的規則一致）；
-- 每一筆訂單照樣建立（total 可能是 0），客人的消費次數／最近消費才會正確。order_items.price 存的是「單價」。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if exists (select 1 from orders where created_at >= '2026-04-01T00:00:00+08:00' and created_at < '2026-07-01T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '這段期間的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-01T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921342759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡文綺', '0921342759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-01T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-01T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0975075855';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daphnë', '0975075855') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2026-04-01T18:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0928830645';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳秀琴', '0928830645') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-01T18:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-04-02T13:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0963616156';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芯鈺', '0963616156') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8640, 'paid', 'transfer', '2026-04-02T18:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0928520809';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張童千', '0928520809') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-04-02T18:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-02T18:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910688896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王奕之', '0910688896') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3530, 'paid', 'transfer', '2026-04-03T15:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-乾屑敏(紅)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-03T17:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0987352882';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佩樺', '0987352882') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'cash', '2026-04-03T18:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0912271251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李曉娟', '0912271251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'cash', '2026-04-03T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0972603230';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃聖雅', '0972603230') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-04-05T17:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988114877';
  if v_customer_id is null then
    insert into customers (name, phone) values ('詹怡惠', '0988114877') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-05T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933263787';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王梅蘭', '0933263787') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4690, 'paid', 'transfer', '2026-04-05T17:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活在生頭皮精華-乾敏(綠)', 3330, 1);

  select id into v_customer_id from customers where phone = '0953557278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭詠婕', '0953557278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7800, 'paid', 'transfer', '2026-04-05T17:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0902201208';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余文萱', '0902201208') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-04-06T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-06T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937502932';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭小姐', '0937502932') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-06T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-06T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-04-06T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0978163367';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳羿廷', '0978163367') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'transfer', '2026-04-07T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(及肩)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0988106810';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐芷芸', '0988106810') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-07T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-04-07T18:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'transfer', '2026-04-08T16:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0970071906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('娟', '0970071906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-04-08T16:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0926052424';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周秋燕', '0926052424') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 11620, 'paid', 'transfer', '2026-04-08T17:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '鉑金純銀洗髮露', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0988354996';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林于裔', '0988354996') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-08T17:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910688896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王奕之', '0910688896') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8100, 'paid', 'transfer', '2026-04-09T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活在生頭皮精華-乾敏(綠)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮護髮素', 2340, 1);

  select id into v_customer_id from customers where phone = '0931397668';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃紹瑜 Anita', '0931397668') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3780, 'paid', 'transfer', '2026-04-10T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2700, 1);

  select id into v_customer_id from customers where phone = '0910397216';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江柔妮', '0910397216') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-04-10T17:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-04-10T17:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1900, 'paid', 'transfer', '2026-04-10T17:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-04-10T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'transfer', '2026-04-10T20:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);

  select id into v_customer_id from customers where phone = '0972953167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許楨敏', '0972953167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6960, 'paid', 'transfer', '2026-04-11T19:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0982877852';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張智雁', '0982877852') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-04-11T19:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5460, 'paid', 'transfer', '2026-04-11T19:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0979501639';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佳容', '0979501639') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2026-04-11T19:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4880, 'paid', 'transfer', '2026-04-11T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-13T18:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929790308';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱玉嶶', '0929790308') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-04-13T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0952501632';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林晏竹', '0952501632') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-04-13T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0930277185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王立文', '0930277185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-04-13T18:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-04-18T16:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0928060846';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳欣芸', '0928060846') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-04-18T16:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0921516759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝嘉容', '0921516759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'cash', '2026-04-18T21:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0934029569';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方瀅雲', '0934029569') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8000, 'paid', 'transfer', '2026-04-18T21:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5760, 'paid', 'transfer', '2026-04-19T11:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'transfer', '2026-04-19T15:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0975116166';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林貞岑', '0975116166') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3840, 'paid', 'transfer', '2026-04-19T20:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988367591';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Ruwen', '0988367591') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-04-19T20:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937040832';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭又慈', '0937040832') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'cash', '2026-04-19T20:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0937494834';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Judy 黃敬華', '0937494834') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-04-20T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-20T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0963125455';
  if v_customer_id is null then
    insert into customers (name, phone) values ('董從懿', '0963125455') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10700, 'paid', 'transfer', '2026-04-20T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮梳', 900, 1);

  select id into v_customer_id from customers where phone = '0933098614';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉彥君', '0933098614') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-04-20T20:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-04-21T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0988268722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈佩臻', '0988268722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3040, 'paid', 'cash', '2026-04-21T19:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2080, 1);

  select id into v_customer_id from customers where phone = '0989626409';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯筠', '0989626409') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-04-21T20:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0987952059';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sabrina', '0987952059') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-04-21T20:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0936056500';
  if v_customer_id is null then
    insert into customers (name, phone) values ('莊絜晰', '0936056500') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-21T20:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7620, 'paid', 'transfer', '2026-04-21T20:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及腰)', 3360, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5760, 'paid', 'transfer', '2026-04-24T18:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 6500, 'paid', 'cash', '2026-04-24T18:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 7800, 'paid', 'cash', '2026-04-24T18:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮梳', 900, 1);

  select id into v_customer_id from customers where phone = '0937896596';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉君薇', '0937896596') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'cash', '2026-04-24T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 2);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-04-24T20:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-04-25T13:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2026-04-25T13:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-04-26T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-04-26T19:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0987827257';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃盈禎', '0987827257') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-04-26T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0960071680';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李若唐', '0960071680') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-04-26T19:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0903520773';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王詩瑜', '0903520773') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-04-26T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0925197885';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉叡芩', '0925197885') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8520, 'paid', 'transfer', '2026-04-27T18:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0938825609';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪夢霜', '0938825609') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2810, 'paid', 'transfer', '2026-04-27T18:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1610, 1);

  select id into v_customer_id from customers where phone = '0975928939';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭念媛', '0975928939') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'transfer', '2026-04-28T19:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919429039';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭薇欣', '0919429039') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5580, 'paid', 'cash', '2026-04-28T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-28T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0903382264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾怡臻', '0903382264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5500, 'paid', 'transfer', '2026-04-28T19:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);

  select id into v_customer_id from customers where phone = '0921319861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張純禕', '0921319861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-04-28T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928972081';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃詩晴', '0928972081') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2026-04-28T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0972957509';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡宜蓁', '0972957509') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'transfer', '2026-04-28T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1700, 'paid', 'transfer', '2026-05-01T18:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 1000, 1);

  select id into v_customer_id from customers where phone = '0989479521';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周瑋萱', '0989479521') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10280, 'paid', 'cash', '2026-05-01T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-05-01T18:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0928893358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉穎如', '0928893358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'transfer', '2026-05-01T18:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0952617112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉以婕', '0952617112') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8900, 'paid', 'transfer', '2026-05-02T17:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0916952365';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳雅旭', '0916952365') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-05-02T19:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-05-03T17:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-03T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-03T19:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0987851119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('龐宇文', '0987851119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8100, 'paid', 'transfer', '2026-05-03T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0973240827';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子妍', '0973240827') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3000, 'paid', 'transfer', '2026-05-03T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0919064145';
  if v_customer_id is null then
    insert into customers (name, phone) values ('翁碧菱', '0919064145') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7200, 'paid', 'cash', '2026-05-03T19:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-05-03T19:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0905933583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳語芯', '0905933583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'cash', '2026-05-03T19:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-03T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-05T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917241515';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0917241515') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-05T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0938873027';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉欣怡', '0938873027') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-05T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-05T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2400, 'paid', 'cash', '2026-05-05T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0972155749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李金穎', '0972155749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-05-06T18:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);

  select id into v_customer_id from customers where phone = '0980988240';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林沂臻', '0980988240') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-06T21:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937071193';
  if v_customer_id is null then
    insert into customers (name, phone) values ('孟韋均', '0937071193') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10280, 'paid', 'transfer', '2026-05-06T21:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 980, 1);

  select id into v_customer_id from customers where phone = '0916337403';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾明瑄', '0916337403') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'cash', '2026-05-06T21:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0960290528';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李曉蘭', '0960290528') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-05-07T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0989348320';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范欣瑜', '0989348320') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5860, 'paid', 'transfer', '2026-05-07T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'transfer', '2026-05-07T18:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0912750755';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳俞帆', '0912750755') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-05-07T18:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972521928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱貞禎', '0972521928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-05-07T18:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2026-05-09T16:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0926632756';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊允禾', '0926632756') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-05-09T20:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0983238126';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳恩宇', '0983238126') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-05-09T20:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7110, 'paid', 'transfer', '2026-05-09T20:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1610, 1);

  select id into v_customer_id from customers where phone = '0921222451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃淳靖', '0921222451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6660, 'paid', 'transfer', '2026-05-09T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然力長效修護髮膜', 2160, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0937052080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('梁瑋涵', '0937052080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2026-05-10T18:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0937402735';
  if v_customer_id is null then
    insert into customers (name, phone) values ('傅喬', '0937402735') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'cash', '2026-05-10T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2026-05-10T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-10T18:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928269538';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳信彣', '0928269538') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7610, 'paid', 'cash', '2026-05-10T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 1250, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0976001922';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉騏蒂', '0976001922') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'cash', '2026-05-10T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-05-11T16:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-05-11T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0988292728';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭智旻', '0988292728') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-05-11T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2026-05-11T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0912929435';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾尹宣', '0912929435') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 11330, 'paid', 'transfer', '2026-05-11T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0905133030';
  if v_customer_id is null then
    insert into customers (name, phone) values ('碧翎', '0905133030') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-05-12T18:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4000, 'paid', 'transfer', '2026-05-12T18:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0928553240';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江欣樺', '0928553240') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-05-12T18:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2026-05-12T18:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0975207970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Peng Shihting', '0975207970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-13T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4500, 'paid', 'transfer', '2026-05-13T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0920116657';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩凌', '0920116657') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-05-13T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-13T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'cash', '2026-05-13T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);

  select id into v_customer_id from customers where phone = '0939606226';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃琳萱', '0939606226') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4700, 'paid', 'transfer', '2026-05-13T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0987851119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('龐宇文', '0987851119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'cash', '2026-05-13T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮梳', 900, 1);

  select id into v_customer_id from customers where phone = '0985854774';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡佩芸', '0985854774') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'transfer', '2026-05-15T18:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0952250305';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳詠莉', '0952250305') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-05-15T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0937112170';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余孟娟', '0937112170') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-05-15T18:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2026-05-16T11:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0976396261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪銘陽', '0976396261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3640, 'paid', 'transfer', '2026-05-16T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-16T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958871098';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳麗年', '0958871098') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-16T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0914101982';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉芸彤', '0914101982') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-05-16T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0920128685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉嘉鳳', '0920128685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'cash', '2026-05-18T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0976881660';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黎羽容', '0976881660') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-18T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-05-18T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0930373596';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周佳真', '0930373596') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-18T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933019425';
  if v_customer_id is null then
    insert into customers (name, phone) values ('連茵', '0933019425') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-18T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-05-19T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988813025';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡佳威', '0988813025') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-05-19T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958231928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林佳儀', '0958231928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-19T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-05-19T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3300, 'paid', 'transfer', '2026-05-19T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2500, 'paid', 'transfer', '2026-05-19T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 2500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 3150, 'paid', 'transfer', '2026-05-21T16:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3150, 1);

  select id into v_customer_id from customers where phone = '0986872005';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琪雅', '0986872005') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-05-21T16:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-21T16:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-21T16:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1000, 'paid', 'cash', '2026-05-21T16:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0937176884';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭瑞文', '0937176884') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6090, 'paid', 'cash', '2026-05-21T17:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮梳', 900, 3);

  select id into v_customer_id from customers where phone = '0989001412';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宥均', '0989001412') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2320, 'paid', 'transfer', '2026-05-21T19:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2026-05-22T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-22T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0908129367';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amber', '0908129367') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-05-22T19:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-05-22T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4690, 'paid', 'transfer', '2026-05-23T13:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  select id into v_customer_id from customers where phone = '0921797190';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖姿婷', '0921797190') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'transfer', '2026-05-23T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0901139138';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姵亘', '0901139138') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6360, 'paid', 'transfer', '2026-05-23T20:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0900509652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('喻靖洧', '0900509652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-24T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988032481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭如君', '0988032481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-05-24T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0921033528';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張雅晴', '0921033528') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2026-05-24T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0930140800';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡良芸', '0930140800') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-05-24T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-24T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0912271251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李曉娟', '0912271251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4340, 'paid', 'transfer', '2026-05-24T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'transfer', '2026-05-25T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-05-29T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1260, 'paid', 'transfer', '2026-05-29T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0905075562';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴毓玟', '0905075562') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9000, 'paid', 'cash', '2026-05-29T20:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然捲夾順(加購,價格依現場判斷)', 1500, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1360, 'paid', 'transfer', '2026-05-30T16:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-05-30T16:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988670112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭婕岑', '0988670112') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-05-30T16:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-30T20:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0921082253';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雅淇', '0921082253') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'transfer', '2026-05-31T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-05-31T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'cash', '2026-05-31T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0972343929';
  if v_customer_id is null then
    insert into customers (name, phone) values ('顏汝瑩', '0972343929') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-05-31T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988516806';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周彥廷', '0988516806') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-05-31T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4970, 'paid', 'cash', '2026-05-31T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '白光氣墊慕斯2', 630, 1);

  select id into v_customer_id from customers where phone = '0900509652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('喻靖洧', '0900509652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2100, 'paid', 'cash', '2026-05-31T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0933949042';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳思穎', '0933949042') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'cash', '2026-06-02T21:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0928553240';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江欣樺', '0928553240') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 11960, 'paid', 'cash', '2026-06-02T21:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然力長效修護髮膜', 2160, 1);

  select id into v_customer_id from customers where phone = '0988390261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳昱安', '0988390261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7200, 'paid', 'transfer', '2026-06-02T21:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0989427278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃鈺雅', '0989427278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-03T10:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0953173218';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪', '0953173218') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-03T10:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937071193';
  if v_customer_id is null then
    insert into customers (name, phone) values ('孟韋均', '0937071193') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3000, 'paid', 'cash', '2026-06-03T10:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0988452195';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Olive', '0988452195') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2026-06-03T10:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0963781330';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美惠', '0963781330') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-04T18:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0911069147';
  if v_customer_id is null then
    insert into customers (name, phone) values ('怡晴', '0911069147') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-04T18:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-06-04T18:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930964133';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳玉君', '0930964133') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-05T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3760, 'paid', 'transfer', '2026-06-05T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-05T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0916876506';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐惠君', '0916876506') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4720, 'paid', 'transfer', '2026-06-05T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4500, 'paid', 'cash', '2026-06-05T19:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-06T21:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0910121055';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美如', '0910121055') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'cash', '2026-06-06T21:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8080, 'paid', 'cash', '2026-06-06T21:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919377316';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳宛蓉', '0919377316') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-06-06T21:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0937040832';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭又慈', '0937040832') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'cash', '2026-06-07T18:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2026-06-07T18:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988572200';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李惠莉', '0988572200') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-07T18:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-06-07T18:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2026-06-07T18:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0918572193';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王羚軒', '0918572193') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 30050, 'paid', 'cash', '2026-06-11T20:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然力長效修護髮膜', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1790, 1);

  select id into v_customer_id from customers where phone = '0976001922';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉騏蒂', '0976001922') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-06-13T18:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0973685109';
  if v_customer_id is null then
    insert into customers (name, phone) values ('薛宇彤', '0973685109') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-13T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-06-13T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0920701921';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱秀津', '0920701921') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-13T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-06-13T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'cash', '2026-06-14T20:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0977719040';
  if v_customer_id is null then
    insert into customers (name, phone) values ('祈', '0977719040') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6200, 'paid', 'cash', '2026-06-14T20:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2500, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-06-14T20:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2700, 'paid', 'transfer', '2026-06-14T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0928995183';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王詞雅', '0928995183') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5860, 'paid', 'transfer', '2026-06-14T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-14T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-06-15T18:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0921295852';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妍融', '0921295852') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-06-15T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0921516759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝嘉容', '0921516759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7330, 'paid', 'cash', '2026-06-15T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  select id into v_customer_id from customers where phone = '0935576207';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曹雅晴', '0935576207') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7880, 'paid', 'transfer', '2026-06-15T18:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 980, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0912415154';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡佩穎', '0912415154') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-06-15T18:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4080, 'paid', 'transfer', '2026-06-16T13:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0958972965';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Yun', '0958972965') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-06-16T13:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0939927312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳芳宜', '0939927312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3500, 'paid', 'transfer', '2026-06-16T13:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4500, 'paid', 'cash', '2026-06-16T13:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0975382650';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昱辰', '0975382650') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-16T13:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0911003274';
  if v_customer_id is null then
    insert into customers (name, phone) values ('俞', '0911003274') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'cash', '2026-06-17T17:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0937964399';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李柏儀', '0937964399') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-17T17:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2026-06-17T17:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0961229003';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭雅云', '0961229003') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9700, 'paid', 'transfer', '2026-06-17T17:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2026-06-19T12:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0975015350';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李怡萱', '0975015350') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-19T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0939802840';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0939802840') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-06-19T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0909664508';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡馨葶', '0909664508') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-19T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910344360';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭貴甄', '0910344360') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-06-19T18:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0978987902';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊佩慈', '0978987902') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8500, 'paid', 'transfer', '2026-06-19T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 3500, 1);

  select id into v_customer_id from customers where phone = '0958607298';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張皓衍', '0958607298') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'transfer', '2026-06-20T11:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-06-20T13:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0912667276';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳巧瑩', '0912667276') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-20T17:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958607298';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張皓衍', '0958607298') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'transfer', '2026-06-20T17:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0958115499';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子晴', '0958115499') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-06-20T17:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0972225159';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林慈珉', '0972225159') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-20T17:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-21T17:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-21T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-21T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0953026197';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張美惠', '0953026197') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-21T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0976001922';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉騏蒂', '0976001922') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3400, 'paid', 'transfer', '2026-06-21T17:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3780, 'paid', 'cash', '2026-06-22T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0979120610';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳思靜', '0979120610') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'transfer', '2026-06-22T17:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 3);

  select id into v_customer_id from customers where phone = '0937556533';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭', '0937556533') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-06-22T17:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0975928939';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭念媛', '0975928939') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2026-06-22T18:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6260, 'paid', 'transfer', '2026-06-23T20:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(短髮)', 1760, 1);

  select id into v_customer_id from customers where phone = '0975111264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Max', '0975111264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-06-23T20:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0977095039';
  if v_customer_id is null then
    insert into customers (name, phone) values ('C', '0977095039') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1480, 'paid', 'cash', '2026-06-23T21:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 1480, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5190, 'paid', 'transfer', '2026-06-23T21:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0987889685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖玉涵', '0987889685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2026-06-23T22:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2026-06-24T20:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0911590202';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張怡婷', '0911590202') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-24T20:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7700, 'paid', 'transfer', '2026-06-24T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0933973450';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳台莉', '0933973450') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'transfer', '2026-06-24T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0936228937';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳偉謙', '0936228937') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-24T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'cash', '2026-06-24T20:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-26T14:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0928799066';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳岱蓉', '0928799066') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2026-06-26T16:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4110, 'paid', 'transfer', '2026-06-27T14:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 3150, 1);

  select id into v_customer_id from customers where phone = '0982877852';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張智雁', '0982877852') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3100, 'paid', 'transfer', '2026-06-27T14:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0975895853';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐小敏', '0975895853') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-06-27T16:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0919091153';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈芝誼', '0919091153') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-06-27T16:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-06-28T20:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0928252722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃美縮', '0928252722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-06-28T20:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0931200940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷喻', '0931200940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-06-28T20:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2026-06-28T20:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1000, 'paid', 'cash', '2026-06-28T20:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-06-29T12:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

end $do$;

-- 執行完請對照下面這行查詢結果（應該是 訂單數 = 289、現場實收合計 = 938920）
select count(*) as 訂單數, coalesce(sum(total), 0) as 現場實收合計 from orders where created_at >= '2026-04-01T00:00:00+08:00' and created_at < '2026-07-01T00:00:00+08:00' and (payment_method is not null or total = 0);
