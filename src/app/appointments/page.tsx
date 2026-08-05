import Link from "next/link";
import { createClient } from "@/lib/supabase-server";
import { updateAppointmentStatus, updateAppointmentTime } from "./actions";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

function toDateInputValue(iso: string) {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date(iso));
}

function toTimeInputValue(iso: string) {
  return new Intl.DateTimeFormat("en-GB", {
    timeZone: "Asia/Taipei",
    hour: "2-digit",
    minute: "2-digit",
    hour12: false,
  }).format(new Date(iso));
}

export default async function AppointmentsPage() {
  const supabase = await createClient();
  const { data: appointments } = await supabase
    .from("appointments")
    .select("id, start_time, status, customers(name, phone), services(name, price)")
    .order("start_time", { ascending: true });

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">預約管理</h1>

      <div className="flex flex-col gap-3">
        {appointments?.map((a) => {
          const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
          const service = Array.isArray(a.services) ? a.services[0] : a.services;
          return (
            <div key={a.id} className="p-4 border border-primary-light rounded-xl bg-white">
              <div className="flex justify-between items-start mb-2 gap-3">
                <div>
                  <p className="font-semibold">
                    {customer?.name}
                    <span className="font-normal text-xs text-foreground/50 ml-2">
                      {customer?.phone}
                    </span>
                  </p>
                  <p className="text-sm text-foreground/70">
                    {service?.name}（${service?.price}）
                  </p>
                  <p className="text-xs text-foreground/50">
                    {new Date(a.start_time).toLocaleString("zh-TW", { timeZone: "Asia/Taipei" })}
                  </p>
                  <form
                    action={updateAppointmentTime.bind(null, a.id)}
                    className="flex items-center gap-2 mt-2"
                  >
                    <input
                      type="date"
                      name="date"
                      defaultValue={toDateInputValue(a.start_time)}
                      className="border border-primary-light rounded-lg px-2 py-1 text-sm"
                    />
                    <input
                      type="time"
                      name="time"
                      defaultValue={toTimeInputValue(a.start_time)}
                      className="border border-primary-light rounded-lg px-2 py-1 text-sm"
                    />
                    <button type="submit" className="text-primary-dark text-sm underline whitespace-nowrap">
                      更新時間
                    </button>
                  </form>
                </div>
                <span
                  className={`text-sm px-2 py-1 rounded-full whitespace-nowrap ${
                    a.status === "confirmed"
                      ? "bg-primary-light text-primary-dark"
                      : a.status === "cancelled"
                      ? "bg-red-50 text-red-500"
                      : a.status === "completed"
                      ? "bg-primary-light text-primary-dark"
                      : "bg-yellow-100 text-yellow-700"
                  }`}
                >
                  {statusLabel[a.status] ?? a.status}
                </span>
              </div>
              <div className="flex flex-wrap gap-3">
                <form action={updateAppointmentStatus.bind(null, a.id, "confirmed")}>
                  <button className="text-primary-dark text-sm underline">確認</button>
                </form>
                <form action={updateAppointmentStatus.bind(null, a.id, "cancelled")}>
                  <button className="text-red-500 text-sm underline">取消</button>
                </form>
                <Link
                  href={`/checkout?appointment=${a.id}`}
                  className="text-sm underline text-primary-dark"
                >
                  開單
                </Link>
              </div>
            </div>
          );
        })}
        {appointments?.length === 0 && (
          <p className="text-center text-foreground/50 py-6">還沒有預約紀錄</p>
        )}
      </div>
    </main>
  );
}
