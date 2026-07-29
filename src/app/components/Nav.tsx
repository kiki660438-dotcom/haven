import Link from "next/link";

const links = [
  { href: "/", label: "首頁" },
  { href: "/customers", label: "客戶資料" },
  { href: "/services", label: "服務項目" },
  { href: "/appointments", label: "預約管理" },
  { href: "/book", label: "線上預約" },
  { href: "/checkout", label: "開單結帳" },
  { href: "/orders", label: "訂單紀錄" },
];

export default function Nav() {
  return (
    <header className="bg-white border-b border-primary-light">
      <nav className="max-w-5xl mx-auto flex flex-wrap items-center gap-1 px-4 py-3">
        <span className="font-bold text-primary-dark mr-4">Haven 美髮管理</span>
        {links.map((link) => (
          <Link
            key={link.href}
            href={link.href}
            className="px-3 py-1.5 rounded-full text-sm text-foreground hover:bg-primary-light transition-colors"
          >
            {link.label}
          </Link>
        ))}
      </nav>
    </header>
  );
}
