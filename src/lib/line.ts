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

// 推播有每月額度（免費方案 200 則），除了「確認／婉拒」之外的通知都要在「系統設定」手動打開才會送，預設是關的
export async function isNotificationOn(key: string) {
  const { data } = await supabase.from("app_settings").select("value").eq("key", key).maybeSingle();
  return data?.value === "on";
}

// 查客人的 LINE 暱稱（要對方是官方帳號的好友才查得到）；這個 API 不佔推播額度，結果快取一天
export async function getLineProfile(
  lineUserId: string
): Promise<{ displayName: string; pictureUrl: string | null } | null> {
  try {
    const res = await fetch(`https://api.line.me/v2/bot/profile/${lineUserId}`, {
      headers: { Authorization: `Bearer ${process.env.LINE_CHANNEL_ACCESS_TOKEN}` },
      next: { revalidate: 86400 },
    });
    if (!res.ok) return null;
    const data = await res.json();
    return data.displayName ? { displayName: data.displayName, pictureUrl: data.pictureUrl ?? null } : null;
  } catch {
    return null;
  }
}

export async function getLineDisplayName(lineUserId: string): Promise<string | null> {
  return (await getLineProfile(lineUserId))?.displayName ?? null;
}

// 官方帳號在「LINE 後台聊天室」網址裡的代號（chat.line.biz/<這個代號>/chat/<客人的 userId>），是固定的，不是機密
const LINE_OA_CHAT_ID = "U5cc0e3b2b46f31e1aa7df3e925504441";

export function lineChatUrl(customerLineUserId: string) {
  return `https://chat.line.biz/${LINE_OA_CHAT_ID}/chat/${customerLineUserId}`;
}

// 這個月的推播額度與已使用量（查不到時回傳 null）
export async function getPushQuota(): Promise<{ limit: number | null; used: number } | null> {
  try {
    const headers = { Authorization: `Bearer ${process.env.LINE_CHANNEL_ACCESS_TOKEN}` };
    const [quotaRes, usedRes] = await Promise.all([
      fetch(`${LINE_API}/quota`, { headers, cache: "no-store" }),
      fetch(`${LINE_API}/quota/consumption`, { headers, cache: "no-store" }),
    ]);
    if (!quotaRes.ok || !usedRes.ok) return null;
    const quota = await quotaRes.json();
    const used = await usedRes.json();
    return { limit: quota.type === "limited" ? quota.value : null, used: used.totalUsage };
  } catch {
    return null;
  }
}

// 傳訊息給店主（在 LINE 傳「綁定管理員」的那個帳號）；還沒綁定就什麼都不做。
// 帶 settingKey 時，對應的通知開關沒打開就不送
export async function notifyOwner(text: string, settingKey?: string) {
  if (settingKey && !(await isNotificationOn(settingKey))) return;
  const { data: setting } = await supabase
    .from("app_settings")
    .select("value")
    .eq("key", "owner_line_user_id")
    .maybeSingle();
  if (!setting?.value) return;
  await pushLineMessage(setting.value, text);
}

type LineMessage =
  | { type: "text"; text: string }
  | { type: "image"; originalContentUrl: string; previewImageUrl: string };

export async function replyLineMessage(replyToken: string, message: string | LineMessage[]) {
  const messages = typeof message === "string" ? [{ type: "text" as const, text: message }] : message;
  const res = await fetch(`${LINE_API}/reply`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${process.env.LINE_CHANNEL_ACCESS_TOKEN}`,
    },
    body: JSON.stringify({ replyToken, messages }),
  });
  if (!res.ok) {
    console.error("replyLineMessage failed", res.status, await res.text().catch(() => ""));
  }
}
