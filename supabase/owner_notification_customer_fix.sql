-- 修正「有新的線上預約」通知裡客人姓名/電話是空白的問題：
-- notifyOwnerOfNewBooking 是用 anon 連線查 customers，但 anon 沒有讀取 customers 的權限，
-- 所以之前查回來的 name/phone 都是空的。改用 security definer function 繞過這個限制。
create or replace function public.get_customer_name_phone(p_customer_id uuid)
returns table (name text, phone text)
language sql
security definer
set search_path = public
as $$
  select name, phone from customers where id = p_customer_id;
$$;

grant execute on function public.get_customer_name_phone(uuid) to anon;
