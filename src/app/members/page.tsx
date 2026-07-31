import Link from "next/link";
import { createClient } from "@/lib/supabase-server";

const genderLabel: Record<string, string> = {
  male: "男",
  female: "女",
  other: "不透露",
};

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

      <div className="overflow-x-auto">
      <table className="w-full text-left border-collapse bg-white rounded-xl overflow-hidden">
        <thead>
          <tr className="border-b border-primary-light bg-primary-light">
            <th className="py-2 px-3">姓名</th>
            <th className="px-3">電話</th>
            <th className="px-3">年齡 / 性別</th>
            <th className="px-3">消費次數</th>
            <th className="px-3">累計消費</th>
            <th className="px-3">最近消費</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {rows.map((r) => (
            <tr key={r.id} className="border-b border-primary-light/60">
              <td className="py-2 px-3">{r.name}</td>
              <td className="px-3">{r.phone}</td>
              <td className="px-3">
                {r.age ?? "-"}
                {r.gender ? ` / ${genderLabel[r.gender] ?? r.gender}` : ""}
              </td>
              <td className="px-3">{r.visitCount}</td>
              <td className="px-3">${r.totalSpent}</td>
              <td className="px-3">
                {r.lastVisit
                  ? new Date(r.lastVisit).toLocaleDateString("zh-TW", {
                      timeZone: "Asia/Taipei",
                    })
                  : "-"}
              </td>
              <td className="px-3">
                <Link href={`/members/${r.id}`} className="text-primary-dark text-sm underline">
                  查看明細
                </Link>
              </td>
            </tr>
          ))}
          {rows.length === 0 && (
            <tr>
              <td colSpan={7} className="py-6 px-3 text-center text-foreground/50">
                還沒有會員消費紀錄
              </td>
            </tr>
          )}
        </tbody>
      </table>
      </div>
    </main>
  );
}
