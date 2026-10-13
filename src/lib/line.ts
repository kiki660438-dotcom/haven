import { supabase } from "@/lib/supabase";

const LINE_API = "https://api.line.me/v2/bot/message";

export async function pushLineMessage(lineUserId: string, text: string) {
  const res = await fetch(`${LINE_API}/push`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${process.env.LINE_CHANNEL_ACCESS_TOKEN}`,
    },
    body: JSON.stringify({
      to: lineUserId,
      messages: [{ type: "text", text }],
    }),
  });
  // LINE 推播失敗時（例如對方沒有加官方帳號好友）API 會回錯誤，但這裡之前完全沒檢查回應，
  // 出問題時根本查不出來是真的推播失敗還是沒有觸發——先記錄下來方便之後對照 log
  if (!res.ok) {
    console.error("pushLineMessage failed", res.status, await res.text().catch(() => ""));
  }
}

// 傳訊息給店主（在 LINE 傳「綁定管理員」的那個帳號）；還沒綁定就什麼都不做
export async function notifyOwner(text: string) {
  const { data: setting } = await supabase
    .from("app_settings")
    .select("value")
    .eq("key", "owner_line_user_id")
    .maybeSingle();
  if (!setting?.value) return;
  await pushLineMessage(setting.value, text);
}

export async function replyLineMessage(replyToken: string, text: string) {
  const res = await fetch(`${LINE_API}/reply`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${process.env.LINE_CHANNEL_ACCESS_TOKEN}`,
    },
    body: JSON.stringify({
      replyToken,
      messages: [{ type: "text", text }],
    }),
  });
  if (!res.ok) {
    console.error("replyLineMessage failed", res.status, await res.text().catch(() => ""));
  }
}
