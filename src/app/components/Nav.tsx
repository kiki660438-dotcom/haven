"use client";

import { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { logout } from "../login/actions";

const PUBLIC_PREFIXES = ["/book", "/my", "/login"];

const links = [
  { href: "/", label: "首頁" },
  { href: "/dashboard", label: "營業總覽" },
  { href: "/customers", label: "客戶資料" },
  { href: "/members", label: "會員消費紀錄" },
  { href: "/services", label: "服務項目" },
  { href: "/appointments", label: "預約管理" },
  { href: "/book", label: "線上預約" },
  { href: "/checkout", label: "開單結帳" },
  { href: "/orders", label: "訂單紀錄" },
  { href: "/vouchers", label: "商品券" },
  { href: "/purchases", label: "進貨紀錄" },
  { href: "/expenses", label: "固定支出" },
  { href: "/revenue", label: "營業額總覽" },
  { href: "/staff", label: "員工資料" },
  { href: "/payroll", label: "業績薪資" },
];

export default function Nav() {
  const [open, setOpen] = useState(false);
  const pathname = usePathname();
  const isPublic = PUBLIC_PREFIXES.some((p) => pathname === p || pathname.startsWith(p + "/"));

  if (isPublic) {
    return (
      <header className="bg-white border-b border-primary-light">
        <div className="max-w-5xl mx-auto px-4 py-3">
          <span className="font-bold text-primary-dark">Haven 美髮管理</span>
        </div>
      </header>
    );
  }

  return (
    <header className="bg-white border-b border-primary-light">
      <div className="max-w-5xl mx-auto flex items-center justify-between px-4 py-3 sm:hidden">
        <span className="font-bold text-primary-dark">Haven 美髮管理</span>
        <button
          onClick={() => setOpen((v) => !v)}
          className="text-primary-dark text-sm px-3 py-1.5 rounded-full border border-primary-light"
        >
          {open ? "關閉 ✕" : "選單 ☰"}
        </button>
      </div>

      <nav
        className={`max-w-5xl mx-auto flex-col sm:flex-row flex-wrap items-start sm:items-center gap-1 px-4 pb-3 sm:py-3 sm:flex ${
          open ? "flex" : "hidden"
        }`}
      >
        <span className="hidden sm:inline font-bold text-primary-dark mr-4">Haven 美髮管理</span>
        {links.map((link) => (
          <Link
            key={link.href}
            href={link.href}
            onClick={() => setOpen(false)}
            className="px-3 py-1.5 rounded-full text-sm text-foreground hover:bg-primary-light transition-colors"
          >
            {link.label}
          </Link>
        ))}
        <form action={logout} className="sm:ml-auto">
          <button className="px-3 py-1.5 rounded-full text-sm text-red-500 hover:bg-red-50 transition-colors">
            登出
          </button>
        </form>
      </nav>
    </header>
  );
}
