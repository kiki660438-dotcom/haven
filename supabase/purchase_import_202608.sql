-- 進貨匯入：Haven.xls.xlsx（2026/08/10、2026/08/20，供應商 Eason），共 22 筆品項，總成本 $12355
do $do$
declare
  v_product_id uuid;
begin
  select id into v_product_id from products where name = '1號自然力內結構活性水500ml';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('1號自然力內結構活性水500ml', '瓶', 1, 1800) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 1800 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 1800, 1800, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '6號丹麥女王縮時護髮霜';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('6號丹麥女王縮時護髮霜', '條', 1, 895) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 895 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 895, 895, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨雙氧乳1.5%';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨雙氧乳1.5%', '瓶', 1, 380) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 380 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 380, 380, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨雙氧乳6%';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨雙氧乳6%', '瓶', 1, 380) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 380 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 380, 380, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨雙氧乳9%';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨雙氧乳9%', '瓶', 1, 380) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 380 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 380, 380, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏5.17淺棕亞麻綠';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏5.17淺棕亞麻綠', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 5.2淺棕灰棕';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 5.2淺棕灰棕', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 5.77淺棕褐';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 5.77淺棕褐', '條', 1, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 240, 240, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 7.77金褐';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 7.77金褐', '條', 1, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 240, 240, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 8.66淺金亮橘';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 8.66淺金亮橘', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-10T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 0.66加強橘';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 0.66加強橘', '條', 1, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 240, 240, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 1.01藍紫';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 1.01藍紫', '條', 3, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 3, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 3, 240, 720, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 10.3鉑金奶茶';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 10.3鉑金奶茶', '條', 1, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 240, 240, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 3.0深棕';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 3.0深棕', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 6.6深金橘';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 6.6深金橘', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 6.8深金紫';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 6.8深金紫', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 7.6金橘';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 7.6金橘', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏8.17淺金亞麻綠';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏8.17淺金亞麻綠', '條', 3, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 3, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 3, 240, 720, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 8.3淺金奶茶';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 8.3淺金奶茶', '條', 1, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 240, 240, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '自然力無氨染髮膏 8.66淺金亮橘';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('自然力無氨染髮膏 8.66淺金亮橘', '條', 2, 240) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 240 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 240, 480, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '平衡舒活洗髮露250ml';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('平衡舒活洗髮露250ml', '瓶', 1, 660) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 1, cost_price = 660 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 1, 660, 660, 'Eason', '2026-08-20T12:00:00+08:00');

  select id into v_product_id from products where name = '超閃耀髮霧225ml';
  if v_product_id is null then
    insert into products (name, unit, stock_quantity, cost_price) values ('超閃耀髮霧225ml', '瓶', 2, 690) returning id into v_product_id;
  else
    update products set stock_quantity = stock_quantity + 2, cost_price = 690 where id = v_product_id;
  end if;
  insert into purchase_records (product_id, quantity, unit_cost, total_cost, supplier, purchased_at) values (v_product_id, 2, 690, 1380, 'Eason', '2026-08-20T12:00:00+08:00');

end $do$;
