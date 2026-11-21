-- 復原一次「合併客人」：照 customer_merge_log 的紀錄，把被刪掉的客人加回來，
-- 當時搬過去的預約、訂單、商品券、配方紀錄移回去，LINE 綁定、生日、性別、Email、備註也還原。
--
-- 使用方式：
--   1. 先執行下面「找紀錄」那一段，找到要復原的那一筆，複製它的 id。
--   2. 把「復原」那一段裡的 '貼上紀錄的 id' 換成剛剛複製的 id，再執行。
-- 注意：合併之後才新增到留下那筆客人的資料（例如新的訂單）不會被移走。

-- ============ 找紀錄 ============
select id, merged_at, removed_customer->>'name' as 被合併的客人, kept_before->>'name' as 留下的客人,
  jsonb_array_length(moved->'appointments') as 預約, jsonb_array_length(moved->'orders') as 訂單,
  jsonb_array_length(moved->'vouchers') as 商品券, undone_at as 已復原時間
from customer_merge_log
order by merged_at desc;


-- ============ 復原 ============
do $do$
declare
  v_log customer_merge_log%rowtype;
  v_removed uuid;
begin
  select * into v_log from customer_merge_log where id = '貼上紀錄的 id';
  if not found then raise exception '找不到這筆合併紀錄，沒有任何資料被修改。'; end if;
  if v_log.undone_at is not null then raise exception '這筆合併已經復原過了，沒有任何資料被修改。'; end if;

  v_removed := (v_log.removed_customer->>'id')::uuid;
  if exists (select 1 from customers where id = v_removed) then
    raise exception '被合併的客人已經存在，不需要復原，沒有任何資料被修改。';
  end if;

  -- 留下那筆先放開 LINE（如果原本是被合併那筆的），再把被刪的客人原封不動加回來
  update customers set line_user_id = v_log.kept_before->>'line_user_id'
    where id = v_log.kept_customer_id;
  insert into customers select * from jsonb_populate_record(null::customers, v_log.removed_customer);

  update customers set
    birthday = (v_log.kept_before->>'birthday')::date,
    gender = v_log.kept_before->>'gender',
    email = v_log.kept_before->>'email',
    note = v_log.kept_before->>'note'
  where id = v_log.kept_customer_id;

  update appointments set customer_id = v_removed
    where id in (select (jsonb_array_elements_text(v_log.moved->'appointments'))::uuid);
  update orders set customer_id = v_removed
    where id in (select (jsonb_array_elements_text(v_log.moved->'orders'))::uuid);
  update vouchers set customer_id = v_removed
    where id in (select (jsonb_array_elements_text(v_log.moved->'vouchers'))::uuid);
  update customer_records set customer_id = v_removed
    where id in (select (jsonb_array_elements_text(v_log.moved->'customer_records'))::uuid);

  update customer_merge_log set undone_at = now() where id = v_log.id;
  raise notice '已復原：「%」拆回來了', v_log.removed_customer->>'name';
end $do$;
