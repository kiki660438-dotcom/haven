import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";
import {
  CUSTOMER_COOKIE,
  CUSTOMER_COOKIE_MAX_AGE,
  signCustomerToken,
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

  let customerId: string;
  if (existingId) {
    customerId = existingId;
  } else {
    const { error } = await supabase.from("customers").insert({
      name: displayName,
      line_user_id: userId,
    });
    if (error) {
      return NextResponse.redirect(`${origin}${decodeURIComponent(returnTo)}?error=line_login`);
    }
    const { data: newId } = await supabase.rpc("find_customer_id_by_line_user_id", {
      p_line_user_id: userId,
    });
    if (!newId) {
      return NextResponse.redirect(`${origin}${decodeURIComponent(returnTo)}?error=line_login`);
    }
    customerId = newId;
  }

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
