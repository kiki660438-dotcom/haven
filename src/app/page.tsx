import Link from "next/link";

const cards = [
  { href: "/dashboard", title: "營業總覽", desc: "今日預約、開單數、營業額一目了然" },
  { href: "/customers", title: "客戶資料", desc: "新增與查詢客戶基本資料" },
  { href: "/members", title: "會員消費紀錄", desc: "查看每位會員的累計消費與明細" },
  { href: "/services", title: "服務項目", desc: "管理剪髮、染髮等服務與價格" },
  { href: "/book", title: "線上預約", desc: "客人選服務、選時段送出預約" },
  { href: "/appointments", title: "預約管理", desc: "查看與確認所有預約" },
  { href: "/checkout", title: "開單結帳", desc: "到店開單、選服務、結帳" },
  { href: "/orders", title: "訂單紀錄", desc: "查看歷史消費紀錄" },
  { href: "/vouchers", title: "商品券", desc: "查詢客戶的商品券堂數與狀態" },
  { href: "/purchases", title: "進貨紀錄", desc: "記錄商品進貨與庫存" },
  { href: "/expenses", title: "固定支出", desc: "房租、水電、稅金等固定支出紀錄" },
  { href: "/revenue", title: "營業額總覽", desc: "營業額統計與服務項目排行" },
  { href: "/staff", title: "員工資料", desc: "管理員工名單與抽成%數" },
  { href: "/payroll", title: "業績薪資", desc: "依業績試算每位員工的抽成薪資" },
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
