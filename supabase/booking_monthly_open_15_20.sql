-- 線上預約：每月 15 號晚上 8 點，自動開放下個月整個月。
-- 也可以在後台「系統設定 → 開放預約」改，不一定要跑這段。
insert into app_settings (key, value) values ('booking_monthly_open', '15:20'), ('booking_open_until', '')
on conflict (key) do update set value = excluded.value;

select key, value from app_settings where key like 'booking_%';
