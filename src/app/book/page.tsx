import type { Metadata } from "next";
import { cookies } from "next/headers";
import { supabase } from "@/lib/supabase";
import { verifyCustomerToken, CUSTOMER_COOKIE } from "@/lib/customer-identity";
import {
  createBooking,
  getAvailableSlots,
  getClosedDates,
  getFullDayClosureInfo,
  getMaxAdvanceBookingDate,
  verifyPhone,
  logoutCustomer,
} from "./actions";
import { ChevronDown } from "lucide-react";
import TimeSlotOption from "../components/TimeSlotOption";
import SubmitButton from "../components/SubmitButton";
import PendingGetForm from "../components/PendingGetForm";
import DatePicker from "../components/DatePicker";
import { clampPartySize, earliestBookingDate } from "@/lib/booking-window";

function buildQuery(serviceIds: string[], date: string, staffId: string | undefined, people: number) {
  const params = new URLSearchParams();
  for (const id of serviceIds) params.append("service_id", id);
  params.set("date", date ?? "");
  params.set("staff_id", staffId ?? "");
  params.set("people", String(people));
  return params.toString();
}

type ServiceOption = { id: string; name: string; price: number };

// 服務名稱用「主題-細項」命名（例如「冷塑燙-中髮」），依主題分組；
// 只有一種選項的（例如「剪髮」）不用分組，直接顯示
function groupServices(services: ServiceOption[]) {
  const map = new Map<string, ServiceOption[]>();
  for (const s of services) {
    const dashIndex = s.name.indexOf("-");
    const title = dashIndex === -1 ? s.name : s.name.slice(0, dashIndex);
    if (!map.has(title)) map.set(title, []);
    map.get(title)!.push(s);
  }
  return [...map.entries()].map(([title, items]) => ({ title, items }));
}

export const metadata: Metadata = {
  title: "Haven Hair 線上預約",
  manifest: "/api/manifest?start=book",
  appleWebApp: { capable: true, title: "Haven Hair", statusBarStyle: "default" },
};

export default async function BookPage({
  searchParams,
}: {
  searchParams: Promise<{
    success?: string;
    error?: string;
    service_id?: string | string[];
    date?: string;
    staff_id?: string;
    people?: string;
  }>;
}) {
  const { success, error, service_id, date, staff_id, people } = await searchParams;
  const partySize = clampPartySize(people);
  const serviceIds = service_id ? (Array.isArray(service_id) ? service_id : [service_id]) : [];

  // 這三個查詢互不依賴，平行查比一個一個等快很多
  const minDate = earliestBookingDate();
  const [{ data: allServices }, maxDate, rawClosedInfo, closedDates] = await Promise.all([
    supabase.from("services").select("*").order("name"),
    getMaxAdvanceBookingDate(),
    date ? getFullDayClosureInfo(date) : Promise.resolve(null),
    getClosedDates(minDate),
  ]);

  // 商品券方案（有堂數的服務）只在店內結帳銷售，加上被標記「不開放線上預約」的項目，線上預約選單都不顯示
  const services = allServices?.filter((s) => !s.total_sessions && !s.hide_from_booking);
  const serviceGroups = groupServices(services ?? []);
  const singleServiceGroups = serviceGroups.filter((g) => g.items.length === 1);
  const multiServiceGroups = serviceGroups.filter((g) => g.items.length > 1);

  const tooFar = !!date && date > maxDate;
  const tooSoon = !!date && date < minDate;
  const closedInfo = tooFar || tooSoon ? null : rawClosedInfo;
  const slots =
    serviceIds.length > 0 && date && !closedInfo && !tooFar && !tooSoon
      ? await getAvailableSlots(serviceIds, date, staff_id, partySize)
      : null;

  const cookieStore = await cookies();
  const identity = verifyCustomerToken(cookieStore.get(CUSTOMER_COOKIE)?.value);

  const returnTo = `/book?${buildQuery(serviceIds, date ?? "", staff_id, partySize)}`;
  const lineLoginUrl = `/api/line/login?returnTo=${encodeURIComponent(returnTo)}`;

  return (
    <main className="max-w-xl mx-auto p-8">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-primary-dark">線上預約</h1>
        <a href="/my" className="text-sm underline text-primary-dark">
          查看我的預約／商品券
        </a>
      </div>

      {success ? (
        <div className="p-6 rounded-xl bg-primary-light text-primary-dark text-center">
          <p className="text-lg font-semibold mb-2">預約已送出 🎉</p>
          <p className="text-sm">我們會盡快與您確認，請耐心等候設計師確認通知。</p>
          <div className="mt-4 p-3 rounded-lg bg-white/70 text-left text-sm">
            <p className="font-medium mb-1">想收到預約確認通知？</p>
            <p className="text-foreground/70">
              請加入 Haven Hair 官方 LINE，並傳送您預約時留的<strong>手機號碼</strong>給我們，確認後會從 LINE 通知您。
            </p>
            <a
              href="https://line.me/R/ti/p/@558ekdgz"
              className="inline-block mt-2 px-3 py-1.5 rounded-lg bg-primary-dark text-white text-sm"
            >
              加入官方 LINE
            </a>
          </div>
          <a href="/my" className="inline-block mt-4 text-sm underline">
            查看我的預約／商品券
          </a>
        </div>
      ) : (
      <>
      {error === "conflict" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          抱歉，這個時段剛剛被其他客人預約走了，請重新選擇時段。
        </div>
      )}
      {error === "no_slot" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          請至少選擇一項服務，並選一個可預約時段。
        </div>
      )}
      {error === "no_identity" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          請填寫姓名與電話，或使用 LINE 帳號驗證身份。
        </div>
      )}
      {error === "line_login" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          LINE 登入失敗，請再試一次。
        </div>
      )}
      {error === "too_soon" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          抱歉，不接受當日預約，請選擇明天以後的日期。
        </div>
      )}
      {error === "closed" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          抱歉，這天公休，請選擇其他日期。
        </div>
      )}
      {error === "too_far" && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          抱歉，目前只開放預約到 {maxDate} 之前，請選擇其他日期。
        </div>
      )}
      {closedInfo && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          這天公休{closedInfo.note ? `（${closedInfo.note}）` : ""}，請選擇其他日期。
        </div>
      )}
      {tooSoon && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          不接受當日預約，請選擇明天以後的日期。
        </div>
      )}
      {tooFar && (
        <div className="mb-6 p-4 rounded-xl bg-red-50 text-red-600">
          目前只開放預約到 {maxDate} 之前，請選擇其他日期。
        </div>
      )}

      <PendingGetForm
        action="/book"
        label="查詢可預約時段"
        pendingLabel="查詢中…"
        className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white mb-6"
      >
        <div>
          <p className="text-sm mb-2 text-foreground/60">選擇服務 *（可複選）</p>
          <div className="flex flex-col gap-1 max-h-80 overflow-y-auto border border-primary-light rounded-lg p-2">
            {singleServiceGroups.map((g) => {
              const s = g.items[0];
              return (
                <label
                  key={s.id}
                  className="flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer hover:bg-primary-light"
                >
                  <input
                    type="checkbox"
                    name="service_id"
                    value={s.id}
                    defaultChecked={serviceIds.includes(s.id)}
                  />
                  {s.name}（${s.price}）
                </label>
              );
            })}

            {singleServiceGroups.length > 0 && multiServiceGroups.length > 0 && (
              <hr className="border-primary-light my-1" />
            )}

            {multiServiceGroups.map((g) => {
              const hasChecked = g.items.some((s) => serviceIds.includes(s.id));
              return (
                <details key={g.title} open={hasChecked} className="group">
                  <summary className="flex items-center justify-between gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer select-none hover:bg-primary-light">
                    {g.title}
                    <ChevronDown
                      size={14}
                      className="text-foreground/40 transition-transform group-open:rotate-180"
                    />
                  </summary>
                  <div className="flex flex-col gap-1 pl-4 mt-1">
                    {g.items.map((s) => (
                      <label
                        key={s.id}
                        className="flex items-center gap-2 px-2 py-1.5 rounded-lg text-sm cursor-pointer hover:bg-primary-light"
                      >
                        <input
                          type="checkbox"
                          name="service_id"
                          value={s.id}
                          defaultChecked={serviceIds.includes(s.id)}
                        />
                        {s.name.slice(g.title.length + 1)}（${s.price}）
                      </label>
                    ))}
                  </div>
                </details>
              );
            })}
          </div>
        </div>
        <label className="flex flex-col gap-1 text-sm text-foreground/60">
          預約人數（每位都做同樣的服務）
          <select
            name="people"
            defaultValue={String(partySize)}
            className="border border-primary-light rounded-lg px-3 py-2 text-foreground focus:outline-none focus:border-primary bg-white"
          >
            {[1, 2, 3, 4, 5].map((n) => (
              <option key={n} value={n}>
                {n} 位
              </option>
            ))}
          </select>
          {partySize > 1 && (
            <span className="text-xs text-foreground/50">
              多人會依序服務，所需時間是單人的 {partySize} 倍，可選的時段會變少。
            </span>
          )}
        </label>

        <div>
          <p className="text-sm mb-2 text-foreground/60">選擇日期 *</p>
          <DatePicker name="date" min={minDate} max={maxDate} closed={closedDates} defaultValue={date} />
        </div>
      </PendingGetForm>

      {slots && !identity && (
        <div className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white">
          <p className="text-sm text-foreground/60">
            第一次預約請先驗證身份，之後系統會記住您，不用再輸入姓名電話。
          </p>

          <form action={verifyPhone} className="flex flex-col gap-3">
            {serviceIds.map((id) => (
              <input key={id} type="hidden" name="service_id" value={id} />
            ))}
            <input type="hidden" name="date" value={date} />
            <input type="hidden" name="people" value={partySize} />
            <input type="hidden" name="return_to" value={returnTo} />
            <input
              name="name"
              placeholder="姓名 *"
              required
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            />
            <input
              name="phone"
              placeholder="電話 *"
              required
              className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
            />
            <div className="flex gap-3">
              <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
                生日年月日（選填）
                <input
                  name="birthday"
                  type="date"
                  className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
                />
              </label>
              <label className="flex-1 flex flex-col gap-1 text-sm text-foreground/60">
                性別（選填）
                <select
                  name="gender"
                  defaultValue=""
                  className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
                >
                  <option value=""></option>
                  <option value="male">男</option>
                  <option value="female">女</option>
                  <option value="other">不透露</option>
                </select>
              </label>
            </div>
            <SubmitButton pendingText="登入中…">電話登入</SubmitButton>
          </form>

          <a
            href={lineLoginUrl}
            className="text-center text-sm underline text-primary-dark"
          >
            沒有台灣手機號碼？點此使用 LINE 帳號登入
          </a>
        </div>
      )}

      {slots && identity && (
        <div className="flex items-center justify-between p-3 mb-4 rounded-lg bg-primary-light text-primary-dark text-sm">
          <span>哈囉，{identity.name}！</span>
          <form action={logoutCustomer}>
            {serviceIds.map((id) => (
              <input key={id} type="hidden" name="service_id" value={id} />
            ))}
            <input type="hidden" name="date" value={date} />
            <input type="hidden" name="return_to" value={returnTo} />
            <button type="submit" className="underline">
              不是您本人？登出
            </button>
          </form>
        </div>
      )}

      {slots && identity && (
        <form
          action={createBooking}
          className="flex flex-col gap-4 p-5 border border-primary-light rounded-xl bg-white"
        >
          {serviceIds.map((id) => (
            <input key={id} type="hidden" name="service_id" value={id} />
          ))}
          <input type="hidden" name="date" value={date} />
          <input type="hidden" name="staff_id" value={staff_id ?? ""} />
          <input type="hidden" name="people" value={partySize} />
          <input type="hidden" name="customer_id" value={identity.customerId} />

          {slots.length > 0 ? (
            <div>
              <p className="text-sm text-foreground/60 mb-2">選擇可預約時段 *</p>
              <div className="grid grid-cols-4 gap-2">
                {slots.map((t) => (
                  <TimeSlotOption key={t} time={t} />
                ))}
              </div>
            </div>
          ) : (
            <p className="text-sm text-foreground/50">
              這天已經沒有空的時段了，請選擇其他日期。
            </p>
          )}

          {slots.length > 0 && (
            <label className="flex flex-col gap-1 text-sm text-foreground/60">
              備註（選填）
              <textarea
                name="note"
                rows={3}
                placeholder="有什麼需求都可以在這裡告訴我們"
                className="border border-primary-light rounded-lg px-3 py-2 focus:outline-none focus:border-primary"
              />
            </label>
          )}

          {slots.length > 0 && <SubmitButton pendingText="送出中…">送出預約</SubmitButton>}
        </form>
      )}
      </>
      )}
    </main>
  );
}
