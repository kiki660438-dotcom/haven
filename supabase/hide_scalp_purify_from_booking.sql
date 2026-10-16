-- 頭皮淨化（含水飛梭）不再開放線上預約（後台代客預約、開單仍可使用）
do $do$
declare n int;
begin
  update services
  set hide_from_booking = true
  where name = '頭皮淨化（含水飛梭）' and total_sessions is null;
  get diagnostics n = row_count;
  if n <> 1 then
    raise exception '預期修改 1 個服務，實際 % 個，已取消', n;
  end if;
end
$do$;

select name, hide_from_booking from services where name like '頭皮淨化%';
