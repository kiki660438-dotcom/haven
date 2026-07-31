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
