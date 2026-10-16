-- 燙髮、染髮：預約開始後 2 小時，下一位客人就能約（原本 150 分鐘 → 120 分鐘）
-- 剪髮本來就是 60 分鐘，不用改
-- 挑染／漂髮／縮毛矯正維持 150 分鐘，沒有改動
do $do$
declare n int;
begin
  update services
  set duration_minutes = 120
  where (name like '冷塑燙-%' or name like '溫塑燙-%' or name like '染髮-%' or name = '無痕髮根燙')
    and total_sessions is null;
  get diagnostics n = row_count;
  if n <> 12 then
    raise exception '預期修改 12 個服務，實際 % 個，已取消', n;
  end if;
end
$do$;

select name, duration_minutes, buffer_minutes
from services
where name like '冷塑燙-%' or name like '溫塑燙-%' or name like '染髮-%' or name = '無痕髮根燙'
order by name;
