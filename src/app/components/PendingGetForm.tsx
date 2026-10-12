"use client";

import { useEffect, useState } from "react";

// 用 GET 查詢的表單會整頁重新載入，伺服器回應慢的時候畫面不會有任何變化，
// 客人會以為沒按到而重複點擊，所以按下去就先把按鈕換成「查詢中…」
export default function PendingGetForm({
  action,
  className,
  label,
  pendingLabel,
  children,
}: {
  action: string;
  className?: string;
  label: string;
  pendingLabel: string;
  children: React.ReactNode;
}) {
  const [pending, setPending] = useState(false);

  useEffect(() => {
    const reset = () => setPending(false);
    window.addEventListener("pageshow", reset);
    return () => window.removeEventListener("pageshow", reset);
  }, []);

  return (
    <form method="GET" action={action} className={className} onSubmit={() => setPending(true)}>
      {children}
      <button
        type="submit"
        disabled={pending}
        className="bg-primary-dark text-white rounded-lg px-4 py-3 hover:bg-primary transition-colors touch-manipulation active:opacity-80 disabled:opacity-60"
      >
        {pending ? pendingLabel : label}
      </button>
    </form>
  );
}
