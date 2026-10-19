import { createClient } from "@/lib/supabase-server";
import CustomerPicker from "./CustomerPicker";
import CheckoutForm from "./CheckoutForm";

export default async function CheckoutPage({
  searchParams,
}: {
  searchParams: Promise<{ appointment?: string; customer_id?: string; error?: string }>;
}) {
  const { appointment: appointmentId, customer_id: selectedCustomerId, error } = await searchParams;
  const supabase = await createClient();

  let appointment: {
    id: string;
    customer_id: string | null;
    service_id: string | null;
    staff_id: string | null;
    appointment_services: { service_id: string }[] | null;
  } | null = null;
  if (appointmentId) {
    const { data } = await supabase
      .from("appointments")
      .select("id, customer_id, service_id, staff_id, appointment_services(service_id)")
      .eq("id", appointmentId)
      .maybeSingle();
    appointment = data;
  }

  const customerId = appointment?.customer_id ?? selectedCustomerId ?? "";

  const [{ data: services }, { data: staffList }, customersResult, customerResult, vouchersResult] =
    await Promise.all([
      supabase.from("services").select("id, name, price, total_sessions").order("name"),
      supabase.from("staff").select("id, name").eq("active", true).order("name"),
      appointment
        ? Promise.resolve({ data: null })
        : supabase.from("customers").select("id, name, phone").order("name"),
      customerId
        ? supabase.from("customers").select("name, phone").eq("id", customerId).maybeSingle()
        : Promise.resolve({ data: null }),
      customerId
        ? supabase
            .from("vouchers")
            .select("id, service_name, total_sessions, remaining_sessions")
            .eq("customer_id", customerId)
            .eq("status", "active")
            .gt("remaining_sessions", 0)
            .order("purchased_at")
        : Promise.resolve({ data: [] }),
    ]);

  const customer = customerResult.data;
  const customerLabel = customer ? `${customer.name}（${customer.phone ?? ""}）` : "";

  const initialServiceIds = appointment?.appointment_services?.length
    ? appointment.appointment_services.map((row) => row.service_id)
    : appointment?.service_id
      ? [appointment.service_id]
      : [];

  return (
    <main className="max-w-2xl mx-auto p-4 sm:p-8">
      <h1 className="text-2xl font-bold text-primary-dark mb-6">開單結帳</h1>

      {error && (
        <div className="mb-4 p-4 rounded-xl bg-red-50 text-red-600 text-sm">{decodeURIComponent(error)}</div>
      )}

      {!appointment && (
        <form
          method="GET"
          action="/checkout"
          className="flex flex-col gap-3 mb-5 p-4 border border-primary-light rounded-xl bg-white"
        >
          <label className="block text-sm text-foreground/60">先選客人（會列出他的商品券；現場客可以略過）</label>
          <CustomerPicker
            customers={customersResult.data ?? []}
            name="customer_id"
            defaultCustomerId={customerId}
            defaultLabel={customerLabel}
          />
          <button
            type="submit"
            className="bg-primary-light text-primary-dark rounded-lg px-4 py-2 hover:bg-primary/30 transition-colors"
          >
            選擇客人
          </button>
        </form>
      )}

      <CheckoutForm
        key={`${appointmentId ?? ""}-${customerId}`}
        services={services ?? []}
        vouchers={vouchersResult.data ?? []}
        staffList={staffList ?? []}
        appointmentId={appointment?.id ?? ""}
        customerId={customerId}
        customerLabel={customerLabel}
        initialServiceIds={initialServiceIds}
        defaultStaffId={appointment?.staff_id ?? ""}
      />
    </main>
  );
}
