-- 系統設定（key-value），目前只用來存「線上預約最多能約到幾天後」
create table if not exists app_settings (
  key text primary key,
  value text not null
);

alter table app_settings enable row level security;

create policy "staff_all_app_settings" on app_settings for all to authenticated using (true) with check (true);
create policy "public_select_app_settings" on app_settings for select to anon using (true);

insert into app_settings (key, value) values ('booking_max_advance_days', '30')
on conflict (key) do nothing;
