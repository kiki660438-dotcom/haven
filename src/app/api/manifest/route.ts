import { NextResponse } from "next/server";

// 客人從預約頁或會員頁「加入主畫面」時，點開後要回到那一頁，而不是後台首頁（會要求登入）。
// 只接受固定的兩個值，不會把任意網址放進設定檔
const APPS = {
  book: { name: "Haven Hair 線上預約", short_name: "Haven Hair", start_url: "/book" },
  my: { name: "Haven Hair 會員中心", short_name: "Haven 會員", start_url: "/my" },
} as const;

export function GET(request: Request) {
  const key = new URL(request.url).searchParams.get("start");
  const app = key === "my" ? APPS.my : APPS.book;

  return NextResponse.json(
    {
      ...app,
      description: "Haven Hair 中途髮廊",
      scope: "/",
      display: "standalone",
      background_color: "#ffffff",
      theme_color: "#ffffff",
      icons: [
        { src: "/icons/icon-192.png", sizes: "192x192", type: "image/png" },
        { src: "/icons/icon-512.png", sizes: "512x512", type: "image/png" },
        { src: "/icons/icon-maskable-512.png", sizes: "512x512", type: "image/png", purpose: "maskable" },
      ],
    },
    { headers: { "Content-Type": "application/manifest+json", "Cache-Control": "public, max-age=3600" } }
  );
}
