-- 修正 9 月訂單匯入時，數量大於 1 的品項把「小計」誤存成「單價」的問題
-- （營業額頁「依服務項目」會用 單價 × 數量 計算，所以這 2 筆原本被算成兩倍）。
-- 只修指定的這 2 筆，重複執行也不會再改到（改完金額就對不上條件了）。
update order_items oi
set price = 1200
from orders o
where oi.order_id = o.id
  and o.created_at >= '2026-09-01T00:00:00+08:00' and o.created_at < '2026-09-23T00:00:00+08:00'
  and oi.service_name = '剪髮' and oi.price = 2400 and oi.quantity = 2;

update order_items oi
set price = 2880
from orders o
where oi.order_id = o.id
  and o.created_at >= '2026-09-01T00:00:00+08:00' and o.created_at < '2026-09-23T00:00:00+08:00'
  and oi.service_name = '染髮(及肩)' and oi.price = 5760 and oi.quantity = 2;
