-- 找出並合併「用 LINE 登入自動建立、沒有電話」的重複客人，併到原本有電話（神美匯入、有消費紀錄）的那一筆。
--
-- 怎麼判斷是重複的：
--   重複的那筆：沒有電話、有綁 LINE、沒有任何付款訂單、沒有商品券
--   原本的那筆：有電話，而且名字跟 LINE 名稱互相包含（例如「佳郁」⊂「曾佳郁」），
--              還沒綁 LINE 或綁的是同一個 LINE
--   只有「一對一」的才會合併：對到 0 位、好幾位，或好幾個 LINE 對到同一位客人的都不動，
--   預覽會列出來，讓你在會員頁用「合併重複的客人」手動處理。
--
-- 使用方式：分兩次執行。
--   第 1 步：只選取並執行「第 1 步：預覽」那一段，看清單對不對（這一步不會修改任何資料）。
--   第 2 步：確認沒問題，再選取並執行「第 2 步：合併」那一段。

-- ============ 第 1 步：預覽（不會修改資料） ============
with dup as (
  select c.id, trim(c.name) as name, c.line_user_id
  from customers c
  where (c.phone is null or c.phone = '')
    and c.line_user_id is not null
    and length(trim(c.name)) >= 2
    and not exists (select 1 from orders o where o.customer_id = c.id and o.status = 'paid')
    and not exists (select 1 from vouchers v where v.customer_id = c.id)
),
candidates as (
  select d.id as dup_id, d.name as dup_name, k.id as keep_id, k.name as keep_name, k.phone as keep_phone
  from dup d
  join customers k
    on k.id <> d.id
   and k.phone is not null and k.phone <> ''
   and length(trim(k.name)) >= 2
   and (position(d.name in k.name) > 0 or position(trim(k.name) in d.name) > 0)
   and (k.line_user_id is null or k.line_user_id = d.line_user_id)
),
counted as (
  select *,
    count(*) over (partition by dup_id) as n,
    count(*) over (partition by keep_id) as n_keep
  from candidates
)
select
  case
    when n > 1 then '對到多位，不會動'
    when n_keep > 1 then '好幾個 LINE 對到同一位，不會動'
    else '會合併'
  end as 結果,
  dup_name as LINE建立的名字,
  keep_name as 原本的客人,
  keep_phone as 電話
from counted
union all
select '找不到對應，不會動', d.name, null, null
from dup d
where not exists (select 1 from candidates c where c.dup_id = d.id)
order by 1, 2;


-- ============ 第 2 步：合併（確認預覽沒問題才執行） ============
do $do$
declare
  r record;
  merged int := 0;
begin
  for r in
    with dup as (
      select c.id, trim(c.name) as name, c.line_user_id
      from customers c
      where (c.phone is null or c.phone = '')
        and c.line_user_id is not null
        and length(trim(c.name)) >= 2
        and not exists (select 1 from orders o where o.customer_id = c.id and o.status = 'paid')
        and not exists (select 1 from vouchers v where v.customer_id = c.id)
    ),
    candidates as (
      select d.id as dup_id, d.line_user_id, k.id as keep_id
      from dup d
      join customers k
        on k.id <> d.id
       and k.phone is not null and k.phone <> ''
       and length(trim(k.name)) >= 2
       and (position(d.name in k.name) > 0 or position(trim(k.name) in d.name) > 0)
       and (k.line_user_id is null or k.line_user_id = d.line_user_id)
    )
    , counted as (
      select *,
        count(*) over (partition by dup_id) as n,
        count(*) over (partition by keep_id) as n_keep
      from candidates
    )
    select dup_id, keep_id, line_user_id
    from counted
    where n = 1 and n_keep = 1
  loop
    -- 同一位客人被兩個 LINE 帳號對到時，第二個不要蓋掉第一個已經綁好的 LINE
    if exists (
      select 1 from customers
      where id = r.keep_id and line_user_id is not null and line_user_id <> r.line_user_id
    ) then
      raise notice '略過：%（原本的客人已經綁了別的 LINE）', r.dup_id;
      continue;
    end if;

    update appointments set customer_id = r.keep_id where customer_id = r.dup_id;
    update orders set customer_id = r.keep_id where customer_id = r.dup_id;
    update vouchers set customer_id = r.keep_id where customer_id = r.dup_id;
    update customer_records set customer_id = r.keep_id where customer_id = r.dup_id;

    update customers set line_user_id = null where id = r.dup_id;
    update customers k set
      line_user_id = r.line_user_id,
      birthday = coalesce(k.birthday, d.birthday),
      gender = coalesce(k.gender, d.gender),
      email = coalesce(k.email, d.email)
    from customers d
    where k.id = r.keep_id and d.id = r.dup_id;

    delete from customers where id = r.dup_id;
    merged := merged + 1;
  end loop;

  raise notice '已合併 % 位客人', merged;
end $do$;
