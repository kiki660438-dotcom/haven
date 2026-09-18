"use client";

import { useMemo, useState } from "react";
import { ChevronDown, Plus, X } from "lucide-react";
import { updateServiceRecipe } from "./actions";

type Product = { id: string; name: string; unit: string; cost_price: number };
type RecipeRow = { product_id: string; quantity: number };

export default function ServiceRecipeEditor({
  serviceId,
  initialRecipe,
  products,
}: {
  serviceId: string;
  initialRecipe: RecipeRow[];
  products: Product[];
}) {
  const [rows, setRows] = useState<RecipeRow[]>(
    initialRecipe.length > 0 ? initialRecipe : [{ product_id: "", quantity: 1 }]
  );

  const productMap = useMemo(() => new Map(products.map((p) => [p.id, p])), [products]);

  const estimatedCost = rows.reduce((sum, r) => {
    const product = productMap.get(r.product_id);
    return sum + (product ? product.cost_price * r.quantity : 0);
  }, 0);

  return (
    <details className="mt-2 group">
      <summary className="text-xs text-foreground/50 cursor-pointer select-none inline-flex items-center gap-1 hover:text-primary-dark">
        <ChevronDown size={12} className="transition-transform group-open:rotate-180" />
        設定配方（用了哪些商品，用於算成本）
      </summary>

      <form action={updateServiceRecipe.bind(null, serviceId)} className="flex flex-col gap-2 mt-2 pl-4">
        {rows.map((row, idx) => {
          const product = productMap.get(row.product_id);
          return (
            <div key={idx} className="flex items-center gap-2">
              <select
                name="product_id"
                value={row.product_id}
                onChange={(e) => {
                  const next = [...rows];
                  next[idx] = { ...next[idx], product_id: e.target.value };
                  setRows(next);
                }}
                className="border border-primary-light rounded-lg px-2 py-1 text-sm flex-1"
              >
                <option value="">選擇商品</option>
                {products.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.name}（${p.cost_price}/{p.unit}）
                  </option>
                ))}
              </select>
              <input
                type="number"
                name="quantity"
                min={0}
                step={0.1}
                value={row.quantity}
                onChange={(e) => {
                  const next = [...rows];
                  next[idx] = { ...next[idx], quantity: Number(e.target.value) };
                  setRows(next);
                }}
                className="w-16 border border-primary-light rounded-lg px-2 py-1 text-sm"
              />
              <span className="text-xs text-foreground/50 w-8">{product?.unit ?? ""}</span>
              <button
                type="button"
                onClick={() => setRows(rows.filter((_, i) => i !== idx))}
                className="text-foreground/40 hover:text-red-500"
              >
                <X size={14} />
              </button>
            </div>
          );
        })}

        <button
          type="button"
          onClick={() => setRows([...rows, { product_id: "", quantity: 1 }])}
          className="inline-flex items-center gap-1 text-xs text-primary-dark self-start"
        >
          <Plus size={12} /> 新增材料
        </button>

        <p className="text-xs text-foreground/50">預估這個服務的材料成本：${estimatedCost.toFixed(1)}</p>

        <button type="submit" className="text-primary-dark text-sm underline self-start">
          儲存配方
        </button>
      </form>
    </details>
  );
}
