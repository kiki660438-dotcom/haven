-- 「蘊髮再生（36,000起）」改名為「蘊髮再生全效療程」，價格改為 $51800
update services set name = '蘊髮再生全效療程', price = 51800
where name = '蘊髮再生（36,000起）';

-- 10 月預約匯入時，黃玉瑄(10/13 17:30)跟李孟容(10/17 14:30)的「蘊髮再生療程」(神美原始資料沒寫12堂)
-- 當時先暫用「蘊髮再生療程12堂」方案代替，現在確認是指「蘊髮再生全效療程」(單次版本)，改回正確項目
-- 若還沒執行過 october_appointments_import.sql，這段不會有任何影響（找不到資料，正常）
update appointments
set service_id = '7e5aad3f-430f-4cf7-87b4-9f443193e799'
where service_id = '31dea312-e081-4912-b2d4-db06c452c801'
  and start_time in ('2026-10-13T17:30:00+08:00', '2026-10-17T14:30:00+08:00');

update appointment_services
set service_id = '7e5aad3f-430f-4cf7-87b4-9f443193e799'
where service_id = '31dea312-e081-4912-b2d4-db06c452c801'
  and appointment_id in (
    select id from appointments
    where start_time in ('2026-10-13T17:30:00+08:00', '2026-10-17T14:30:00+08:00')
  );
