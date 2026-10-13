-- 匯入 2025-10 ~ 2025-12 訂單列表（來自神美匯出的每月訂單列表）
-- orders.total 只算「現場付款」的現金/匯款實收，商品券折抵的部分不重複算營業額（跟 9 月匯入的規則一致）；
-- 每一筆訂單照樣建立（total 可能是 0），客人的消費次數／最近消費才會正確。order_items.price 存的是「單價」。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if exists (select 1 from orders where created_at >= '2025-10-01T00:00:00+08:00' and created_at < '2026-01-01T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '這段期間的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-05T10:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9050, 'paid', 'transfer', '2025-10-05T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '白光氣墊慕斯2', 630, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'transfer', '2025-10-05T19:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0930131185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐念琪', '0930131185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-05T19:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0936547871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧芳郡', '0936547871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-05T19:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2025-10-05T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2025-10-05T20:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0972217400';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳芊萱', '0972217400') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7380, 'paid', 'transfer', '2025-10-06T21:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0937402735';
  if v_customer_id is null then
    insert into customers (name, phone) values ('傅喬', '0937402735') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1260, 'paid', 'cash', '2025-10-06T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0916803856';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林鴻英', '0916803856') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-10-06T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910397216';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江柔妮', '0910397216') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-10-06T21:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'cash', '2025-10-06T21:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'transfer', '2025-10-06T21:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-10-07T18:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0912233152';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宣妤', '0912233152') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'cash', '2025-10-07T18:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0972155749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李金穎', '0972155749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-10-07T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);

  select id into v_customer_id from customers where phone = '0912929435';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾尹宣', '0912929435') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'cash', '2025-10-07T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'transfer', '2025-10-08T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-10-08T19:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0937071193';
  if v_customer_id is null then
    insert into customers (name, phone) values ('孟韋均', '0937071193') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4720, 'paid', 'transfer', '2025-10-08T19:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0919945154';
  if v_customer_id is null then
    insert into customers (name, phone) values ('官欣瑤', '0919945154') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7000, 'paid', 'cash', '2025-10-08T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0936953698';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林宛瑩', '0936953698') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-08T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0911892048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余蘋', '0911892048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-08T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917210386';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林欣郁', '0917210386') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1230, 'paid', 'cash', '2025-10-08T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 270, 1);

  select id into v_customer_id from customers where phone = '0936536912';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑞妤', '0936536912') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1160, 'paid', 'cash', '2025-10-09T19:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0975015350';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李怡萱', '0975015350') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-10-09T19:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2130, 'paid', 'cash', '2025-10-09T19:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3080, 'paid', 'transfer', '2025-10-09T19:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-09T19:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988516806';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周彥廷', '0988516806') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-10-10T21:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0912970550';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賴奕君', '0912970550') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 12200, 'paid', 'transfer', '2025-10-10T21:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0921869782';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Linda', '0921869782') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-10-10T21:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6160, 'paid', 'transfer', '2025-10-10T21:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0928139615';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李家妤', '0928139615') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'cash', '2025-10-10T21:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0912557409';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Stacy', '0912557409') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-10-11T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933019425';
  if v_customer_id is null then
    insert into customers (name, phone) values ('連茵', '0933019425') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-11T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2025-10-11T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0934327003';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬瑜', '0934327003') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-10-11T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0919377316';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳宛蓉', '0919377316') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4580, 'paid', 'transfer', '2025-10-11T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-10-12T20:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0928521791';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡冠芸', '0928521791') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2760, 'paid', 'transfer', '2025-10-12T20:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0963626013';
  if v_customer_id is null then
    insert into customers (name, phone) values ('韓海因', '0963626013') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-12T20:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0936908708';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王孟訢', '0936908708') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-10-12T20:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988519676';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周雨諍', '0988519676') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2025-10-13T17:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0988032481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭如君', '0988032481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-10-13T17:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2020, 'paid', 'cash', '2025-10-14T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0970071906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('娟', '0970071906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-14T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928076862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Grace', '0928076862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-14T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3060, 'paid', 'cash', '2025-10-15T21:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱洗髮精＋精華液', 2100, 1);

  select id into v_customer_id from customers where phone = '0963055205';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪珮華', '0963055205') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5360, 'paid', 'transfer', '2025-10-15T21:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9290, 'paid', 'transfer', '2025-10-15T21:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '白光氣墊慕斯2', 630, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然力長效修護髮膜', 2160, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0988100354';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭宇文', '0988100354') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-15T21:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'transfer', '2025-10-15T21:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2025-10-15T21:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4230, 'paid', 'cash', '2025-10-15T21:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 7160, 'paid', 'cash', '2025-10-16T19:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0916269948';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Karen', '0916269948') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2025-10-16T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0972119253';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游翌婷', '0972119253') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-17T16:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7380, 'paid', 'transfer', '2025-10-17T16:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0972225159';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林慈珉', '0972225159') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-10-20T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0965078083';
  if v_customer_id is null then
    insert into customers (name, phone) values ('遲蘅', '0965078083') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-10-20T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2025-10-20T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0912233152';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宣妤', '0912233152') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1460, 'paid', 'cash', '2025-10-21T17:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-10-21T21:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0975382650';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昱辰', '0975382650') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-10-21T21:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0939806303';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Vivian Hsieh', '0939806303') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-10-22T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0905133030';
  if v_customer_id is null then
    insert into customers (name, phone) values ('碧翎', '0905133030') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-22T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0926052424';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周秋燕', '0926052424') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8900, 'paid', 'transfer', '2025-10-22T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4340, 'paid', 'transfer', '2025-10-23T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-10-23T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0955691228';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇豈俐carrie', '0955691228') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-23T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0979501639';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佳容', '0979501639') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3560, 'paid', 'transfer', '2025-10-23T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2025-10-24T18:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0978757907';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳昭廷', '0978757907') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-10-24T18:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0937650524';
  if v_customer_id is null then
    insert into customers (name, phone) values ('潘小姐', '0937650524') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-10-24T18:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3590, 'paid', 'cash', '2025-10-24T18:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'cash', '2025-10-24T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);

  select id into v_customer_id from customers where phone = '0988102112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊晴雯', '0988102112') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-10-24T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928566162';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏汶芳', '0928566162') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6420, 'paid', 'transfer', '2025-10-25T22:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-10-25T22:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2025-10-25T22:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9740, 'paid', 'transfer', '2025-10-25T22:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929790308';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱玉嶶', '0929790308') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2025-10-25T22:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-10-26T17:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0925197885';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉叡芩', '0925197885') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-10-26T20:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0936056500';
  if v_customer_id is null then
    insert into customers (name, phone) values ('莊絜晰', '0936056500') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5700, 'paid', 'transfer', '2025-10-27T13:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-10-28T17:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3160, 'paid', 'transfer', '2025-10-28T17:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0966159918';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王怡蘋', '0966159918') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-10-29T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0981319768';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王孟文', '0981319768') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9000, 'paid', 'transfer', '2025-10-29T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0938818108';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝旻伶', '0938818108') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5000, 'paid', 'cash', '2025-10-29T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及腰）', 5000, 1);

  select id into v_customer_id from customers where phone = '0930140800';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡良芸', '0930140800') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-11-01T20:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0928893199';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳承穎', '0928893199') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5660, 'paid', 'transfer', '2025-11-01T20:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-11-01T20:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7140, 'paid', 'transfer', '2025-11-02T16:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)排毒修飾白髮三合一', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2025-11-02T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0989427278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃鈺雅', '0989427278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-02T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919211445';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑜臻', '0919211445') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9140, 'paid', 'transfer', '2025-11-02T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0989479521';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周瑋萱', '0989479521') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5360, 'paid', 'cash', '2025-11-03T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0936153007';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭欣怡', '0936153007') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5520, 'paid', 'transfer', '2025-11-03T19:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '日常抗老精華', 1220, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-03T19:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-04T18:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0955715783';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張', '0955715783') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-11-04T18:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2025-11-04T18:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4100, 'paid', 'transfer', '2025-11-04T18:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0936335362';
  if v_customer_id is null then
    insert into customers (name, phone) values ('としえ', '0936335362') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-11-06T13:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0912233152';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宣妤', '0912233152') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'cash', '2025-11-06T16:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3400, 'paid', 'cash', '2025-11-06T16:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-11-06T18:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937964399';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李柏儀', '0937964399') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-11-07T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3730, 'paid', 'transfer', '2025-11-07T20:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活在生頭皮精華-乾敏(綠)', 3330, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-11-07T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988126746';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝貽如', '0988126746') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2025-11-07T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-11-07T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0937033084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('于學慧', '0937033084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2025-11-07T20:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0986456581';
  if v_customer_id is null then
    insert into customers (name, phone) values ('翁瑋憶', '0986456581') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2025-11-08T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0912012940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳逸芸', '0912012940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-08T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988391471';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張嘉芬', '0988391471') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-11-08T19:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0911901723';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉俐麟', '0911901723') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-09T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0984196729';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古燕婷', '0984196729') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5000, 'paid', 'cash', '2025-11-09T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);

  select id into v_customer_id from customers where phone = '0917210386';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林欣郁', '0917210386') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2840, 'paid', 'transfer', '2025-11-09T19:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0970310628';
  if v_customer_id is null then
    insert into customers (name, phone) values ('采潔', '0970310628') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7120, 'paid', 'transfer', '2025-11-09T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-09T19:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937520515';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許宜文', '0937520515') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-11-09T19:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2025-11-09T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 600, 1);

  select id into v_customer_id from customers where phone = '0911566372';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭郁涵', '0911566372') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-11-10T21:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0916809635';
  if v_customer_id is null then
    insert into customers (name, phone) values ('袁君維', '0916809635') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-10T21:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0921891432';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈秉柔', '0921891432') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5500, 'paid', 'cash', '2025-11-10T21:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 5500, 1);

  select id into v_customer_id from customers where phone = '0928944528';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方敏瑄', '0928944528') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-11-10T21:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'cash', '2025-11-10T21:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919787688';
  if v_customer_id is null then
    insert into customers (name, phone) values ('詹于箴', '0919787688') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2025-11-10T21:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2025-11-11T17:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-11-11T17:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0952250305';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳詠莉', '0952250305') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4480, 'paid', 'transfer', '2025-11-11T17:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮淨化(含水飛梭)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0921927648';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊欣燁', '0921927648') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-11T17:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0977095039';
  if v_customer_id is null then
    insert into customers (name, phone) values ('C', '0977095039') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1140, 'paid', 'transfer', '2025-11-11T17:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1140, 1);

  select id into v_customer_id from customers where phone = '0975111264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Max', '0975111264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-11-19T16:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0927992078';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳冠臻', '0927992078') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6760, 'paid', 'transfer', '2025-11-19T16:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-11-19T18:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2025-11-20T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0921222451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃淳靖', '0921222451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2025-11-20T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917241515';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0917241515') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-11-20T20:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0937112170';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余孟娟', '0937112170') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2025-11-20T20:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0910688896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王奕之', '0910688896') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 49240, 'paid', 'transfer', '2025-11-20T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程', 30000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-乾屑敏(紅)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1610, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1970, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  select id into v_customer_id from customers where phone = '0970310628';
  if v_customer_id is null then
    insert into customers (name, phone) values ('采潔', '0970310628') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1610, 'paid', 'cash', '2025-11-20T20:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1610, 1);

  select id into v_customer_id from customers where phone = '0987352882';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳佩樺', '0987352882') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-21T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937556533';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭', '0937556533') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'transfer', '2025-11-21T20:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1740, 'paid', 'cash', '2025-11-21T20:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3780, 'paid', 'transfer', '2025-11-21T20:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2025-11-22T11:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0970715807';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅梓齊', '0970715807') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8300, 'paid', 'transfer', '2025-11-22T21:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0936720600';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐嫚謙', '0936720600') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-22T21:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958871098';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳麗年', '0958871098') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1660, 'paid', 'transfer', '2025-11-22T21:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0966566128';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李玥陵', '0966566128') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-11-22T21:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988353325';
  if v_customer_id is null then
    insert into customers (name, phone) values ('高凡渝', '0988353325') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1360, 'paid', 'transfer', '2025-11-22T21:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-23T20:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919085315';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Ngiok Phín', '0919085315') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 14300, 'paid', 'transfer', '2025-11-23T20:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '挑染(及肩)', 3800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2025-11-23T20:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0975653693';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡欣如', '0975653693') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-23T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988933481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯語', '0988933481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-11-23T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-24T19:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0976180976';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王芙紀', '0976180976') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3020, 'paid', 'transfer', '2025-11-24T19:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0963125455';
  if v_customer_id is null then
    insert into customers (name, phone) values ('董從懿', '0963125455') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9930, 'paid', 'transfer', '2025-11-24T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0988044086';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳艾婕', '0988044086') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-11-24T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0920116657';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩凌', '0920116657') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'cash', '2025-11-24T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-11-24T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-24T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2025-11-25T20:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-25T20:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0985556652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳曉思', '0985556652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-25T20:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0902330160';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許茹貽', '0902330160') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-11-25T20:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3160, 'paid', 'transfer', '2025-11-25T20:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-11-26T10:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4560, 'paid', 'transfer', '2025-11-26T10:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 4560, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-11-26T16:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-11-26T16:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-11-26T16:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0926573680';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡宛真', '0926573680') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-11-26T16:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0936547871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧芳郡', '0936547871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-11-29T20:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0911597329';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡瑄', '0911597329') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 13290, 'paid', 'transfer', '2025-11-29T20:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁護髮素', 1140, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1360, 'paid', 'transfer', '2025-11-29T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0958603566';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游媛婷', '0958603566') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2760, 'paid', 'transfer', '2025-11-29T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4060, 'paid', 'transfer', '2025-11-30T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0936682621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏婕安', '0936682621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-11-30T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2025-11-30T19:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0958736900';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃昱衡', '0958736900') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5500, 'paid', 'transfer', '2025-11-30T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0921869782';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Linda', '0921869782') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-11-30T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-11-30T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 6320, 'paid', 'cash', '2025-12-01T22:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0953173218';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪', '0953173218') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-12-01T22:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0905508672';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉芝佑', '0905508672') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2025-12-01T22:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0972521928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱貞禎', '0972521928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-12-01T22:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3430, 'paid', 'transfer', '2025-12-01T22:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'FOAM白光氣墊慕斯[4]180g', 630, 1);

  select id into v_customer_id from customers where phone = '0912300938';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳昭芸', '0912300938') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8700, 'paid', 'transfer', '2025-12-02T18:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草二合一', 1800, 1);

  select id into v_customer_id from customers where phone = '0912399560';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佳蓉8126', '0912399560') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-02T18:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937117489';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃宇涵', '0937117489') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-12-02T18:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2025-12-02T18:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'cash', '2025-12-02T18:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0975382650';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昱辰', '0975382650') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2640, 'paid', 'transfer', '2025-12-02T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2240, 1);

  select id into v_customer_id from customers where phone = '0901139193';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉馨琪', '0901139193') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7800, 'paid', 'cash', '2025-12-03T18:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-12-03T18:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1700, 'paid', 'transfer', '2025-12-05T20:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 1700, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-12-05T20:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988292728';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭智旻', '0988292728') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2025-12-05T20:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0919787688';
  if v_customer_id is null then
    insert into customers (name, phone) values ('詹于箴', '0919787688') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2025-12-05T20:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0982762575';
  if v_customer_id is null then
    insert into customers (name, phone) values ('詹于瑩', '0982762575') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9000, 'paid', 'cash', '2025-12-06T16:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-12-06T16:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2060, 'paid', 'transfer', '2025-12-06T18:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);

  select id into v_customer_id from customers where phone = '0931278005';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳', '0931278005') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2025-12-07T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2730, 'paid', 'transfer', '2025-12-07T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);

  select id into v_customer_id from customers where phone = '0987827257';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃盈禎', '0987827257') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-07T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-12-07T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'cash', '2025-12-07T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-07T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0983899666';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃宇潔', '0983899666') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 160, 'paid', 'cash', '2025-12-07T19:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 160, 1);

  select id into v_customer_id from customers where phone = '0930571516';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古庭榕', '0930571516') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-12-08T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0921082253';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雅淇', '0921082253') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3920, 'paid', 'transfer', '2025-12-08T18:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0939606226';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃琳萱', '0939606226') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2025-12-08T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0908325157';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈昕潔', '0908325157') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'transfer', '2025-12-08T18:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0936050947';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾雨儂', '0936050947') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9810, 'paid', 'transfer', '2025-12-09T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '挑染(及肩)', 3420, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '抗脱精華液', 1590, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-12-09T19:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988106810';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐芷芸', '0988106810') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-12-09T19:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-09T19:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919564797';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Niki', '0919564797') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 15200, 'paid', 'transfer', '2025-12-10T20:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 4);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '挑染(及肩)', 3800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1800, 1);

  select id into v_customer_id from customers where phone = '0919429039';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭薇欣', '0919429039') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8500, 'paid', 'cash', '2025-12-10T22:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0960996336';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佩琪', '0960996336') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-12-11T11:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0936335362';
  if v_customer_id is null then
    insert into customers (name, phone) values ('としえ', '0936335362') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-12-11T17:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);

  select id into v_customer_id from customers where phone = '0958960102';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林詩婷', '0958960102') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2620, 'paid', 'cash', '2025-12-11T17:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0937151608';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許如函', '0937151608') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2025-12-11T17:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5400, 'paid', 'transfer', '2025-12-12T18:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0955827839';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐維', '0955827839') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-12T23:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0905051193';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃郁雯', '0905051193') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-13T23:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0910874590';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Rita', '0910874590') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9400, 'paid', 'transfer', '2025-12-13T23:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0978430084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林彥妤', '0978430084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10400, 'paid', 'transfer', '2025-12-13T23:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2025-12-14T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 960, 'paid', 'cash', '2025-12-14T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0979120610';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳思靜', '0979120610') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4320, 'paid', 'transfer', '2025-12-14T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0916348063';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃佳汝', '0916348063') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5460, 'paid', 'transfer', '2025-12-14T19:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0937033084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('于學慧', '0937033084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2025-12-15T20:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1400, 1);

  select id into v_customer_id from customers where phone = '0920057450';
  if v_customer_id is null then
    insert into customers (name, phone) values ('任以心', '0920057450') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'transfer', '2025-12-15T20:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-12-15T20:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910517881';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張小倫', '0910517881') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6000, 'paid', 'cash', '2025-12-15T20:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0937176884';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭瑞文', '0937176884') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8860, 'paid', 'cash', '2025-12-15T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-乾屑敏(紅)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  select id into v_customer_id from customers where phone = '0982876935';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李孟容', '0982876935') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2940, 'paid', 'cash', '2025-12-16T20:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '毛流矯正', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-12-16T20:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0912750755';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳俞帆', '0912750755') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'cash', '2025-12-16T20:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4080, 'paid', 'transfer', '2025-12-16T20:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'cash', '2025-12-16T20:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-17T13:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0928521791';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡冠芸', '0928521791') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8100, 'paid', 'transfer', '2025-12-17T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0988813025';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡佳威', '0988813025') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-17T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-12-17T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-12-17T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'transfer', '2025-12-19T15:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6860, 'paid', 'transfer', '2025-12-19T17:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);

  select id into v_customer_id from customers where phone = '0921869782';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Linda', '0921869782') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2025-12-19T18:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0933539826';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賈斯嘉', '0933539826') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-12-19T18:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7620, 'paid', 'transfer', '2025-12-20T17:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2025-12-20T17:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3330, 'paid', 'transfer', '2025-12-20T17:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);

  select id into v_customer_id from customers where phone = '0925209871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳真如', '0925209871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5000, 'paid', 'transfer', '2025-12-20T17:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2025-12-20T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4600, 'paid', 'transfer', '2025-12-21T22:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(肩上)', 3000, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8880, 'paid', 'transfer', '2025-12-21T22:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分漂', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);

  select id into v_customer_id from customers where phone = '0937176884';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭瑞文', '0937176884') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5900, 'paid', 'cash', '2025-12-21T22:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草三合一', 2300, 1);

  select id into v_customer_id from customers where phone = '0970420866';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐千雅', '0970420866') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9780, 'paid', 'transfer', '2025-12-21T22:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '挑染(及肩)', 3040, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-12-21T22:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2025-12-22T23:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2025-12-22T23:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-12-22T23:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0913359910';
  if v_customer_id is null then
    insert into customers (name, phone) values ('矯伊玲', '0913359910') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-22T23:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0938873027';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉欣怡', '0938873027') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2025-12-22T23:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0975075855';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daphnë', '0975075855') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-22T23:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0987851119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('龐宇文', '0987851119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-12-22T23:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910647957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Mia', '0910647957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2025-12-24T21:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-12-24T21:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0920841779';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳禹妏', '0920841779') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'cash', '2025-12-24T21:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0953327155';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jen Yang', '0953327155') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8600, 'paid', 'cash', '2025-12-24T21:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '挑染(及肩)', 3800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2025-12-24T21:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0937569617';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱靖芸', '0937569617') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'transfer', '2025-12-25T18:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0978658113';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖珮珊', '0978658113') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'cash', '2025-12-25T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0905566045';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉凱萍', '0905566045') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2025-12-25T19:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0937569617';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱靖芸', '0937569617') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9640, 'paid', 'transfer', '2025-12-25T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3160, 'paid', 'transfer', '2025-12-25T19:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);

  select id into v_customer_id from customers where phone = '0987699585';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃韻珊', '0987699585') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1500, 'paid', 'cash', '2025-12-26T17:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0937896596';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉君薇', '0937896596') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'cash', '2025-12-26T17:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 2);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-12-26T17:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2025-12-26T18:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 6260, 'paid', 'cash', '2025-12-26T18:29:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非遠紅外線按摩梳', 1610, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無非打結掰掰梳', 1520, 2);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-27T19:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'cash', '2025-12-27T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975111264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Max', '0975111264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2025-12-27T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0931200940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳婷喻', '0931200940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2025-12-27T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0937650524';
  if v_customer_id is null then
    insert into customers (name, phone) values ('潘小姐', '0937650524') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2025-12-27T19:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0966297741';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林', '0966297741') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2025-12-27T19:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2025-12-28T17:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4000, 'paid', 'transfer', '2025-12-28T17:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0972155749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李金穎', '0972155749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2025-12-28T18:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0911053645';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張佩思', '0911053645') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5330, 'paid', 'cash', '2025-12-31T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '滋養抗躁洗髮露', 1190, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2520, 'paid', 'transfer', '2025-12-31T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1920, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0909217927';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張凱琪', '0909217927') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2025-12-31T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4500, 'paid', 'cash', '2025-12-31T19:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

end $do$;

-- 執行完請對照下面這行查詢結果（應該是 訂單數 = 302、現場實收合計 = 1012710）
select count(*) as 訂單數, coalesce(sum(total), 0) as 現場實收合計 from orders where created_at >= '2025-10-01T00:00:00+08:00' and created_at < '2026-01-01T00:00:00+08:00' and (payment_method is not null or total = 0);
