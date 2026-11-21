import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";
import {
  CUSTOMER_COOKIE,
  CUSTOMER_COOKIE_MAX_AGE,
  LINE_PENDING_COOKIE,
  LINE_PENDING_MAX_AGE,
  signCustomerToken,
  signLinePending,
} from "@/lib/customer-identity";

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const state = searchParams.get("state");

  const cookieState = request.headers
    .get("cookie")
    ?.split("; ")
    .find((c) => c.startsWith("line_login_state="))
    ?.split("=")[1];
  const returnTo =
    request.headers
      .get("cookie")
      ?.split("; ")
      .find((c) => c.startsWith("line_login_return_to="))
      ?.split("=")[1] ?? "/book";

  if (!code || !state || state !== cookieState) {
    return NextResponse.redirect(`${origin}${decodeURIComponent(returnTo)}?error=line_login`);
  }

  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL ?? origin}/api/line/login/callback`;

  const tokenRes = await fetch("https://api.line.me/oauth2/v2.1/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "authorization_code",
      code,
      redirect_uri: redirectUri,
      client_id: process.env.LINE_LOGIN_CHANNEL_ID!,
      client_secret: process.env.LINE_LOGIN_CHANNEL_SECRET!,
    }),
  });

  if (!tokenRes.ok) {
    return NextResponse.redirect(`${origin}${decodeURIComponent(returnTo)}?error=line_login`);
  }

  const { access_token } = await tokenRes.json();

  const profileRes = await fetch("https://api.line.me/v2/profile", {
    headers: { Authorization: `Bearer ${access_token}` },
  });

  if (!profileRes.ok) {
    return NextResponse.redirect(`${origin}${decodeURIComponent(returnTo)}?error=line_login`);
  }

  const { userId, displayName } = await profileRes.json();

  const { data: existingId } = await supabase.rpc("find_customer_id_by_line_user_id", {
    p_line_user_id: userId,
  });

  // 這個 LINE 還沒連到任何客人：先不要直接建新客人（老客人會變成兩筆、看不到消費紀錄和商品券），
  // 改成請客人輸入電話，連到原本的會員資料；沒有台灣手機的再選「略過」建立新資料
  if (!existingId) {
    const pending = NextResponse.redirect(`${origin}/line-link`);
    pending.cookies.set(
      LINE_PENDING_COOKIE,
      signLinePending(userId, displayName, decodeURIComponent(returnTo)),
      { httpOnly: true, secure: true, sameSite: "lax", maxAge: LINE_PENDING_MAX_AGE, path: "/" }
    );
    pending.cookies.delete("line_login_state");
    pending.cookies.delete("line_login_return_to");
    return pending;
  }
  const customerId: string = existingId;

  const redirectUrl = new URL(`${origin}${decodeURIComponent(returnTo)}`);

  const response = NextResponse.redirect(redirectUrl.toString());
  response.cookies.set(CUSTOMER_COOKIE, signCustomerToken(customerId, displayName), {
    httpOnly: true,
    secure: true,
    sameSite: "lax",
    maxAge: CUSTOMER_COOKIE_MAX_AGE,
    path: "/",
  });
  response.cookies.delete("line_login_state");
  response.cookies.delete("line_login_return_to");
  return response;
}
