import { createClient } from "@supabase/supabase-js";

// 只能在伺服器端使用（server component / server action）。這把金鑰會略過資料庫的權限限制，
// 絕對不能被 "use client" 的元件 import，也不能加上 NEXT_PUBLIC_ 前綴。
// 使用前一定要先自己驗證過身份（例如用簽章過的客人 cookie），再用驗證後的 id 去查資料。
export function getAdminClient() {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) return null;
  return createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}
