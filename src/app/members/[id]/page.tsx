import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { getLineProfile } from "@/lib/line";
import { Phone, MessageSquare, CalendarPlus, ShoppingCart, ChevronLeft, Pencil } from "lucide-react";

const TABS = [
  { key: "info", label: "會員資料" },
  { key: "orders", label: "消費紀錄" },
  { key: "vouchers", label: "商品券" },
  { key: "appointments", label: "預約紀錄" },
];

const apptStatus: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  completed: "已完成",
  cancelled: "已取消",
};

const genderLabel: Record<string, string> = { male: "男", female: "女", other: "不透露" };

function fmtDate(iso: string) {
  return new Intl.DateTimeFormat("zh-TW", {
    timeZone: "Asia/Taipei",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date(iso));
}

function fmtDateTime(iso: string) {
  return new Intl.DateTimeFormat("zh-TW", {
    timeZone: "Asia/Taipei",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    hourCycle: "h23",
  }).format(new Date(iso));
}

function Field({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div>
      <p className="text-xs text-foreground/50">{label}</p>
      <p className="font-medium break-words">{value || "－"}</p>
    </div>
  );
}

export default async function MemberDetailPage({
  params,
  searchParams,
}: {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ tab?: string }>;
}) {
  const { id } = await params;
  const { tab } = await searchParams;
  const activeTab = TABS.some((t) => t.key === tab) ? (tab as string) : "info";

  const supabase = await createClient();
  const [{ data: customer }, { data: orders }, { data: vouchers }, { data: appointments }] =
    await Promise.all([
      supabase.from("customers").select("*").eq("id", id).maybeSingle(),
      supabase
        .from("orders")
        .select("id, total, status, payment_method, created_at, order_items(service_name, price, quantity)")
        .eq("customer_id", id)
        .order("created_at", { ascending: false })
        .limit(300),
      supabase
        .from("vouchers")
        .select("id, service_name, total_sessions, remaining_sessions, purchased_at, status")
        .eq("customer_id", id)
        .order("purchased_at", { ascending: false }),
      supabase
        .from("appointments")
        .select("id, start_time, status, note, party_size, services(name), appointment_services(services(name))")
        .eq("customer_id", id)
        .order("start_time", { ascending: false })
        .limit(150),
    ]);

  if (!customer) {
    return (
      <main className="max-w-3xl mx-auto p-8">
        <p className="text-foreground/60">找不到這位客人。</p>
        <Link href="/customers" className="underline text-primary-dark">
          回客戶資料
        </Link>
      </main>
    );
  }

  const profile = customer.line_user_id ? await getLineProfile(customer.line_user_id) : null;

  const paid = (orders ?? []).filter((o) => o.status === "paid");
  const totalSpent = paid.reduce((s, o) => s + o.total, 0);
  const lastOrder = paid[0]?.created_at;
  const activeVouchers = (vouchers ?? []).filter((v) => v.status === "active" && v.remaining_sessions > 0);
  const nowUtc = new Date().toISOString().slice(0, 19);
  const upcoming = (appointments ?? []).filter(
    (a) => a.status !== "cancelled" && a.status !== "completed" && a.start_time.slice(0, 19) >= nowUtc
  );

  return (
    <main className="max-w-2xl mx-auto p-4 sm:p-8">
      <Link href="/customers" className="text-sm text-primary-dark inline-flex items-center gap-1 mb-3">
        <ChevronLeft size={14} /> 客戶資料
      </Link>

      <div className="flex items-center gap-4 mb-4">
        {profile?.pictureUrl ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={profile.pictureUrl} alt="" className="w-16 h-16 rounded-full object-cover" />
        ) : (
          <div className="w-16 h-16 rounded-full bg-primary-light text-primary-dark flex items-center justify-center text-2xl font-bold">
            {customer.name?.slice(0, 1)}
          </div>
        )}
        <div className="min-w-0">
          <h1 className="text-2xl font-bold text-primary-dark">{customer.name}</h1>
          {customer.line_user_id ? (
            <p className="text-sm text-green-700">LINE：{profile?.displayName ?? "（查不到暱稱，可能尚未加好友）"}</p>
          ) : (
            <p className="text-sm text-foreground/50">未綁定 LINE</p>
          )}
        </div>
      </div>

      <div className="flex flex-wrap gap-2 mb-5">
        <Link
          href={`/appointments/new?customer_id=${id}`}
          className="inline-flex items-center gap-1.5 text-sm px-3 py-2 rounded-lg bg-primary-dark text-white hover:bg-primary transition-colors"
        >
          <CalendarPlus size={15} /> 新增預約
        </Link>
        <Link
          href={`/checkout?customer_id=${id}`}
          className="inline-flex items-center gap-1.5 text-sm px-3 py-2 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
        >
          <ShoppingCart size={15} /> 開單
        </Link>
        {customer.phone && (
          <>
            <a
              href={`tel:${customer.phone}`}
              className="inline-flex items-center gap-1.5 text-sm px-3 py-2 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
            >
              <Phone size={15} /> 打電話
            </a>
            <a
              href={`sms:${customer.phone}`}
              className="inline-flex items-center gap-1.5 text-sm px-3 py-2 rounded-lg border border-primary-light text-primary-dark hover:bg-primary-light transition-colors"
            >
              <MessageSquare size={15} /> 簡訊
            </a>
          </>
        )}
        <Link
          href="/customers"
          className="inline-flex items-center gap-1.5 text-sm px-3 py-2 rounded-lg border border-primary-light text-foreground/60 hover:bg-primary-light transition-colors"
        >
          <Pencil size={15} /> 編輯資料
        </Link>
      </div>

      <div className="grid grid-cols-3 gap-2 mb-5 text-center">
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-xl font-bold text-primary-dark">${totalSpent.toLocaleString()}</p>
          <p className="text-xs text-foreground/60">累積消費</p>
        </div>
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-xl font-bold text-primary-dark">{paid.length}</p>
          <p className="text-xs text-foreground/60">累積訂單</p>
        </div>
        <div className="p-3 rounded-xl bg-primary-light">
          <p className="text-xl font-bold text-primary-dark">{activeVouchers.length}</p>
          <p className="text-xs text-foreground/60">可用商品券</p>
        </div>
      </div>

      <div className="flex gap-1 mb-4 border-b border-primary-light overflow-x-auto">
        {TABS.map((t) => (
          <Link
            key={t.key}
            href={`/members/${id}?tab=${t.key}`}
            className={`px-4 py-2 text-sm whitespace-nowrap border-b-2 -mb-px ${
              activeTab === t.key
                ? "border-primary-dark text-primary-dark font-semibold"
                : "border-transparent text-foreground/50 hover:text-primary-dark"
            }`}
          >
            {t.label}
          </Link>
        ))}
      </div>

      {activeTab === "info" && (
        <div className="grid grid-cols-2 gap-x-4 gap-y-4 p-4 border border-primary-light rounded-xl bg-white">
          <Field label="電話" value={customer.phone} />
          <Field label="性別" value={genderLabel[customer.gender ?? ""]} />
          <Field label="生日" value={customer.birthday} />
          <Field label="Email" value={customer.email} />
          <Field label="近次消費" value={lastOrder ? fmtDateTime(lastOrder) : null} />
          <Field label="平均客單" value={paid.length ? `$${Math.round(totalSpent / paid.length).toLocaleString()}` : null} />
          <Field label="建檔日期" value={customer.created_at ? fmtDate(customer.created_at) : null} />
          <Field label="即將到來的預約" value={upcoming.length ? `${upcoming.length} 筆` : null} />
          <div className="col-span-2">
            <Field label="備註" value={customer.note} />
          </div>
        </div>
      )}

      {activeTab === "orders" && (
        <div className="flex flex-col gap-3">
          {(orders ?? []).map((o) => (
            <div key={o.id} className="p-4 border border-primary-light rounded-xl bg-white">
              <div className="flex justify-between items-start mb-1">
                <p className="text-xs text-foreground/50">{fmtDateTime(o.created_at)}</p>
                <span
                  className={`text-xs px-2 py-1 rounded-full ${
                    o.status === "paid" ? "bg-primary-light text-primary-dark" : "bg-yellow-100 text-yellow-700"
                  }`}
                >
                  {o.status === "paid"
                    ? `已付款${o.payment_method ? `・${o.payment_method === "cash" ? "現金" : "匯款"}` : ""}`
                    : "未付款"}
                </span>
              </div>
              <ul className="text-sm text-foreground/70 mb-1">
                {o.order_items?.map((it, idx) => (
                  <li key={idx}>
                    {it.service_name} x{it.quantity} — ${it.price * it.quantity}
                  </li>
                ))}
              </ul>
              <p className="font-bold">實收 ${o.total.toLocaleString()}</p>
            </div>
          ))}
          {(orders ?? []).length === 0 && <p className="text-center text-foreground/50 py-6">還沒有消費紀錄</p>}
        </div>
      )}

      {activeTab === "vouchers" && (
        <div className="flex flex-col gap-3">
          {(vouchers ?? []).map((v) => (
            <div
              key={v.id}
              className={`p-4 border border-primary-light rounded-xl bg-white flex justify-between items-center gap-3 ${
                v.status === "active" && v.remaining_sessions > 0 ? "" : "opacity-50"
              }`}
            >
              <div>
                <p className="font-medium">{v.service_name}</p>
                <p className="text-xs text-foreground/50">購買日 {v.purchased_at}</p>
              </div>
              <p className="text-sm text-primary-dark font-semibold whitespace-nowrap">
                剩 {v.remaining_sessions} / {v.total_sessions} 堂
              </p>
            </div>
          ))}
          {(vouchers ?? []).length === 0 && <p className="text-center text-foreground/50 py-6">沒有商品券</p>}
        </div>
      )}

      {activeTab === "appointments" && (
        <div className="flex flex-col gap-3">
          {(appointments ?? []).map((a) => {
            const linked = (a.appointment_services ?? [])
              .map((row) => (Array.isArray(row.services) ? row.services[0] : row.services))
              .filter((s): s is { name: string } => !!s);
            const single = Array.isArray(a.services) ? a.services[0] : a.services;
            const names = (linked.length > 0 ? linked : single ? [single] : []).map((s) => s.name).join("、");
            return (
              <div
                key={a.id}
                className={`p-4 border border-primary-light rounded-xl bg-white ${a.status === "cancelled" ? "opacity-50" : ""}`}
              >
                <div className="flex justify-between items-start gap-2">
                  <p className="font-semibold">{fmtDateTime(a.start_time)}</p>
                  <span className="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600 whitespace-nowrap">
                    {apptStatus[a.status] ?? a.status}
                    {(a.party_size ?? 1) > 1 ? `・${a.party_size} 位` : ""}
                  </span>
                </div>
                <p className="text-sm text-foreground/70">{names}</p>
                {a.note && <p className="text-xs text-foreground/50 mt-1">備註：{a.note}</p>}
              </div>
            );
          })}
          {(appointments ?? []).length === 0 && <p className="text-center text-foreground/50 py-6">沒有預約紀錄</p>}
        </div>
      )}
    </main>
  );
}
