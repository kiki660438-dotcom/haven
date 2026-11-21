import crypto from "crypto";

export const CUSTOMER_COOKIE = "haven_customer";
export const CUSTOMER_COOKIE_MAX_AGE = 60 * 60 * 24 * 365; // 1 年

export function signCustomerToken(customerId: string, name: string) {
  const payload = Buffer.from(JSON.stringify({ customerId, name })).toString("base64url");
  const signature = crypto
    .createHmac("sha256", process.env.LINE_LOGIN_CHANNEL_SECRET!)
    .update(payload)
    .digest("base64url");
  return `${payload}.${signature}`;
}

export function verifyCustomerToken(
  token: string | undefined | null
): { customerId: string; name: string } | null {
  if (!token) return null;
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

// 第一次用 LINE 登入、還找不到對應客人時，先把 LINE 帳號暫存在這個簽章 cookie，
// 讓客人輸入電話連到原本的會員資料，避免同一個人變成兩筆（一筆有消費紀錄、一筆只有 LINE）
export const LINE_PENDING_COOKIE = "haven_line_pending";
export const LINE_PENDING_MAX_AGE = 60 * 30; // 30 分鐘

export function signLinePending(userId: string, displayName: string, returnTo: string) {
  const payload = Buffer.from(JSON.stringify({ userId, displayName, returnTo })).toString("base64url");
  const signature = crypto
    .createHmac("sha256", process.env.LINE_LOGIN_CHANNEL_SECRET!)
    .update(`line-pending.${payload}`)
    .digest("base64url");
  return `${payload}.${signature}`;
}

export function verifyLinePending(
  token: string | undefined | null
): { userId: string; displayName: string; returnTo: string } | null {
  if (!token) return null;
  const [payload, signature] = token.split(".");
  if (!payload || !signature) return null;
  const expected = crypto
    .createHmac("sha256", process.env.LINE_LOGIN_CHANNEL_SECRET!)
    .update(`line-pending.${payload}`)
    .digest("base64url");
  if (expected !== signature) return null;
  try {
    return JSON.parse(Buffer.from(payload, "base64url").toString());
  } catch {
    return null;
  }
}
