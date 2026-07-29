import Link from "next/link";

const cards = [
  { href: "/customers", title: "客戶資料", desc: "新增與查詢客戶基本資料" },
  { href: "/services", title: "服務項目", desc: "管理剪髮、染髮等服務與價格" },
  { href: "/book", title: "線上預約", desc: "客人選服務、選時段送出預約" },
  { href: "/appointments", title: "預約管理", desc: "查看與確認所有預約" },
  { href: "/checkout", title: "開單結帳", desc: "到店開單、選服務、結帳" },
  { href: "/orders", title: "訂單紀錄", desc: "查看歷史消費紀錄" },
];

export default function Home() {
  return (
    <main className="max-w-5xl mx-auto p-8">
      <h1 className="text-3xl font-bold text-primary-dark mb-2">
        歡迎回來 👋
      </h1>
      <p className="text-foreground/70 mb-8">選擇一個功能開始</p>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        {cards.map((c) => (
          <Link
            key={c.href}
            href={c.href}
            className="block p-5 rounded-xl border border-primary-light bg-white hover:border-primary hover:shadow-md transition-all"
          >
            <h2 className="font-semibold text-lg mb-1">{c.title}</h2>
            <p className="text-sm text-foreground/60">{c.desc}</p>
          </Link>
        ))}
      </div>
    </main>
  );
}
