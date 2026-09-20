-- 「新增預約」讓後台員工帳號也能呼叫 find_customer_id_by_phone（原本只開放給 anon，
-- 也就是線上預約的客人；員工登入後是 authenticated 身份，需要另外授權才能用同一支函式）
grant execute on function public.find_customer_id_by_phone(text) to authenticated;
