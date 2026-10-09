import crypto from "crypto";
import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";
import { replyLineMessage } from "@/lib/line";

type LineEvent = {
  type: string;
  replyToken?: string;
  source: { userId?: string };
  message?: { type: string; text?: string };
};

function isValidSignature(body: string, signature: string | null) {
  if (!signature) return false;
  const hash = crypto
    .createHmac("sha256", process.env.LINE_CHANNEL_SECRET!)
    .update(body)
    .digest("base64");
  return hash === signature;
}

function normalizePhone(text: string) {
  const digits = text.replace(/[^0-9]/g, "");
  return /^09\d{8}$/.test(digits) ? digits : null;
}

export async function POST(request: Request) {
  const body = await request.text();
  const signature = request.headers.get("x-line-signature");

  if (!isValidSignature(body, signature)) {
    return NextResponse.json({ error: "invalid signature" }, { status: 401 });
  }

  const { events } = JSON.parse(body) as { events: LineEvent[] };

  for (const event of events) {
    const userId = event.source.userId;
    if (!userId) continue;

    if (event.type === "follow" && event.replyToken) {
      await replyLineMessage(
        event.replyToken,
        "歡迎加入 Haven Hair 中途髮廊！\n請回覆您的手機號碼（例如 0912345678），我們會幫您綁定會員，之後預約狀態會透過這裡通知您。"
      );
    }

    if (event.type === "message" && event.message?.type === "text" && event.replyToken) {
      const text = event.message.text ?? "";

      if (text === "綁定管理員") {
        await supabase.rpc("set_owner_line_user_id", { p_line_user_id: userId });
        await replyLineMessage(event.replyToken, "已設定為管理員通知帳號，之後有新的線上預約會通知您 ✅");
        continue;
      }

      const phone = normalizePhone(text);
      if (phone) {
        const { data: linked } = await supabase.rpc("link_line_user_by_phone", {
          p_phone: phone,
          p_line_user_id: userId,
        });

        if (!linked) {
          // 這支電話號碼還不是 Haven 的客戶——與其回覆「找不到」讓客人卡住，
          // 直接幫他建立一筆新客戶資料並綁定，跟線上預約的電話驗證邏輯一致
          const profileRes = await fetch(`https://api.line.me/v2/bot/profile/${userId}`, {
            headers: { Authorization: `Bearer ${process.env.LINE_CHANNEL_ACCESS_TOKEN}` },
          });
          const displayName = profileRes.ok ? (await profileRes.json()).displayName : "LINE好友";
          await supabase.from("customers").insert({ name: displayName, phone, line_user_id: userId });
        }

        await replyLineMessage(event.replyToken, "綁定成功！之後預約確認會透過 LINE 通知您 🎉");
      }
    }
  }

  return NextResponse.json({ ok: true });
}
