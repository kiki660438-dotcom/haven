import { createClient } from "@/lib/supabase-server";

function monthRangeTaipei() {
  const dateStr = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
  const [y, m] = dateStr.slice(0, 7).split("-").map(Number);
  const start = `${dateStr.slice(0, 7)}-01`;
  const lastDay = new Date(y, m, 0).getDate();
  const end = `${dateStr.slice(0, 7)}-${String(lastDay).padStart(2, "0")}`;
  return { start, end };
}

export default async function PayrollPage({
  searchParams,
}: {
  searchParams: Promise<{ start?: string; end?: string; material_fee?: string }>;
}) {
  const { start: qStart, end: qEnd, material_fee: qMaterialFee } = await searchParams;
  const defaultRange = monthRangeTaipei();
  const start = qStart || defaultRange.start;
  const end = qEnd || defaultRange.end;
  const materialFeeRate = Number(qMaterialFee ?? 5);

  const supabase = await createClient();
  const [{ data: staffList }, { data: orders }] = await Promise.all([
    supabase.from("staff").select("*").order("name"),
    supabase
      .from("orders")
      .select("total, staff_id")
      .eq("status", "paid")
      .gte("created_at", `${start}T00:00:00+08:00`)
      .lte("created_at", `${end}T23:59:59+08:00`),
  ]);

  const revenueByStaff = new Map<string, number>();
  const orderCountByStaff = new Map<string, number>();
  let unassignedRevenue = 0;

  for (const o of orders ?? []) {
    if (o.staff_id) {
      revenueByStaff.set(o.staff_id, (revenueByStaff.get(o.staff_id) ?? 0) + o.total);
      orderCountByStaff.set(o.staff_id, (orderCountByStaff.get(o.staff_id) ?? 0) + 1);
    } else {
      unassignedRevenue += o.total;
    }
  }

  const rows =
    staffList?.map((s) => {
      const revenue = revenueByStaff.get(s.id) ?? 0;
      const materialFee = Math.round((revenue * materialFeeRate) / 100);
      const base = revenue - materialFee;
      const commission = Math.round((base * s.commission_rate) / 100);
      return {
        id: s.id,
        name: s.name,
        active: s.active,
        commissionRate: s.commission_rate,
        orderCount: orderCountByStaff.get(s.id) ?? 0,
        revenue,
        materialFee,
        commission,
      };
    }) ?? [];

  const totalRevenue = rows.reduce((sum, r) => sum + r.revenue, 0);
  const totalCommission = rows.reduce((sum, r) => sum + r.commission, 0);

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-1">員工業績薪資試算</h1>
      <p className="text-sm text-foreground/50 mb-6">
        公式：業績 → 先扣材料費% → 剩下再乘以抽成% = 抽成薪資（僅試算，實際薪資請自行確認勞健保等規定）
      </p>

      <form
        method="GET"
        action="/payroll"
        className="flex flex-wrap items-end gap-3 mb-6 p-4 border border-primary-light rounded-xl bg-white"
      >
        <div>
          <label className="block text-xs text-foreground/50 mb-1">起始日期</label>
          <input
            name="start"
            type="date"
            defaultValue={start}
            className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          />
        </div>
        <div>
          <label className="block text-xs text-foreground/50 mb-1">結束日期</label>
          <input
            name="end"
            type="date"
            defaultValue={end}
            className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          />
        </div>
        <div>
          <label className="block text-xs text-foreground/50 mb-1">材料費 %</label>
          <input
            name="material_fee"
            type="number"
            step="0.1"
            defaultValue={materialFeeRate}
            className="w-24 border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
          />
        </div>
        <button
          type="submit"
          className="bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          試算
        </button>
      </form>

      <div className="grid grid-cols-2 gap-4 mb-6">
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">期間內業績（已指定員工）</p>
          <p className="text-2xl font-bold text-primary-dark">${totalRevenue}</p>
        </div>
        <div className="p-5 rounded-xl border border-primary-light bg-white">
          <p className="text-sm text-foreground/60 mb-1">期間內抽成薪資總額</p>
          <p className="text-2xl font-bold text-primary-dark">${totalCommission}</p>
        </div>
      </div>

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">員工</th>
            <th className="px-3">單數</th>
            <th className="px-3">業績</th>
            <th className="px-3">材料費</th>
            <th className="px-3">抽成%</th>
            <th className="px-3">抽成薪資</th>
          </tr>
        </thead>
        <tbody>
          {rows.map((r) => (
            <tr key={r.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">
                {r.name}
                {!r.active && <span className="text-xs text-foreground/40">（離職）</span>}
              </td>
              <td className="px-3">{r.orderCount}</td>
              <td className="px-3">${r.revenue}</td>
              <td className="px-3">${r.materialFee}</td>
              <td className="px-3">{r.commissionRate}%</td>
              <td className="px-3 font-semibold">${r.commission}</td>
            </tr>
          ))}
          {rows.length === 0 && (
            <tr>
              <td colSpan={6} className="py-6 px-3 text-center text-foreground/50">
                還沒有員工資料，請先到「員工資料」新增
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>

      {unassignedRevenue > 0 && (
        <p className="text-sm text-foreground/50 mt-3">
          期間內有 ${unassignedRevenue} 的業績沒有指定服務人員，未列入抽成計算（開單結帳時記得選服務人員）。
        </p>
      )}
    </main>
  );
}
