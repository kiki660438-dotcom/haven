import crypto from "crypto";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const returnTo = searchParams.get("returnTo") ?? "/book";

  const state = crypto.randomBytes(16).toString("hex");

  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL ?? origin}/api/line/login/callback`;

  const authorizeUrl = new URL("https://access.line.me/oauth2/v2.1/authorize");
  authorizeUrl.searchParams.set("response_type", "code");
  authorizeUrl.searchParams.set("client_id", process.env.LINE_LOGIN_CHANNEL_ID!);
  authorizeUrl.searchParams.set("redirect_uri", redirectUri);
  authorizeUrl.searchParams.set("state", state);
  authorizeUrl.searchParams.set("scope", "profile");

  const response = NextResponse.redirect(authorizeUrl.toString());
  response.cookies.set("line_login_state", state, {
    httpOnly: true,
    secure: true,
    maxAge: 600,
    path: "/",
  });
  response.cookies.set("line_login_return_to", returnTo, {
    httpOnly: true,
    secure: true,
    maxAge: 600,
    path: "/",
  });
  return response;
}
