-- 商品券剩餘堂數校正：以神美 9/22 19:42 的「會員商品券剩餘紀錄」為準，再扣掉 9/22 之後（10/9～10/13）用掉的堂數，
-- 一次把每一張商品券設成「現在應該剩幾堂」。（資料庫原本是 7/30 舊紀錄的數字，不是 9/22 的。）
-- 這是「直接設定成正確的數字」，不是在原本的數字上再扣，所以重複執行結果一樣，不會越扣越少。
-- 必須在 E-voucher_purchases_import_202609_202610.sql 之後執行（蔡慧勤、黃玉瑄的商品券要先存在）。
-- 每一張都確認「剛好對到 1 張」，對不到或對到多張，整段取消、什麼都不改。
do $do$
declare
  n int;
begin
-- Kerri (10送3)植物草二合一短髮（2022-08-28 購買）9/22 剩 6 → 剩 6
update vouchers v set total_sessions = 13, remaining_sessions = 6, remaining_value = round(20000::numeric * 6 / 13), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0905396827' and v.service_name = '(10送3)植物草二合一短髮' and v.purchased_at = '2022-08-28';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(10送3)植物草二合一短髮」（0905396827，2022-08-28 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 張甄庭12819 (5送1)植物草三合一短髮（2023-02-03 購買）9/22 剩 3 → 剩 3
update vouchers v set total_sessions = 6, remaining_sessions = 3, remaining_value = round(11000::numeric * 3 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0905925833' and v.service_name = '(5送1)植物草三合一短髮' and v.purchased_at = '2023-02-03';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草三合一短髮」（0905925833，2023-02-03 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 陳韋如 (5送1)植物草三合一長髮（2024-08-26 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 6, remaining_sessions = 1, remaining_value = round(18500::numeric * 1 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0909240707' and v.service_name = '(5送1)植物草三合一長髮' and v.purchased_at = '2024-08-26';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草三合一長髮」（0909240707，2024-08-26 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- Amor Huang (5送1)植物草二合一短髮（2026-06-27 購買）9/22 剩 5，之後用 1 → 現在剩 4
update vouchers v set total_sessions = 6, remaining_sessions = 4, remaining_value = round(10000::numeric * 4 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0910033140' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2026-06-27';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0910033140，2026-06-27 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 王奕之 蘊活再生角質露(贈4堂)（2025-11-20 購買）9/22 剩 2 → 剩 2
update vouchers v set total_sessions = 4, remaining_sessions = 2, remaining_value = round(0::numeric * 2 / 4), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0910688896' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2025-11-20';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊活再生角質露(贈4堂)」（0910688896，2025-11-20 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 王奕之 蘊髮再生療程12堂（2025-11-20 購買）9/22 剩 8 → 剩 8
update vouchers v set total_sessions = 12, remaining_sessions = 8, remaining_value = round(30000::numeric * 8 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0910688896' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2025-11-20';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊髮再生療程12堂」（0910688896，2025-11-20 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 葉宣妤 蘊活再生角質露(贈4堂)（2025-06-05 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 4, remaining_sessions = 1, remaining_value = round(0::numeric * 1 / 4), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0912233152' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2025-06-05';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊活再生角質露(贈4堂)」（0912233152，2025-06-05 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃玉瑄 洗髮12堂（2026-10-13 購買）買完當天用 1 → 剩 11
update vouchers v set total_sessions = 12, remaining_sessions = 11, remaining_value = round(0::numeric * 11 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0912618908' and v.service_name = '洗髮12堂' and v.purchased_at = '2026-10-13';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「洗髮12堂」（0912618908，2026-10-13 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃玉瑄 蘊活再生角質露(贈4堂)（2026-10-13 購買）買完當天用 1 → 剩 3
update vouchers v set total_sessions = 4, remaining_sessions = 3, remaining_value = round(0::numeric * 3 / 4), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0912618908' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2026-10-13';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊活再生角質露(贈4堂)」（0912618908，2026-10-13 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃玉瑄 蘊髮再生療程12堂（2026-10-13 購買）買完當天用 1 → 剩 11
update vouchers v set total_sessions = 12, remaining_sessions = 11, remaining_value = round(51800::numeric * 11 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0912618908' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2026-10-13';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊髮再生療程12堂」（0912618908，2026-10-13 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 郭馥萱 (5送1)植物草二合一短髮（2026-02-04 購買）9/22 剩 3 → 剩 3
update vouchers v set total_sessions = 6, remaining_sessions = 3, remaining_value = round(10000::numeric * 3 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0917656957' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2026-02-04';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0917656957，2026-02-04 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 陳怡萍 (5送1)植物草三合一中髮（2025-12-01 購買）9/22 剩 3，之後用 1 → 現在剩 2
update vouchers v set total_sessions = 6, remaining_sessions = 2, remaining_value = round(16000::numeric * 2 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0919363431' and v.service_name = '(5送1)植物草三合一中髮' and v.purchased_at = '2025-12-01';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草三合一中髮」（0919363431，2025-12-01 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 李佩璟 (5送1)植物草二合一短髮（2022-12-12 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 6, remaining_sessions = 1, remaining_value = round(10000::numeric * 1 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0920930501' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2022-12-12';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0920930501，2022-12-12 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 伍紘葳 (3堂)植物草二合一短髮（2023-01-05 購買）9/22 剩 2 → 剩 2
update vouchers v set total_sessions = 3, remaining_sessions = 2, remaining_value = round(5700::numeric * 2 / 3), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0932145131' and v.service_name = '(3堂)植物草二合一短髮' and v.purchased_at = '2023-01-05';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(3堂)植物草二合一短髮」（0932145131，2023-01-05 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 彭佩雯 (5送1)植物草二合一短髮（2025-11-25 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 6, remaining_sessions = 1, remaining_value = round(10000::numeric * 1 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0932937523' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2025-11-25';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0932937523，2025-11-25 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 陳偉謙 (10送3)植物草二合一短髮（2022-09-28 購買）9/22 剩 9 → 剩 9
update vouchers v set total_sessions = 13, remaining_sessions = 9, remaining_value = round(20000::numeric * 9 / 13), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0936228937' and v.service_name = '(10送3)植物草二合一短髮' and v.purchased_at = '2022-09-28';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(10送3)植物草二合一短髮」（0936228937，2022-09-28 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 蘇婉瑛 蘊活再生角質露(贈4堂)（2025-10-10 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 4, remaining_sessions = 1, remaining_value = round(0::numeric * 1 / 4), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0939266341' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2025-10-10';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊活再生角質露(贈4堂)」（0939266341，2025-10-10 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃佩琪 蘊髮再生療程12堂（2025-06-05 購買）9/22 剩 2 → 剩 2
update vouchers v set total_sessions = 12, remaining_sessions = 2, remaining_value = round(30000::numeric * 2 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0960996336' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2025-06-05';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊髮再生療程12堂」（0960996336，2025-06-05 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 林儀柔 (5送1)植物草二合一短髮（2025-03-29 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 6, remaining_sessions = 1, remaining_value = round(10000::numeric * 1 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0963023278' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2025-03-29';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0963023278，2025-03-29 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 郭宛陵 (5送1)植物草二合一短髮（2022-08-23 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 6, remaining_sessions = 1, remaining_value = round(10000::numeric * 1 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0963358165' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2022-08-23';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0963358165，2022-08-23 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 倪家羚 (10送3)植物草二合一短髮（2023-02-13 購買）9/22 剩 9 → 剩 9
update vouchers v set total_sessions = 13, remaining_sessions = 9, remaining_value = round(20000::numeric * 9 / 13), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0963532123' and v.service_name = '(10送3)植物草二合一短髮' and v.purchased_at = '2023-02-13';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(10送3)植物草二合一短髮」（0963532123，2023-02-13 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 許欣怡 蘊活再生角質露(贈4堂)（2025-10-21 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 4, remaining_sessions = 1, remaining_value = round(0::numeric * 1 / 4), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0966895583' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2025-10-21';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊活再生角質露(贈4堂)」（0966895583，2025-10-21 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 簡子銜 (3堂)植物草二合一短髮（2023-01-19 購買）9/22 剩 2 → 剩 2
update vouchers v set total_sessions = 3, remaining_sessions = 2, remaining_value = round(5700::numeric * 2 / 3), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0970988813' and v.service_name = '(3堂)植物草二合一短髮' and v.purchased_at = '2023-01-19';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(3堂)植物草二合一短髮」（0970988813，2023-01-19 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 蔡慧勤 (10送3)植物草三合一中髮（2026-10-09 購買）買完當天用 1 → 剩 12
update vouchers v set total_sessions = 13, remaining_sessions = 12, remaining_value = round(32000::numeric * 12 / 13), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0972003410' and v.service_name = '(10送3)植物草三合一中髮' and v.purchased_at = '2026-10-09';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(10送3)植物草三合一中髮」（0972003410，2026-10-09 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 鄧雅云Jenny (5送1)植物草二合一短髮（2024-04-11 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 6, remaining_sessions = 1, remaining_value = round(10000::numeric * 1 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0972123863' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2024-04-11';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0972123863，2024-04-11 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 曾佳郁 (5送1)植物草三合一中髮（2026-02-21 購買）9/22 剩 2 → 剩 2
update vouchers v set total_sessions = 6, remaining_sessions = 2, remaining_value = round(16000::numeric * 2 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0972718380' and v.service_name = '(5送1)植物草三合一中髮' and v.purchased_at = '2026-02-21';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草三合一中髮」（0972718380，2026-02-21 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 李珊 (10送3)植物草三合一長髮（2026-07-19 購買）9/22 剩 10 → 剩 10
update vouchers v set total_sessions = 13, remaining_sessions = 10, remaining_value = round(37000::numeric * 10 / 13), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0972869831' and v.service_name = '(10送3)植物草三合一長髮' and v.purchased_at = '2026-07-19';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(10送3)植物草三合一長髮」（0972869831，2026-07-19 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 凍膜12堂（2025-10-08 購買）9/22 剩 1，之後用 1 → 現在剩 0
update vouchers v set total_sessions = 12, remaining_sessions = 0, remaining_value = round(6000::numeric * 0 / 12), status = 'used'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '凍膜12堂' and v.purchased_at = '2025-10-08';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「凍膜12堂」（0974358358，2025-10-08 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 凍膜12堂（2026-09-20 購買）9/22 剩 12 → 剩 12
update vouchers v set total_sessions = 12, remaining_sessions = 12, remaining_value = round(6000::numeric * 12 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '凍膜12堂' and v.purchased_at = '2026-09-20';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「凍膜12堂」（0974358358，2026-09-20 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 洗髮12堂（2025-10-08 購買）9/22 剩 1，之後用 1 → 現在剩 0
update vouchers v set total_sessions = 12, remaining_sessions = 0, remaining_value = round(4800::numeric * 0 / 12), status = 'used'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '洗髮12堂' and v.purchased_at = '2025-10-08';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「洗髮12堂」（0974358358，2025-10-08 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 洗髮12堂（2026-09-20 購買）9/22 剩 12 → 剩 12
update vouchers v set total_sessions = 12, remaining_sessions = 12, remaining_value = round(4800::numeric * 12 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '洗髮12堂' and v.purchased_at = '2026-09-20';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「洗髮12堂」（0974358358，2026-09-20 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 蘊活再生角質露(贈4堂)（2026-09-20 購買）9/22 剩 4 → 剩 4
update vouchers v set total_sessions = 4, remaining_sessions = 4, remaining_value = round(0::numeric * 4 / 4), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '蘊活再生角質露(贈4堂)' and v.purchased_at = '2026-09-20';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊活再生角質露(贈4堂)」（0974358358，2026-09-20 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 蘊髮再生療程12堂（2025-10-08 購買）9/22 剩 1，之後用 1 → 現在剩 0
update vouchers v set total_sessions = 12, remaining_sessions = 0, remaining_value = round(30000::numeric * 0 / 12), status = 'used'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2025-10-08';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊髮再生療程12堂」（0974358358，2025-10-08 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 黃沐薇 蘊髮再生療程12堂（2026-09-20 購買）9/22 剩 12 → 剩 12
update vouchers v set total_sessions = 12, remaining_sessions = 12, remaining_value = round(30000::numeric * 12 / 12), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0974358358' and v.service_name = '蘊髮再生療程12堂' and v.purchased_at = '2026-09-20';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「蘊髮再生療程12堂」（0974358358，2026-09-20 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 李念庭 (5送1)植物草二合一短髮（2026-07-19 購買）9/22 剩 3 → 剩 3
update vouchers v set total_sessions = 6, remaining_sessions = 3, remaining_value = round(10000::numeric * 3 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0975462530' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2026-07-19';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0975462530，2026-07-19 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 李孟容 (5送1)植物草二合一短髮（2026-05-30 購買）9/22 剩 5 → 剩 5
update vouchers v set total_sessions = 6, remaining_sessions = 5, remaining_value = round(10000::numeric * 5 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0982876935' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2026-05-30';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0982876935，2026-05-30 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 沈季樺 (10送3)植物草二合一短髮（2022-08-25 購買）9/22 剩 1 → 剩 1
update vouchers v set total_sessions = 13, remaining_sessions = 1, remaining_value = round(20000::numeric * 1 / 13), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0987590680' and v.service_name = '(10送3)植物草二合一短髮' and v.purchased_at = '2022-08-25';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(10送3)植物草二合一短髮」（0987590680，2022-08-25 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 鄭淳尹 (5送1)植物草二合一短髮（2022-12-28 購買）9/22 剩 5 → 剩 5
update vouchers v set total_sessions = 6, remaining_sessions = 5, remaining_value = round(10000::numeric * 5 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0988982349' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2022-12-28';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0988982349，2022-12-28 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

-- 陳怡安 (5送1)植物草二合一短髮（2022-06-25 購買）9/22 剩 5 → 剩 5
update vouchers v set total_sessions = 6, remaining_sessions = 5, remaining_value = round(13500::numeric * 5 / 6), status = 'active'
  from customers c where c.id = v.customer_id and c.phone = '0989660438' and v.service_name = '(5送1)植物草二合一短髮' and v.purchased_at = '2022-06-25';
  get diagnostics n = row_count;
  if n <> 1 then raise exception '「(5送1)植物草二合一短髮」（0989660438，2022-06-25 購買）對到 % 張商品券，應該剛好 1 張，已全部取消，沒有任何資料被修改。', n; end if;

end $do$;

-- 執行完請對照下面這張表（只列 9/22 之後有用掉堂數的那些）
select c.name as 客人, v.service_name as 商品券, v.remaining_sessions as 剩餘, v.total_sessions as 共, v.status as 狀態, v.purchased_at as 購買日
from vouchers v join customers c on c.id = v.customer_id
where (c.phone, v.service_name, v.purchased_at) in (('0910033140','(5送1)植物草二合一短髮','2026-06-27'),('0919363431','(5送1)植物草三合一中髮','2025-12-01'),('0974358358','蘊髮再生療程12堂','2025-10-08'),('0974358358','凍膜12堂','2025-10-08'),('0974358358','洗髮12堂','2025-10-08'),('0972003410','(10送3)植物草三合一中髮','2026-10-09'),('0912618908','蘊髮再生療程12堂','2026-10-13'),('0912618908','洗髮12堂','2026-10-13'),('0912618908','蘊活再生角質露(贈4堂)','2026-10-13'))
order by c.name, v.service_name, v.purchased_at;
