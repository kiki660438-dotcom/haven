-- 匯入 2026-07 ~ 2026-08 訂單列表（來自神美匯出的每月訂單列表）
-- orders.total 只算「現場付款」的現金/匯款實收，商品券折抵的部分不重複算營業額（跟 9 月匯入的規則一致）；
-- 每一筆訂單照樣建立（total 可能是 0），客人的消費次數／最近消費才會正確。order_items.price 存的是「單價」。
do $do$
declare
  v_customer_id uuid;
  v_order_id uuid;
begin
  if exists (select 1 from orders where created_at >= '2026-07-01T00:00:00+08:00' and created_at < '2026-09-01T00:00:00+08:00' and (payment_method is not null or total = 0)) then
    raise exception '這段期間的訂單看起來已經匯入過了，為避免重複，已停止（沒有任何資料被寫入）';
  end if;

  select id into v_customer_id from customers where phone = '0986998455';
  if v_customer_id is null then
    insert into customers (name, phone) values ('白筑安', '0986998455') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-07-08T19:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);

  select id into v_customer_id from customers where phone = '0928007269';
  if v_customer_id is null then
    insert into customers (name, phone) values ('賴丁霞', '0928007269') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'cash', '2026-07-08T19:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0903122133';
  if v_customer_id is null then
    insert into customers (name, phone) values ('梁巧妮', '0903122133') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-07-08T19:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0914102989';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐子鈞', '0914102989') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'transfer', '2026-07-08T19:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(短髮)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0921516759';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝嘉容', '0921516759') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-07-09T19:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0936720600';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐嫚謙', '0936720600') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2026-07-09T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0930964133';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳玉君', '0930964133') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3800, 'paid', 'cash', '2026-07-09T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2600, 1);

  select id into v_customer_id from customers where phone = '0978178142';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳馥', '0978178142') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'transfer', '2026-07-09T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4260, 'paid', 'transfer', '2026-07-09T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(肩上)', 2700, 1);

  select id into v_customer_id from customers where phone = '0909664508';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡馨葶', '0909664508') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9120, 'paid', 'transfer', '2026-07-09T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0930571516';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古庭榕', '0930571516') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-09T19:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0983899666';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃宇潔', '0983899666') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-07-10T17:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0973240827';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉子妍', '0973240827') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-07-10T17:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0976001922';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉騏蒂', '0976001922') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'cash', '2026-07-10T17:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-07-10T17:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933979857';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃靚姝', '0933979857') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-07-10T17:28:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0928685432';
  if v_customer_id is null then
    insert into customers (name, phone) values ('湯璧禎', '0928685432') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8000, 'paid', 'transfer', '2026-07-12T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8000, 'paid', 'transfer', '2026-07-12T21:04:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(短髮)', 3500, 1);

  select id into v_customer_id from customers where phone = '0988367591';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Ruwen', '0988367591') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'transfer', '2026-07-13T18:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0963009722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡君', '0963009722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6960, 'paid', 'cash', '2026-07-13T18:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 2);

  select id into v_customer_id from customers where phone = '0930110119';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思婷', '0930110119') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-07-13T18:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0912399560';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佳蓉8126', '0912399560') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-07-14T13:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0913935353';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭光媜', '0913935353') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2900, 'paid', 'cash', '2026-07-15T14:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0966895583';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許欣怡', '0966895583') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-07-17T15:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0972155749';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李金穎', '0972155749') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'cash', '2026-07-17T16:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1600, 'paid', 'cash', '2026-07-17T18:15:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3400, 'paid', 'transfer', '2026-07-17T18:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 3000, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 2000, 'paid', 'cash', '2026-07-17T18:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 2000, 1);

  select id into v_customer_id from customers where phone = '0938825609';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪夢霜', '0938825609') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3800, 'paid', 'cash', '2026-07-17T18:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2600, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-07-18T19:07:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一長髮', 3083, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0939806303';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Vivian Hsieh', '0939806303') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-07-18T19:08:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0972603230';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃聖雅', '0972603230') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2140, 'paid', 'transfer', '2026-07-18T19:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '豐厚洗髮精250ml', 940, 1);

  select id into v_customer_id from customers where phone = '0910647957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Mia', '0910647957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2960, 'paid', 'transfer', '2026-07-18T19:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮淨化(含水飛梭)', 2000, 1);

  select id into v_customer_id from customers where phone = '0972003410';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡慧勤', '0972003410') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2026-07-18T19:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 400, 'paid', 'transfer', '2026-07-19T17:25:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2026-07-19T17:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0976396261';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪銘陽', '0976396261') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-07-19T21:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988933481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯語', '0988933481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-07-19T21:09:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0986456581';
  if v_customer_id is null then
    insert into customers (name, phone) values ('翁瑋憶', '0986456581') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6900, 'paid', 'transfer', '2026-07-19T21:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0975111264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Max', '0975111264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-19T21:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0902201208';
  if v_customer_id is null then
    insert into customers (name, phone) values ('余文萱', '0902201208') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9500, 'paid', 'cash', '2026-07-20T18:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然捲夾順(加購,價格依現場判斷)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0934327003';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬瑜', '0934327003') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-07-20T18:06:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0928864488';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張家華', '0928864488') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3400, 'paid', 'transfer', '2026-07-20T19:18:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988044086';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳艾婕', '0988044086') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'transfer', '2026-07-21T20:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 10160, 'paid', 'transfer', '2026-07-21T20:14:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 2);

  select id into v_customer_id from customers where phone = '0921944787';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃卉儀', '0921944787') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-07-22T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0988106810';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐芷芸', '0988106810') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-07-22T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0916337403';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鍾明瑄', '0916337403') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3800, 'paid', 'transfer', '2026-07-22T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(肩上)', 2600, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-22T18:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988525058';
  if v_customer_id is null then
    insert into customers (name, phone) values ('胡亞婷', '0988525058') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-07-22T18:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-07-24T17:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0931592861';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭婷渝', '0931592861') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-07-24T18:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937609868';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Abby', '0937609868') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4340, 'paid', 'transfer', '2026-07-24T18:10:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0933639236';
  if v_customer_id is null then
    insert into customers (name, phone) values ('YT', '0933639236') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-07-24T18:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0972235070';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭琬純', '0972235070') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-24T18:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0910731516';
  if v_customer_id is null then
    insert into customers (name, phone) values ('May', '0910731516') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2026-07-24T18:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0988292728';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭智旻', '0988292728') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-24T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0931278005';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳', '0931278005') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-07-24T18:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0978261380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('謝巧羿', '0978261380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-07-25T19:11:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0963307597';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儷安', '0963307597') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7160, 'paid', 'transfer', '2026-07-25T19:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(及肩)', 3700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0920009520';
  if v_customer_id is null then
    insert into customers (name, phone) values ('江政樺', '0920009520') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-25T19:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0934029569';
  if v_customer_id is null then
    insert into customers (name, phone) values ('方瀅雲', '0934029569') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-07-25T19:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 0, 'paid', null, '2026-07-26T17:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0900509652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('喻靖洧', '0900509652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1800, 'paid', 'cash', '2026-07-26T17:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0984196729';
  if v_customer_id is null then
    insert into customers (name, phone) values ('古燕婷', '0984196729') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5000, 'paid', 'cash', '2026-07-26T17:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);

  select id into v_customer_id from customers where phone = '0983999246';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳守倫', '0983999246') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-26T17:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988391708';
  if v_customer_id is null then
    insert into customers (name, phone) values ('小云', '0988391708') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-07-27T18:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0921754136';
  if v_customer_id is null then
    insert into customers (name, phone) values ('卓昀蓁', '0921754136') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-07-27T18:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0936536912';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑞妤', '0936536912') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5100, 'paid', 'cash', '2026-07-27T18:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0912402172';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林怡君', '0912402172') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4400, 'paid', 'transfer', '2026-07-28T17:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0963132905';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游孟惟', '0963132905') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5580, 'paid', 'transfer', '2026-07-28T17:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 4000, 'paid', 'transfer', '2026-07-30T17:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0975225923';
  if v_customer_id is null then
    insert into customers (name, phone) values ('何絲雅', '0975225923') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-07-31T16:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0914035288';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊詠文', '0914035288') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2026-07-31T16:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);

  select id into v_customer_id from customers where phone = '0926052424';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周秋燕', '0926052424') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3860, 'paid', 'transfer', '2026-07-31T16:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-01T18:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0910033140';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Amor Huang', '0910033140') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-01T18:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0933933931';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃奕寧', '0933933931') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3990, 'paid', 'transfer', '2026-08-01T19:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-乾屑敏(紅)', 2430, 1);

  select id into v_customer_id from customers where phone = '0975653693';
  if v_customer_id is null then
    insert into customers (name, phone) values ('簡欣如', '0975653693') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-01T19:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0976523393';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃柔甄', '0976523393') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 13620, 'paid', 'transfer', '2026-08-01T19:03:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然捲夾順(加購,價格依現場判斷)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(肩上)', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0930629167';
  if v_customer_id is null then
    insert into customers (name, phone) values ('寸碧秀', '0930629167') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-02T17:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0985556652';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳曉思', '0985556652') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-02T17:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-02T17:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917679666';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡如', '0917679666') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-02T17:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925839251';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王莨喻', '0925839251') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4160, 'paid', 'transfer', '2026-08-02T18:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草修飾白髮三合一(肩上)', 3200, 1);

  select id into v_customer_id from customers where phone = '0925209871';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳真如', '0925209871') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5880, 'paid', 'transfer', '2026-08-02T18:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0935720405';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳姿安', '0935720405') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-02T18:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0937176884';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭瑞文', '0937176884') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-08-03T17:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0905550023';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭渝臻', '0905550023') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8500, 'paid', 'transfer', '2026-08-03T17:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及腰)', 3500, 1);

  select id into v_customer_id from customers where phone = '0987952059';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Sabrina', '0987952059') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-08-03T19:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0936890683';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳孟筑', '0936890683') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-04T17:41:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0930277185';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王立文', '0930277185') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-04T17:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0920167669';
  if v_customer_id is null then
    insert into customers (name, phone) values ('邱是寧', '0920167669') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-08-04T17:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988124116';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳盈如', '0988124116') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'transfer', '2026-08-04T17:42:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 1200, 'paid', 'cash', '2026-08-05T18:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0988268722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('沈佩臻', '0988268722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-08-05T18:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0963125455';
  if v_customer_id is null then
    insert into customers (name, phone) values ('董從懿', '0963125455') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6740, 'paid', 'transfer', '2026-08-05T18:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);

  select id into v_customer_id from customers where phone = '0988100354';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭宇文', '0988100354') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-05T18:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0911471215';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Mei', '0911471215') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3700, 'paid', 'cash', '2026-08-05T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-05T18:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0932937523';
  if v_customer_id is null then
    insert into customers (name, phone) values ('彭佩雯', '0932937523') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-07T15:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0921222451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃淳靖', '0921222451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3360, 'paid', 'cash', '2026-08-07T18:43:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0963023278';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林儀柔', '0963023278') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6820, 'paid', 'transfer', '2026-08-07T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'HUE CARE水感極萃油115ml', 1620, 1);

  select id into v_customer_id from customers where phone = '0905136212';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳詩怡', '0905136212') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-07T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0966297741';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林', '0966297741') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-07T18:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0953921287';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林宇君', '0953921287') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-08T18:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0939927312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳芳宜', '0939927312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-08T18:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0928961312';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周碧玲', '0928961312') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2400, 'paid', 'cash', '2026-08-08T18:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 2);

  select id into v_customer_id from customers where phone = '0921033528';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張雅晴', '0921033528') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-08-08T18:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0988331820';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王思妤', '0988331820') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-08T18:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975136801';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Isaac', '0975136801') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-08T19:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0960958604';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾愛', '0960958604') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-08-09T20:51:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0936056500';
  if v_customer_id is null then
    insert into customers (name, phone) values ('莊絜晰', '0936056500') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-09T20:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0931228196';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊景辰', '0931228196') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-09T20:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0936503130';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳以庭', '0936503130') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 13500, 'paid', 'transfer', '2026-08-09T20:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '自然捲夾順(加購,價格依現場判斷)', 2000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0909217927';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張凱琪', '0909217927') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-11T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0960589753';
  if v_customer_id is null then
    insert into customers (name, phone) values ('羅曼瑄', '0960589753') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'transfer', '2026-08-11T18:55:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0937896596';
  if v_customer_id is null then
    insert into customers (name, phone) values ('葉君薇', '0937896596') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8200, 'paid', 'cash', '2026-08-11T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0955080469';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳妙鈴', '0955080469') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-11T18:56:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925197885';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉叡芩', '0925197885') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'transfer', '2026-08-11T18:57:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0926299953';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭庭儒', '0926299953') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4200, 'paid', 'transfer', '2026-08-14T14:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0975462530';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李念庭', '0975462530') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 700, 'paid', 'transfer', '2026-08-14T14:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 700, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);

  select id into v_customer_id from customers where phone = '0981998638';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林榆真', '0981998638') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6500, 'paid', 'transfer', '2026-08-14T19:16:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '無痕髮根燙', 2500, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'cash', '2026-08-14T19:17:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0923811632';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林佳靜', '0923811632') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6750, 'paid', 'transfer', '2026-08-15T17:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '白光氣墊慕斯2', 630, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '丹麥女王縮時護髮霜', 1620, 1);

  select id into v_customer_id from customers where phone = '0912012940';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳逸芸', '0912012940') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-15T17:26:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919102928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林柔青', '0919102928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1920, 'paid', 'transfer', '2026-08-15T17:27:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 2);

  select id into v_customer_id from customers where phone = '0937596789';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蔡蕙羽', '0937596789') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-16T11:46:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0966566128';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李玥陵', '0966566128') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-08-16T15:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0975530121';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林琬若', '0975530121') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-16T16:23:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0912163988';
  if v_customer_id is null then
    insert into customers (name, phone) values ('馮若涵', '0912163988') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4840, 'paid', 'transfer', '2026-08-16T18:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 1000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);

  select id into v_customer_id from customers where phone = '0970718608';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李筱薇', '0970718608') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-08-16T20:30:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  insert into orders (customer_name, total, status, payment_method, created_at) values ('散客', 7000, 'paid', 'transfer', '2026-08-16T20:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0963009722';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡君', '0963009722') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-17T14:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 2);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 2);

  select id into v_customer_id from customers where phone = '0929802290';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李明松', '0929802290') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-17T15:45:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0938873027';
  if v_customer_id is null then
    insert into customers (name, phone) values ('劉欣怡', '0938873027') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-17T17:01:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0921156691';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林瑋萱', '0921156691') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-17T18:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0967052032';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭芳屏', '0967052032') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4800, 'paid', 'transfer', '2026-08-18T16:44:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 3600, 1);

  select id into v_customer_id from customers where phone = '0968711862';
  if v_customer_id is null then
    insert into customers (name, phone) values ('洪子婷', '0968711862') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3160, 'paid', 'transfer', '2026-08-18T17:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(短髮)', 1600, 1);

  select id into v_customer_id from customers where phone = '0905505034';
  if v_customer_id is null then
    insert into customers (name, phone) values ('霏法狂徒', '0905505034') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5500, 'paid', 'transfer', '2026-08-19T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及腰)', 5500, 1);

  select id into v_customer_id from customers where phone = '0955038711';
  if v_customer_id is null then
    insert into customers (name, phone) values ('許家慈', '0955038711') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-08-19T18:52:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '冷塑燙(肩上)', 4000, 1);

  select id into v_customer_id from customers where phone = '0920251451';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張艾婷', '0920251451') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-19T18:53:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0972523930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林采築', '0972523930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3600, 'paid', 'transfer', '2026-08-19T18:54:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '護色保養(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988280548';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃筱君', '0988280548') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-08-21T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0918037770';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖凡儀', '0918037770') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 8400, 'paid', 'transfer', '2026-08-21T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0963781330';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳美惠', '0963781330') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-21T18:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0920116657';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李佩凌', '0920116657') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4760, 'paid', 'transfer', '2026-08-21T18:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮梳', 900, 1);

  select id into v_customer_id from customers where phone = '0974358358';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃沐薇', '0974358358') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 5760, 'paid', 'transfer', '2026-08-23T12:02:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊髮再生療程12堂', 2500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '凍膜', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生角質露(贈4堂)', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生頭皮精華-油掉(黃)', 3330, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '蘊活再生髮浴-油掉(藍)', 2430, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3460, 'paid', 'transfer', '2026-08-23T20:19:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '漂髮(短髮)', 2500, 1);

  select id into v_customer_id from customers where phone = '0907225021';
  if v_customer_id is null then
    insert into customers (name, phone) values ('昆', '0907225021') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-23T20:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0903472026';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張旭珊', '0903472026') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'transfer', '2026-08-23T20:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0937040832';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭又慈', '0937040832') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1080, 'paid', 'transfer', '2026-08-23T20:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1080, 1);

  select id into v_customer_id from customers where phone = '0972869831';
  if v_customer_id is null then
    insert into customers (name, phone) values ('李珊', '0972869831') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-23T20:21:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(10送3)植物草三合一長髮', 2846, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0975111264';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Max', '0975111264') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-24T16:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975075855';
  if v_customer_id is null then
    insert into customers (name, phone) values ('Daphnë', '0975075855') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-08-24T16:37:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0935388235';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄭妘菁', '0935388235') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3300, 'paid', 'transfer', '2026-08-24T16:38:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0909091400';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王郁雯', '0909091400') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-08-25T15:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '加購水飛梭', 300, 1);

  select id into v_customer_id from customers where phone = '0930373596';
  if v_customer_id is null then
    insert into customers (name, phone) values ('周佳真', '0930373596') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-25T15:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0952094103';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王藝錚', '0952094103') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2800, 'paid', 'cash', '2026-08-25T15:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

  select id into v_customer_id from customers where phone = '0912618908';
  if v_customer_id is null then
    insert into customers (name, phone) values ('黃玉瑄', '0912618908') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 6740, 'paid', 'cash', '2026-08-26T20:34:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '頭皮隔離', 500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(及肩)', 2880, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);

  select id into v_customer_id from customers where phone = '0966205057';
  if v_customer_id is null then
    insert into customers (name, phone) values ('雪倫', '0966205057') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-26T20:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0925953035';
  if v_customer_id is null then
    insert into customers (name, phone) values ('戴美苓', '0925953035') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 2160, 'paid', 'cash', '2026-08-26T20:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0967019116';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳婕瑩', '0967019116') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 7500, 'paid', 'transfer', '2026-08-26T20:35:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '溫塑燙(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 3000, 1);

  select id into v_customer_id from customers where phone = '0958231928';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林佳儀', '0958231928') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-26T20:36:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0912495705';
  if v_customer_id is null then
    insert into customers (name, phone) values ('蕭韋柔', '0912495705') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 600, 'paid', 'cash', '2026-08-28T19:47:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0978987902';
  if v_customer_id is null then
    insert into customers (name, phone) values ('楊佩慈', '0978987902') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 200, 'paid', 'cash', '2026-08-28T19:48:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪劉海', 200, 1);

  select id into v_customer_id from customers where phone = '0988521462';
  if v_customer_id is null then
    insert into customers (name, phone) values ('汪玲玲', '0988521462') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'transfer', '2026-08-28T19:49:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);

  select id into v_customer_id from customers where phone = '0916876506';
  if v_customer_id is null then
    insert into customers (name, phone) values ('徐惠君', '0916876506') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-28T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0982731327';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林子禹', '0982731327') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-28T19:50:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0987889685';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖玉涵', '0987889685') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'transfer', '2026-08-28T20:12:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, 'Vegan深層護髮(及肩)', 2400, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 400, 1);

  select id into v_customer_id from customers where phone = '0988933481';
  if v_customer_id is null then
    insert into customers (name, phone) values ('張芯語', '0988933481') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'cash', '2026-08-29T15:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0958603566';
  if v_customer_id is null then
    insert into customers (name, phone) values ('游媛婷', '0958603566') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1560, 'paid', 'transfer', '2026-08-29T15:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);

  select id into v_customer_id from customers where phone = '0936682621';
  if v_customer_id is null then
    insert into customers (name, phone) values ('魏婕安', '0936682621') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-29T16:00:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0930777970';
  if v_customer_id is null then
    insert into customers (name, phone) values ('廖偲勛', '0930777970') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 900, 'paid', 'transfer', '2026-08-29T16:05:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '燙瀏海（價錢依現場判斷）', 600, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '洗髮', 300, 1);

  select id into v_customer_id from customers where phone = '0972718380';
  if v_customer_id is null then
    insert into customers (name, phone) values ('曾佳郁', '0972718380') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'cash', '2026-08-29T18:31:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0917656957';
  if v_customer_id is null then
    insert into customers (name, phone) values ('郭馥萱', '0917656957') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-30T14:22:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草二合一短髮', 0, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0919363431';
  if v_customer_id is null then
    insert into customers (name, phone) values ('陳怡萍', '0919363431') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4500, 'paid', 'cash', '2026-08-30T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(及肩)', 4500, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '(5送1)植物草三合一中髮', 2667, 1);

  select id into v_customer_id from customers where phone = '0919579930';
  if v_customer_id is null then
    insert into customers (name, phone) values ('吳彥霆', '0919579930') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 960, 'paid', 'transfer', '2026-08-30T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);

  select id into v_customer_id from customers where phone = '0966159918';
  if v_customer_id is null then
    insert into customers (name, phone) values ('王怡蘋', '0966159918') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 4000, 'paid', 'cash', '2026-08-30T19:20:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '縮毛矯正(短中髮)', 4000, 1);

  select id into v_customer_id from customers where phone = '0910528819';
  if v_customer_id is null then
    insert into customers (name, phone) values ('趙昱璇', '0910528819') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 3200, 'paid', 'cash', '2026-08-31T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '植物草頭皮養護二合一(短髮)', 2000, 1);

  select id into v_customer_id from customers where phone = '0928308361';
  if v_customer_id is null then
    insert into customers (name, phone) values ('鄧子紘', '0928308361') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 1200, 'paid', 'transfer', '2026-08-31T20:58:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 1200, 1);

  select id into v_customer_id from customers where phone = '0975116166';
  if v_customer_id is null then
    insert into customers (name, phone) values ('林貞岑', '0975116166') returning id into v_customer_id;
  end if;
  insert into orders (customer_id, total, status, payment_method, created_at) values (v_customer_id, 9360, 'paid', 'transfer', '2026-08-31T20:59:00+08:00') returning id into v_order_id;
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '剪髮', 960, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分染', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '部分漂', 3000, 1);
  insert into order_items (order_id, service_name, price, quantity) values (v_order_id, '染髮(肩上)', 2400, 1);

end $do$;

-- 執行完請對照下面這行查詢結果（應該是 訂單數 = 182、現場實收合計 = 544320）
select count(*) as 訂單數, coalesce(sum(total), 0) as 現場實收合計 from orders where created_at >= '2026-07-01T00:00:00+08:00' and created_at < '2026-09-01T00:00:00+08:00' and (payment_method is not null or total = 0);
