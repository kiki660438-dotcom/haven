import { createClient } from "@/lib/supabase-server";
import VouchersSearchList from "./VouchersSearchList";

export default async function VouchersPage() {
  const supabase = await createClient();
  const { data: vouchers } = await supabase
    .from("vouchers")
    .select(
      "id, code, initial_value, remaining_value, status, expires_at, service_name, total_sessions, remaining_sessions, purchased_at, unit_price, duration_minutes, customers(name, phone)"
    )
    .order("issued_at", { ascending: false });

  return (
    <main className="max-w-3xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-2">商品券</h1>
      <p className="text-sm text-foreground/50 mb-6">
        新購與扣堂數請到「開單結帳」操作，這裡僅供查詢。
      </p>

      <VouchersSearchList vouchers={vouchers ?? []} />
    </main>
  );
}
