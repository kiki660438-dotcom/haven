"use client";

import { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { logout } from "../login/actions";
import {
  Home,
  LayoutDashboard,
  Users,
  Receipt,
  Scissors,
  CalendarCheck,
  CalendarPlus,
  ShoppingCart,
  ClipboardList,
  Ticket,
  Package,
  Wallet,
  TrendingUp,
  UserCog,
  Coins,
  LogOut,
  Menu,
  X,
  type LucideIcon,
} from "lucide-react";

const PUBLIC_PREFIXES = ["/book", "/my", "/login"];

const links: { href: string; label: string; icon: LucideIcon }[] = [
  { href: "/", label: "首頁", icon: Home },
  { href: "/dashboard", label: "營業總覽", icon: LayoutDashboard },
  { href: "/customers", label: "客戶資料", icon: Users },
  { href: "/members", label: "會員消費紀錄", icon: Receipt },
  { href: "/services", label: "服務項目", icon: Scissors },
  { href: "/appointments", label: "預約管理", icon: CalendarCheck },
  { href: "/book", label: "線上預約", icon: CalendarPlus },
  { href: "/checkout", label: "開單結帳", icon: ShoppingCart },
  { href: "/orders", label: "訂單紀錄", icon: ClipboardList },
  { href: "/vouchers", label: "商品券", icon: Ticket },
  { href: "/purchases", label: "進貨紀錄", icon: Package },
  { href: "/expenses", label: "固定支出", icon: Wallet },
  { href: "/revenue", label: "營業額總覽", icon: TrendingUp },
  { href: "/staff", label: "員工資料", icon: UserCog },
  { href: "/payroll", label: "業績薪資", icon: Coins },
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
          className="flex items-center gap-1.5 text-primary-dark text-sm px-3 py-1.5 rounded-full border border-primary-light"
        >
          {open ? <X size={16} /> : <Menu size={16} />}
          {open ? "關閉" : "選單"}
        </button>
      </div>

      <nav
        className={`max-w-5xl mx-auto flex-col sm:flex-row flex-wrap items-start sm:items-center gap-1 px-4 pb-3 sm:py-3 sm:flex ${
          open ? "flex" : "hidden"
        }`}
      >
        <span className="hidden sm:inline font-bold text-primary-dark mr-4">Haven 美髮管理</span>
        {links.map((link) => {
          const Icon = link.icon;
          return (
            <Link
              key={link.href}
              href={link.href}
              onClick={() => setOpen(false)}
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm text-foreground hover:bg-primary-light transition-colors"
            >
              <Icon size={16} className="text-primary-dark" strokeWidth={2} />
              {link.label}
            </Link>
          );
        })}
        <form action={logout} className="sm:ml-auto">
          <button className="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm text-red-500 hover:bg-red-50 transition-colors">
            <LogOut size={16} strokeWidth={2} />
            登出
          </button>
        </form>
      </nav>
    </header>
  );
}
