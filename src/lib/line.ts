import crypto from "crypto";

const LINE_API = "https://api.line.me/v2/bot/message";

export function signLineIdentity(userId: string, displayName: string) {
  const payload = Buffer.from(JSON.stringify({ userId, displayName })).toString("base64url");
  const signature = crypto
    .createHmac("sha256", process.env.LINE_LOGIN_CHANNEL_SECRET!)
    .update(payload)
    .digest("base64url");
  return `${payload}.${signature}`;
}

export function verifyLineIdentity(
  token: string
): { userId: string; displayName: string } | null {
  const [payload, signature] = token.split(".");
  if (!payload || !signature) return null;

  const expected = crypto
    .createHmac("sha256", process.env.LINE_LOGIN_CHANNEL_SECRET!)
    .update(payload)
    .digest("base64url");

  if (expected !== signature) return null;

  try {
    return JSON.parse(Buffer.from(payload, "base64url").toString());
  } catch {
    return null;
  }
}

export async function pushLineMessage(lineUserId: string, text: string) {
  await fetch(`${LINE_API}/push`, {
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
}

export async function replyLineMessage(replyToken: string, text: string) {
  await fetch(`${LINE_API}/reply`, {
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
}
