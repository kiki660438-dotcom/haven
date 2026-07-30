-- 客戶資料表
create table customers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text,
  email text,
  note text,
  birthday date,
  created_at timestamptz not null default now()
);

-- 服務項目表
create table services (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price integer not null,
  duration_minutes integer not null default 60,
  created_at timestamptz not null default now()
);

-- 預約資料表
create table appointments (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references customers(id),
  service_id uuid not null references services(id),
  start_time timestamptz not null,
  status text not null default 'pending',
  created_at timestamptz not null default now()
);

-- 訂單資料表（開單結帳）
create table orders (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid references customers(id),
  customer_name text,
  appointment_id uuid references appointments(id),
  total integer not null default 0,
  status text not null default 'unpaid',
  created_at timestamptz not null default now()
);

alter table orders add column payment_method text;

create table order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  service_id uuid references services(id),
  service_name text not null,
  price integer not null,
  quantity integer not null default 1
);

alter table orders enable row level security;
alter table order_items enable row level security;

create policy "temp_allow_all_orders" on orders for all using (true) with check (true);
create policy "temp_allow_all_order_items" on order_items for all using (true) with check (true);

-- 商品卷（儲值/贈品券）
create table vouchers (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  customer_id uuid references customers(id),
  initial_value integer not null,
  remaining_value integer not null,
  status text not null default 'active',
  issued_at timestamptz not null default now(),
  expires_at date
);

-- 商品（庫存管理用）
create table products (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  unit text not null default '個',
  stock_quantity integer not null default 0,
  cost_price integer not null default 0,
  created_at timestamptz not null default now()
);

-- 進貨紀錄
create table purchase_records (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id),
  quantity integer not null,
  unit_cost integer not null,
  total_cost integer not null,
  supplier text,
  purchased_at timestamptz not null default now()
);

alter table vouchers enable row level security;
alter table products enable row level security;
alter table purchase_records enable row level security;

create policy "temp_allow_all_vouchers" on vouchers for all using (true) with check (true);
create policy "temp_allow_all_products" on products for all using (true) with check (true);
create policy "temp_allow_all_purchase_records" on purchase_records for all using (true) with check (true);
