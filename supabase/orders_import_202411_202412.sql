-- 匯入 2024-11 ~ 2024-12 訂單列表（來自神美匯出的每月訂單列表）
-- orders.total 只算「現場付款」的現金/匯款實收，商品券折抵的部分不重複算營業額（跟 9 月匯入的規則一致）；
-- 每一筆訂單照樣建立（total 可能是 0），客人的消費次數／最近消費才會正確。order_items.price 存的是「單價」。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if exists (select 1 from orders where created_at >= '2024-11-01T00:00:00+08:00' and created_at < '2025-01-01T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '這段期間的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0975075855';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daphnë', '0975075855') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3880, 'paid', 'transfer', '2024-11-01T18:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-11-01T18:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0988391708';
  if v_customer_id is null then
    insert into customers (name, phone) values ('小云', '0988391708') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2024-11-01T18:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0910121055';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美如', '0910121055') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-11-02T19:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0936418929';
  if v_customer_id is null then
    insert into customers (name, phone) values ('董伊庭', '0936418929') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2024-11-02T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0918780226';
  if v_customer_id is null then
    insert into customers (name, phone) values ('高函岑', '0918780226') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7120, 'paid', 'transfer', '2024-11-02T19:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0958972965';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Yun', '0958972965') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5280, 'paid', 'cash', '2024-11-03T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(肩上)', 1280, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-11-03T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0926573680';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡宛真', '0926573680') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1100, 'paid', 'transfer', '2024-11-03T19:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 900, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7000, 'paid', 'transfer', '2024-11-03T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0978757907';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳昭廷', '0978757907') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2024-11-03T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0958265458';
  if v_customer_id is null then
    insert into customers (name, phone) values ('何宜', '0958265458') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9320, 'paid', 'transfer', '2024-11-04T22:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5760, 'paid', 'transfer', '2024-11-04T22:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1760, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0928893199';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳承穎', '0928893199') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3040, 'paid', 'transfer', '2024-11-04T22:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(短髮)', 1440, 1);

  select id into v_customer_id from customers where phone = '0965022817';
  if v_customer_id is null then
    insert into customers (name, phone) values ('綠蔚', '0965022817') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2024-11-05T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 1200, 1);

  select id into v_customer_id from customers where phone = '0919339895';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾依珊', '0919339895') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2024-11-05T19:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0922395337';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sharon陳', '0922395337') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-11-05T19:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0955168125';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Lindsey', '0955168125') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2024-11-05T20:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0933477429';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡力伶', '0933477429') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2024-11-06T19:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0970071906';
  if v_customer_id is null then
    insert into customers (name, phone) values ('娟', '0970071906') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5580, 'paid', 'cash', '2024-11-06T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '22合1修護噴霧150ml', 1080, 1);

  select id into v_customer_id from customers where phone = '0936682621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏婕安', '0936682621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'cash', '2024-11-06T19:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3520, 'paid', 'cash', '2024-11-08T20:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'cash', '2024-11-08T20:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0928830645';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳秀琴', '0928830645') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-08T20:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0917241515';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李安', '0917241515') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2024-11-08T20:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4000, 1);

  select id into v_customer_id from customers where phone = '0905561231';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王怡萱', '0905561231') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-08T20:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-11T19:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0988452195';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Olive', '0988452195') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-11-11T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0975207970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Peng Shihting', '0975207970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'transfer', '2024-11-11T19:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 3600, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6100, 'paid', 'cash', '2024-11-12T22:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 3);

  select id into v_customer_id from customers where phone = '0933973450';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳台莉', '0933973450') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3060, 'paid', 'cash', '2024-11-12T22:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 1760, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0987172618';
  if v_customer_id is null then
    insert into customers (name, phone) values ('于佳馨', '0987172618') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8120, 'paid', 'transfer', '2024-11-12T22:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0919514729';
  if v_customer_id is null then
    insert into customers (name, phone) values ('田卓示', '0919514729') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-12T22:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0937112170';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余孟娟', '0937112170') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'cash', '2024-11-13T18:32:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0902330160';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許茹貽', '0902330160') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-13T18:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0973240827';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子妍', '0973240827') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3040, 'paid', 'transfer', '2024-11-13T18:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2240, 1);

  select id into v_customer_id from customers where phone = '0910560818';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳鐔湘', '0910560818') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2024-11-13T18:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0909240707';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳韋如', '0909240707') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'cash', '2024-11-13T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 2);

  select id into v_customer_id from customers where phone = '0966689790';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡昀庭', '0966689790') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2024-11-16T22:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988813025';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡佳威', '0988813025') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-11-16T22:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-11-16T22:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0936547871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧芳郡', '0936547871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2024-11-16T23:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0921509723';
  if v_customer_id is null then
    insert into customers (name, phone) values ('潘思蓉', '0921509723') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'transfer', '2024-11-17T22:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0911876723';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許雅涵', '0911876723') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5600, 'paid', 'cash', '2024-11-17T23:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(肩上)', 1600, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-11-17T23:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-17T23:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0920701921';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱秀津', '0920701921') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-11-17T23:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0903472026';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張旭珊', '0903472026') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'cash', '2024-11-17T23:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 900, 1);

  select id into v_customer_id from customers where phone = '0977719040';
  if v_customer_id is null then
    insert into customers (name, phone) values ('祈', '0977719040') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-17T23:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-11-17T23:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2024-11-17T23:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 5);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 6400, 'paid', 'cash', '2024-11-18T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0921754136';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昀蓁', '0921754136') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'cash', '2024-11-18T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0921161011';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周孟哲', '0921161011') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'cash', '2024-11-18T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0978150080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('段又元', '0978150080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'cash', '2024-11-18T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0919506866';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游雅淳', '0919506866') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2024-11-18T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0988102074';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉佩琪', '0988102074') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'transfer', '2024-11-19T19:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0970655129';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李雅娟', '0970655129') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5600, 'paid', 'transfer', '2024-11-19T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0958231928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林佳儀', '0958231928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'cash', '2024-11-19T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0911892048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余蘋', '0911892048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-11-22T22:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0937530621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('芝賢', '0937530621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8100, 'paid', 'cash', '2024-11-22T22:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0939266341';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蘇婉瑛', '0939266341') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2024-11-22T22:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0972279065';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王佳欣', '0972279065') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8280, 'paid', 'cash', '2024-11-22T22:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '微整護(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2300, 'paid', 'transfer', '2024-11-23T22:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0935939312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉美憶', '0935939312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2024-11-23T22:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0989348320';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范欣瑜', '0989348320') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5620, 'paid', 'cash', '2024-11-23T22:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0912667276';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳巧瑩', '0912667276') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1400, 'paid', 'transfer', '2024-11-23T22:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0916100050';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許梓裕', '0916100050') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-24T19:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0988908027';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張曼琳', '0988908027') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6480, 'paid', 'transfer', '2024-11-24T19:33:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '微整護(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);

  select id into v_customer_id from customers where phone = '0922210176';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙庭涓', '0922210176') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'transfer', '2024-11-24T20:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0922210176';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙庭涓', '0922210176') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2024-11-24T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一短髮', 0, 6);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-25T17:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0911918080';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余郡綺', '0911918080') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-11-25T17:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0932018260';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳沅沅', '0932018260') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5500, 'paid', 'transfer', '2024-11-25T17:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '微整護(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0972523930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采築', '0972523930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4300, 'paid', 'cash', '2024-11-25T20:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0970204245';
  if v_customer_id is null then
    insert into customers (name, phone) values ('高守柔', '0970204245') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-11-29T20:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0922810635';
  if v_customer_id is null then
    insert into customers (name, phone) values ('shuhan', '0922810635') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5600, 'paid', 'cash', '2024-11-29T20:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2024-11-29T20:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-11-29T20:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0972123863';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧雅云Jenny', '0972123863') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-11-29T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 3);

  select id into v_customer_id from customers where phone = '0909016789';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳晨瑋', '0909016789') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-11-29T20:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0912271251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李曉娟', '0912271251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4480, 'paid', 'transfer', '2024-11-30T21:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);

  select id into v_customer_id from customers where phone = '0975511758';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳佩玉', '0975511758') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2024-11-30T21:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0930140800';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡良芸', '0930140800') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-11-30T21:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0972755684';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱秀慧', '0972755684') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'cash', '2024-11-30T21:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3400, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'transfer', '2024-11-30T21:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0988789163';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張郁琳', '0988789163') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'cash', '2024-11-30T21:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '微整護(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0958834166';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Cindy', '0958834166') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-12-01T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0930002035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林千惠', '0930002035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-01T19:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0925368008';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉若晴', '0925368008') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8340, 'paid', 'cash', '2024-12-01T19:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0977095039';
  if v_customer_id is null then
    insert into customers (name, phone) values ('C', '0977095039') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1140, 'paid', 'cash', '2024-12-02T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Model部分費用', 1140, 1);

  select id into v_customer_id from customers where phone = '0933340314';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭瑾', '0933340314') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-02T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0933869750';
  if v_customer_id is null then
    insert into customers (name, phone) values ('烏少瑾', '0933869750') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 500, 'paid', 'cash', '2024-12-02T20:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 500, 1);

  select id into v_customer_id from customers where phone = '0989151264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周晏綸', '0989151264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-12-02T20:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0975404860';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Anna', '0975404860') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10600, 'paid', 'transfer', '2024-12-02T20:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-12-03T18:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0984123480';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳芊逸', '0984123480') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2024-12-03T18:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0911003274';
  if v_customer_id is null then
    insert into customers (name, phone) values ('俞', '0911003274') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'transfer', '2024-12-04T18:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0975207970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Peng Shihting', '0975207970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'cash', '2024-12-04T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0905133030';
  if v_customer_id is null then
    insert into customers (name, phone) values ('碧翎', '0905133030') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8180, 'paid', 'cash', '2024-12-05T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-12-05T20:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0975404860';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Anna', '0975404860') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'cash', '2024-12-05T20:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0928566162';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏汶芳', '0928566162') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3020, 'paid', 'transfer', '2024-12-06T22:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);

  select id into v_customer_id from customers where phone = '0983238126';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳恩宇', '0983238126') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2024-12-06T22:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0921516759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝嘉容', '0921516759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5280, 'paid', 'cash', '2024-12-06T22:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(肩上)', 1280, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0932865506';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉宛鑫', '0932865506') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6300, 'paid', 'transfer', '2024-12-06T23:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0978658113';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖珮珊', '0978658113') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5700, 'paid', 'transfer', '2024-12-07T22:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '微整護(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0978887395';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林辰薰', '0978887395') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5200, 'paid', 'cash', '2024-12-07T22:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 5000, 1);

  select id into v_customer_id from customers where phone = '0909808806';
  if v_customer_id is null then
    insert into customers (name, phone) values ('汪丞', '0909808806') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2024-12-07T22:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3500, 'paid', 'transfer', '2024-12-07T22:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0966429309';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林亞萱', '0966429309') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2880, 'paid', 'transfer', '2024-12-07T22:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0922820114';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Katy', '0922820114') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2500, 'paid', 'transfer', '2024-12-08T22:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2024-12-08T22:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0958607298';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張皓衍', '0958607298') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-12-08T22:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0936720600';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐嫚謙', '0936720600') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7380, 'paid', 'transfer', '2024-12-08T22:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '22合1修護噴霧150ml', 1080, 1);

  select id into v_customer_id from customers where phone = '0928972081';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃詩晴', '0928972081') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-12-10T19:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0972238197';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古瑞雲', '0972238197') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-12-10T19:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2024-12-10T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0972225159';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林慈珉', '0972225159') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4980, 'paid', 'transfer', '2024-12-10T19:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短中髮)', 3500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(肩上)', 1280, 1);

  select id into v_customer_id from customers where phone = '0987889685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖玉涵', '0987889685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7280, 'paid', 'transfer', '2024-12-11T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(肩上)', 1280, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0960357153';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林盈君', '0960357153') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-11T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0937964399';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李柏儀', '0937964399') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6300, 'paid', 'cash', '2024-12-11T20:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0933074933';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Jenny', '0933074933') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3040, 'paid', 'transfer', '2024-12-11T20:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0925197885';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉叡芩', '0925197885') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'cash', '2024-12-12T19:39:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1600, 1);

  select id into v_customer_id from customers where phone = '0985671802';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉姵蘭', '0985671802') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-12-12T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0979303134';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳安可', '0979303134') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2024-12-12T19:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0972981066';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱綺珍', '0972981066') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5800, 'paid', 'cash', '2024-12-12T20:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2600, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6100, 'paid', 'transfer', '2024-12-13T22:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0930131185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐念琪', '0930131185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3540, 'paid', 'transfer', '2024-12-13T22:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2240, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0938909697';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李晨菱', '0938909697') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6100, 'paid', 'transfer', '2024-12-13T22:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0958972965';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Yun', '0958972965') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2060, 'paid', 'cash', '2024-12-13T22:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 1760, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0910528819';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙昱璇', '0910528819') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-13T22:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'transfer', '2024-12-13T22:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 900, 1);

  select id into v_customer_id from customers where phone = '0963009722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡君', '0963009722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2024-12-14T22:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 3);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);

  select id into v_customer_id from customers where phone = '0920930501';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩璟', '0920930501') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6100, 'paid', 'transfer', '2024-12-14T22:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0968434711';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃薇竹', '0968434711') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 10900, 'paid', 'cash', '2024-12-14T22:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '微整護(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0912620719';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林以青', '0912620719') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'transfer', '2024-12-20T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8400, 'paid', 'transfer', '2024-12-20T20:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(肩上)', 1600, 1);

  select id into v_customer_id from customers where phone = '0973682048';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊雯文', '0973682048') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'cash', '2024-12-20T20:40:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0977406722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Emma', '0977406722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2024-12-20T20:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0963616156';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林芯鈺', '0963616156') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 500, 'paid', 'transfer', '2024-12-20T20:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0910595189';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許雅筑', '0910595189') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'cash', '2024-12-21T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'cash', '2024-12-21T17:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);

  select id into v_customer_id from customers where phone = '0922210176';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙庭涓', '0922210176') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 300, 'paid', 'transfer', '2024-12-21T17:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0903472026';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張旭珊', '0903472026') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'cash', '2024-12-22T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 900, 1);

  select id into v_customer_id from customers where phone = '0938640505';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張昊祺', '0938640505') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4020, 'paid', 'transfer', '2024-12-22T20:24:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0952617112';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉以婕', '0952617112') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'transfer', '2024-12-22T20:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '水飛梭洗髮', 600, 1);

  select id into v_customer_id from customers where phone = '0926632756';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊允禾', '0926632756') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-22T20:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3500, 'paid', 'transfer', '2024-12-22T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短中髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0937837896';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃士德', '0937837896') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-22T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0911260392';
  if v_customer_id is null then
    insert into customers (name, phone) values ('高高', '0911260392') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2000, 'paid', 'transfer', '2024-12-22T20:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8520, 'paid', 'transfer', '2024-12-23T22:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);

  select id into v_customer_id from customers where phone = '0976396261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪銘陽', '0976396261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3500, 'paid', 'cash', '2024-12-23T22:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短中髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0920116657';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩凌', '0920116657') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4020, 'paid', 'transfer', '2024-12-23T22:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0978430084';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林彥妤', '0978430084') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6730, 'paid', 'cash', '2024-12-23T22:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'FOAM白光氣墊慕斯[4]180g', 630, 1);

  select id into v_customer_id from customers where phone = '0988102074';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉佩琪', '0988102074') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4620, 'paid', 'cash', '2024-12-24T20:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2720, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);

  select id into v_customer_id from customers where phone = '0972930511';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳毓臻', '0972930511') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6700, 'paid', 'cash', '2024-12-24T20:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);

  select id into v_customer_id from customers where phone = '0911053645';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張佩思', '0911053645') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2024-12-24T20:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2800, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);

  select id into v_customer_id from customers where phone = '0933904454';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采一', '0933904454') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'transfer', '2024-12-24T20:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0933904454';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采一', '0933904454') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'cash', '2024-12-24T20:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0918701207';
  if v_customer_id is null then
    insert into customers (name, phone) values ('刁靖芳', '0918701207') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'transfer', '2024-12-25T20:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-25T20:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0921276823';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭雅琪', '0921276823') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'cash', '2024-12-25T20:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0913281323';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳宜真', '0913281323') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5820, 'paid', 'transfer', '2024-12-25T20:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  select id into v_customer_id from customers where phone = '0932653840';
  if v_customer_id is null then
    insert into customers (name, phone) values ('韋文心', '0932653840') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4700, 'paid', 'cash', '2024-12-26T17:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0975111264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Max', '0975111264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-26T17:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0966689790';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡昀庭', '0966689790') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7700, 'paid', 'cash', '2024-12-26T17:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);

  select id into v_customer_id from customers where phone = '0911074708';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱薰霈', '0911074708') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-26T19:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

  select id into v_customer_id from customers where phone = '0937556533';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭', '0937556533') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2280, 'paid', 'cash', '2024-12-27T22:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);

  select id into v_customer_id from customers where phone = '0937526498';
  if v_customer_id is null then
    insert into customers (name, phone) values ('范小姐', '0937526498') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9200, 'paid', 'cash', '2024-12-27T22:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及腰)', 4200, 1);

  select id into v_customer_id from customers where phone = '0983899666';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃宇潔', '0983899666') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-27T22:13:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0970310628';
  if v_customer_id is null then
    insert into customers (name, phone) values ('采潔', '0970310628') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7700, 'paid', 'transfer', '2024-12-27T22:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4500, 'paid', 'cash', '2024-12-31T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 800, 'paid', 'cash', '2024-12-31T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 800, 1);

  select id into v_customer_id from customers where phone = '0909240707';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳韋如', '0909240707') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3760, 'paid', 'transfer', '2024-12-31T20:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '活力蓬鬆噴霧', 1120, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '逆齡遮瑕噴霧', 1170, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '桃花朵朵乾洗髮', 1170, 1);

  select id into v_customer_id from customers where phone = '0928844377';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張瑜婕', '0928844377') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9180, 'paid', 'transfer', '2024-12-31T20:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '海鹽噴霧', 1080, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '深層護髮(及肩)', 1600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0921319861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張純禕', '0921319861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1000, 'paid', 'cash', '2024-12-31T20:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1000, 1);

end $do$;

-- 執行完請對照下面這行查詢結果（應該是 訂單數 = 177、現場實收合計 = 595630）
select count(*) as 訂單數, coalesce(sum(total), 0) as 現場實收合計 from orders where created_at >= '2024-11-01T00:00:00+08:00' and created_at < '2025-01-01T00:00:00+08:00' and (payment_method is not null or total = 0);
