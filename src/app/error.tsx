"use client";

import { useEffect } from "react";
import Link from "next/link";

// 取代 Next.js 內建的英文錯誤頁（This page couldn't load）。
// 「重新整理」用整頁重新載入，而不是只重抓這一頁：iPad 加到主畫面的 App 常常一直開著，
// 網站更新之後舊頁面送出的表單會對不上新版本，整頁重新載入才會拿到新版本。
export default function Error({
  error,
}: {
  error: Error & { digest?: string };
  unstable_retry: () => void;
}) {
  useEffect(() => {
    console.error(error);
  }, [error]);

  return (
    <main className="max-w-xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-3">這一頁暫時出錯了</h1>
      <p className="text-foreground/70 mb-2">
        請先按「重新整理」再試一次。如果一直出現，可能是登入過期，請按「重新登入」。
      </p>
      {error.digest && (
        <p className="text-xs text-foreground/40 mb-6">錯誤代碼：{error.digest}</p>
      )}
      <div className="flex gap-3">
        <button
          type="button"
          onClick={() => window.location.reload()}
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors touch-manipulation"
        >
          重新整理
        </button>
        <Link
          href="/login"
          className="border border-primary-light rounded-lg px-4 py-2 hover:bg-primary-light transition-colors"
        >
          重新登入
        </Link>
        <Link href="/" className="px-4 py-2 underline text-primary-dark">
          回首頁
        </Link>
      </div>
    </main>
  );
}
