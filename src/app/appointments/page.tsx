import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { updateAppointmentStatus } from "./actions";

const statusLabel: Record<string, string> = {
  pending: "待確認",
  confirmed: "已確認",
  cancelled: "已取消",
  completed: "已完成",
};

export default async function AppointmentsPage() {
  const { data: appointments } = await supabase
    .from("appointments")
    .select("id, start_time, status, customers(name, phone), services(name, price)")
    .order("start_time", { ascending: true });

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">預約管理</h1>

      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">時間</th>
            <th className="px-3">客戶</th>
            <th className="px-3">服務</th>
            <th className="px-3">狀態</th>
            <th className="px-3"></th>
          </tr>
        </thead>
        <tbody>
          {appointments?.map((a) => {
            const customer = Array.isArray(a.customers) ? a.customers[0] : a.customers;
            const service = Array.isArray(a.services) ? a.services[0] : a.services;
            return (
              <tr key={a.id} className="border-b border-primary-light/60">
                <td className="py-2 px-3">
                  {new Date(a.start_time).toLocaleString("zh-TW", {
                    timeZone: "Asia/Taipei",
                  })}
                </td>
                <td className="px-3">
                  {customer?.name}
                  <br />
                  <span className="text-xs text-foreground/50">{customer?.phone}</span>
                </td>
                <td className="px-3">
                  {service?.name}（${service?.price}）
                </td>
                <td className="px-3">{statusLabel[a.status] ?? a.status}</td>
                <td className="px-3">
                  <div className="flex flex-wrap gap-2">
                    <form action={updateAppointmentStatus.bind(null, a.id, "confirmed")}>
                      <button className="text-primary-dark text-sm">確認</button>
                    </form>
                    <form action={updateAppointmentStatus.bind(null, a.id, "cancelled")}>
                      <button className="text-red-500 text-sm">取消</button>
                    </form>
                    <Link
                      href={`/checkout?appointment=${a.id}`}
                      className="text-sm underline text-primary-dark"
                    >
                      開單
                    </Link>
                  </div>
                </td>
              </tr>
            );
          })}
          {appointments?.length === 0 && (
            <tr>
              <td colSpan={5} className="py-6 px-3 text-center text-foreground/50">
                還沒有預約紀錄
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </main>
  );
}
