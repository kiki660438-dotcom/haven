-- 幫所有「中髮/特長髮/短髮/長髮」的服務名稱加上白話說明，只改名稱，價格不變
update services set name = replace(name, '-中髮', '-中髮（肩上）') where name like '%-中髮';
update services set name = replace(name, '-特長髮', '-特長髮（及腰）') where name like '%-特長髮';
update services set name = replace(name, '-短髮', '-短髮（男生短髮,耳上）') where name like '%-短髮';
update services set name = replace(name, '-長髮', '-長髮（及肩）') where name like '%-長髮';
