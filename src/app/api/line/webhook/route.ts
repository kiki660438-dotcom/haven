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
      const phone = normalizePhone(event.message.text ?? "");
      if (phone) {
        const { data: linked } = await supabase.rpc("link_line_user_by_phone", {
          p_phone: phone,
          p_line_user_id: userId,
        });
        await replyLineMessage(
          event.replyToken,
          linked
            ? "綁定成功！之後預約確認會透過 LINE 通知您 🎉"
            : "找不到這個手機號碼對應的會員資料，請確認號碼是否正確，或先到店家完成第一次預約登記。"
        );
      }
    }
  }

  return NextResponse.json({ ok: true });
}
