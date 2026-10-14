-- 作廢 Kendra（0923690206）2022-05-17 那張 (5送1)植物草二合一短髮（剩 5 堂）。
-- 神美 9/22 的商品券剩餘紀錄裡已經沒有這張，經店主確認可以作廢。
-- 做法是把狀態改成「已過期」，不刪除資料；結帳選單不會再出現，客人頁面只會在「已用完／已過期」區塊看到。
-- 如果之後發現弄錯，可以把 status 改回 'active' 就恢復。
-- 保護：剛好對到 1 張才會修改，否則整段取消。
do $do$
declare
  n int;
begin
  update vouchers v set status = 'expired'
  from customers c
  where c.id = v.customer_id and c.phone = '0923690206'
    and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2022-05-17';
  get diagnostics n = row_count;
  if n <> 1 then
    raise exception '預期剛好對到 1 張，實際是 % 張，已取消，沒有任何資料被修改。', n;
  end if;
end $do$;

select c.name as 客人, v.service_name as 商品券, v.remaining_sessions as 剩餘, v.total_sessions as 共, v.status as 狀態, v.purchased_at as 購買日
from vouchers v join customers c on c.id = v.customer_id
where c.phone = '0923690206';
