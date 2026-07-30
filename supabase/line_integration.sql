alter table customers add column line_user_id text;

create or replace function public.link_line_user_by_phone(p_phone text, p_line_user_id text)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
begin
  update customers set line_user_id = p_line_user_id where phone = p_phone;
  return found;
end;
$$;

grant execute on function public.link_line_user_by_phone(text, text) to anon;
