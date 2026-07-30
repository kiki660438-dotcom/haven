create or replace function public.find_customer_id_by_line_user_id(p_line_user_id text)
returns uuid
language sql
security definer
set search_path = public
as $$
  select id from customers where line_user_id = p_line_user_id limit 1;
$$;

grant execute on function public.find_customer_id_by_line_user_id(text) to anon;
