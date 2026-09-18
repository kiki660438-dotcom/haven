-- 服務項目的「配方」：一次這個服務會用掉哪些商品、用多少
create table if not exists service_products (
  id uuid primary key default gen_random_uuid(),
  service_id uuid not null references services(id) on delete cascade,
  product_id uuid not null references products(id) on delete cascade,
  quantity numeric(10,2) not null default 1
);

alter table service_products enable row level security;
create policy "staff_all_service_products" on service_products for all to authenticated using (true) with check (true);

-- 訂單明細記下「當時」算出的成本，之後商品成本變動也不會影響歷史訂單的毛利
alter table order_items add column if not exists unit_cost numeric(10,2);
