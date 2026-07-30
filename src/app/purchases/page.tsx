import { createClient } from "@/lib/supabase-server";
import { recordPurchase } from "./actions";

export default async function PurchasesPage() {
  const supabase = await createClient();
  const [{ data: products }, { data: records }] = await Promise.all([
    supabase.from("products").select("*").order("name"),
    supabase
      .from("purchase_records")
      .select("id, quantity, unit_cost, total_cost, supplier, purchased_at, products(name, unit)")
      .order("purchased_at", { ascending: false }),
  ]);

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">進貨紀錄</h1>

      <form
        action={recordPurchase}
        className="grid grid-cols-2 gap-3 mb-8 p-4 border border-primary-light rounded-xl bg-white"
      >
        <input
          name="product_name"
          placeholder="商品名稱 * (已存在會自動累加庫存)"
          required
          list="product-list"
          className="border border-primary-light rounded-lg px-3 py-2 col-span-2 focus:outline-none focus:border-primary"
        />
        <datalist id="product-list">
          {products?.map((p) => (
            <option key={p.id} value={p.name} />
          ))}
        </datalist>
        <input
          name="quantity"
          type="number"
          placeholder="數量 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="unit_cost"
          type="number"
          placeholder="單價成本 *"
          required
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="unit"
          placeholder="單位 (例如：瓶)"
          defaultValue="個"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <input
          name="supplier"
          placeholder="供應商"
          className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
        />
        <button
          type="submit"
          className="col-span-2 bg-primary-dark text-white rounded-lg px-4 py-2 hover:bg-primary transition-colors"
        >
          新增進貨紀錄
        </button>
      </form>

      <h2 className="font-semibold mb-2">目前庫存</h2>
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden mb-8">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">商品</th>
            <th className="px-3">庫存量</th>
            <th className="px-3">最近成本</th>
          </tr>
        </thead>
        <tbody>
          {products?.map((p) => (
            <tr key={p.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{p.name}</td>
              <td className="px-3">
                {p.stock_quantity} {p.unit}
              </td>
              <td className="px-3">${p.cost_price}</td>
            </tr>
          ))}
          {products?.length === 0 && (
            <tr>
              <td colSpan={3} className="py-6 px-3 text-center text-foreground/50">
                還沒有商品
              </td>
            </tr>
          )}
        </tbody>
      </table>

      <h2 className="font-semibold mb-2">進貨歷史</h2>
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">時間</th>
            <th className="px-3">商品</th>
            <th className="px-3">數量</th>
            <th className="px-3">總成本</th>
            <th className="px-3">供應商</th>
          </tr>
        </thead>
        <tbody>
          {records?.map((r) => {
            const product = Array.isArray(r.products) ? r.products[0] : r.products;
            return (
              <tr key={r.id} className="border-b border-primary-light/60">
                <td className="py-2 px-3">
                  {new Date(r.purchased_at).toLocaleDateString("zh-TW", {
                    timeZone: "Asia/Taipei",
                  })}
                </td>
                <td className="px-3">{product?.name}</td>
                <td className="px-3">
                  {r.quantity} {product?.unit}
                </td>
                <td className="px-3">${r.total_cost}</td>
                <td className="px-3">{r.supplier}</td>
              </tr>
            );
          })}
          {records?.length === 0 && (
            <tr>
              <td colSpan={5} className="py-6 px-3 text-center text-foreground/50">
                還沒有進貨紀錄
              </td>
            </tr>
          )}
        </tbody>
      </table>
    </main>
  );
}
