-- 補建之前沒有成功建立的資料表
create table if not exists vouchers (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  customer_id uuid references customers(id),
  initial_value integer not null,
  remaining_value integer not null,
  status text not null default 'active',
  issued_at timestamptz not null default now(),
  expires_at date
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  unit text not null default '個',
  stock_quantity integer not null default 0,
  cost_price integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists purchase_records (
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

-- 移除之前暫時性的開放權限（如果存在的話）
drop policy if exists "temp_allow_all_customers" on customers;
drop policy if exists "temp_allow_all_services" on services;
drop policy if exists "temp_allow_all_appointments" on appointments;
drop policy if exists "temp_allow_all_orders" on orders;
drop policy if exists "temp_allow_all_order_items" on order_items;
drop policy if exists "temp_allow_all_vouchers" on vouchers;
drop policy if exists "temp_allow_all_products" on products;
drop policy if exists "temp_allow_all_purchase_records" on purchase_records;

-- 已登入員工：完整讀寫權限
create policy "staff_all_customers" on customers for all to authenticated using (true) with check (true);
create policy "staff_all_services" on services for all to authenticated using (true) with check (true);
create policy "staff_all_appointments" on appointments for all to authenticated using (true) with check (true);
create policy "staff_all_orders" on orders for all to authenticated using (true) with check (true);
create policy "staff_all_order_items" on order_items for all to authenticated using (true) with check (true);
create policy "staff_all_vouchers" on vouchers for all to authenticated using (true) with check (true);
create policy "staff_all_products" on products for all to authenticated using (true) with check (true);
create policy "staff_all_purchase_records" on purchase_records for all to authenticated using (true) with check (true);

-- 未登入訪客（線上預約頁面 /book 專用）：僅開放必要的最小權限
create policy "public_select_services" on services for select to anon using (true);
create policy "public_select_appointments" on appointments for select to anon using (true);
create policy "public_insert_appointments" on appointments for insert to anon with check (true);
create policy "public_insert_customers" on customers for insert to anon with check (true);

-- 安全查詢函式：讓線上預約可以「用電話檢查是否為舊客戶」，
-- 但不會把整張客戶資料表（姓名/電話/Email等）開放給訪客直接讀取
create or replace function public.find_customer_id_by_phone(p_phone text)
returns uuid
language sql
security definer
set search_path = public
as $$
  select id from customers where phone = p_phone limit 1;
$$;

grant execute on function public.find_customer_id_by_phone(text) to anon;
