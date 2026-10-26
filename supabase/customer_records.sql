-- 顧客服務紀錄（染髮配方等）：每位客人可以有很多筆，依日期排列
create table if not exists customer_records (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references customers(id) on delete cascade,
  visit_date date not null default ((now() at time zone 'Asia/Taipei')::date),
  content text not null,
  order_id uuid references orders(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists customer_records_customer_idx on customer_records (customer_id, visit_date desc);

alter table customer_records enable row level security;
-- 只有登入後台的人看得到、改得了（客人預約頁的匿名身分完全碰不到）
create policy "staff_all_customer_records" on customer_records for all to authenticated using (true) with check (true);

select count(*) as 已建立的紀錄筆數 from customer_records;
