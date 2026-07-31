alter table services add column total_sessions integer;

update services set total_sessions = 3 where name like '(3堂)%';
update services set total_sessions = 6 where name like '(5送1)%';
update services set total_sessions = 13 where name like '(10送3)%';
update services set total_sessions = 12 where name in ('蘊髮再生療程12堂', '凍膜12堂', '洗髮12堂');

insert into services (name, price, duration_minutes, total_sessions)
select '蘊活再生角質露(贈4堂)', 0, 30, 4
where not exists (select 1 from services where name = '蘊活再生角質露(贈4堂)');
