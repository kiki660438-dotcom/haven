-- 預約可以填「人數」（例如 3 人一起來），系統會用「人數 × 服務時長」來擋住設計師的時間
alter table appointments add column if not exists party_size int not null default 1 check (party_size between 1 and 6);

select count(*) as 預約筆數, max(party_size) as 最大人數 from appointments;
