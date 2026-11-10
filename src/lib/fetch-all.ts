// Supabase 每次查詢最多只回 1000 筆（專案的 max rows 設定），客人超過 1000 位之後，
// 排在後面的客人就不會出現在名單/搜尋裡。這裡一頁一頁抓，直到抓完為止。
// 傳進來的查詢要有固定排序（例如 .order("name").order("id")），分頁才不會重複或漏掉。
const PAGE_SIZE = 1000;

export async function fetchAllRows<T>(
  page: (from: number, to: number) => PromiseLike<{ data: T[] | null; error: unknown }>
): Promise<T[]> {
  const all: T[] = [];
  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await page(from, from + PAGE_SIZE - 1);
    if (error) {
      console.error("fetchAllRows failed", error);
      break;
    }
    if (!data || data.length === 0) break;
    all.push(...data);
    if (data.length < PAGE_SIZE) break;
  }
  return all;
}
