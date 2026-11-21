-- 合併重複的客人：「佳郁」（用 LINE 登入預約頁時自動建立、沒有電話）→ 併入「曾佳郁」（0972718380，神美匯入、有商品券和消費紀錄）
-- 把 LINE 綁定、預約、訂單、商品券、配方紀錄全部移到「曾佳郁」，再刪掉「佳郁」這筆。
-- 保護：兩邊都要剛好對到 1 筆客人，否則整段取消、什麼都不改。重複執行也安全（第二次會因為找不到「佳郁」而取消）。
do $do$
declare
  v_keep uuid;
  v_dup uuid;
  v_line text;
  n int;
begin
  select count(*) into n from customers where phone = '0972718380';
  if n <> 1 then raise exception '電話 0972718380 對到 % 位客人，應該剛好 1 位，已取消，沒有任何資料被修改。', n; end if;
  select id into v_keep from customers where phone = '0972718380';

  select count(*) into n from customers
    where name = '佳郁' and (phone is null or phone = '') and line_user_id is not null and id <> v_keep;
  if n <> 1 then raise exception '名字是「佳郁」、沒有電話、有綁 LINE 的客人有 % 位，應該剛好 1 位，已取消，沒有任何資料被修改。', n; end if;
  select id, line_user_id into v_dup, v_line from customers
    where name = '佳郁' and (phone is null or phone = '') and line_user_id is not null and id <> v_keep;

  update appointments set customer_id = v_keep where customer_id = v_dup;
  update orders set customer_id = v_keep where customer_id = v_dup;
  update vouchers set customer_id = v_keep where customer_id = v_dup;
  update customer_records set customer_id = v_keep where customer_id = v_dup;

  -- LINE 綁定移過去（先清掉舊的那筆，避免同一個 LINE 帳號同時綁兩個人）
  update customers set line_user_id = null where id = v_dup;
  update customers k set
    line_user_id = v_line,
    birthday = coalesce(k.birthday, d.birthday),
    gender = coalesce(k.gender, d.gender)
  from customers d
  where k.id = v_keep and d.id = v_dup;

  delete from customers where id = v_dup;
end $do$;

-- 確認結果：應該只剩一筆，名字是曾佳郁、有電話、有 LINE
select name, phone, line_user_id is not null as 已綁定LINE from customers where phone = '0972718380' or name = '佳郁';
