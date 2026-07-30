import { NextResponse } from "next/server";
import { signLineIdentity } from "@/lib/line";

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
  const lineToken = signLineIdentity(userId, displayName);

  const redirectUrl = new URL(`${origin}${decodeURIComponent(returnTo)}`);
  redirectUrl.searchParams.set("line_token", lineToken);

  const response = NextResponse.redirect(redirectUrl.toString());
  response.cookies.delete("line_login_state");
  response.cookies.delete("line_login_return_to");
  return response;
}
