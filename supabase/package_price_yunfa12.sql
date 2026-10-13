-- 「蘊髮再生療程12堂」結帳售價改為 51800（原 30000）。
-- 只影響之後新開單賣出的商品券，已經賣出的商品券金額不會改。
update services set price = 51800 where name = '蘊髮再生療程12堂';

select name, price, total_sessions from services where name = '蘊髮再生療程12堂';
