alter table services add column if not exists hide_from_booking boolean not null default false;

update services set hide_from_booking = true where name = '一般洗髮';
