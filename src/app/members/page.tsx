import { createClient } from "@/lib/supabase-server";
import MembersSearchTable from "./MembersSearchTable";

function calcAge(birthday: string | null) {
  if (!birthday) return null;
  const today = new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Taipei" }).format(new Date());
  const [todayY, todayM, todayD] = today.split("-").map(Number);
  const [birthY, birthM, birthD] = birthday.split("-").map(Number);
  let age = todayY - birthY;
  if (todayM < birthM || (todayM === birthM && todayD < birthD)) age--;
  return age;
}

export default async function MembersPage() {
  const supabase = await createClient();
  const { data: customers } = await supabase
    .from("customers")
    .select("id, name, phone, birthday, gender, orders(total, status, created_at)")
    .order("name");

  const rows =
    customers?.map((c) => {
      const orders = c.orders ?? [];
      const totalSpent = orders
        .filter((o) => o.status === "paid")
        .reduce((sum, o) => sum + o.total, 0);
      const visitCount = orders.length;
      const lastVisit = orders
        .map((o) => o.created_at)
        .sort()
        .at(-1);
      return {
        id: c.id,
        name: c.name,
        phone: c.phone,
        age: calcAge(c.birthday),
        gender: c.gender,
        totalSpent,
        visitCount,
        lastVisit,
      };
    }) ?? [];

  rows.sort((a, b) => b.totalSpent - a.totalSpent);

  return (
    <main className="max-w-4xl mx-auto p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">會員消費紀錄</h1>
      <MembersSearchTable rows={rows} />
    </main>
  );
}
