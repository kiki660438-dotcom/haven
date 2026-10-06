-- LINE webhook 是用 anon 連線呼叫（沒有登入狀態），而 app_settings 只開放 authenticated 寫入，
-- 所以「綁定管理員」這個動作要透過 security definer function 才能寫進資料庫
create or replace function public.set_owner_line_user_id(p_line_user_id text)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into app_settings (key, value) values ('owner_line_user_id', p_line_user_id)
  on conflict (key) do update set value = excluded.value;
end;
$$;

grant execute on function public.set_owner_line_user_id(text) to anon;
