export default function TimeSlotOption({ time, busy }: { time: string; busy?: boolean }) {
  return (
    <label className="relative cursor-pointer touch-manipulation">
      <input type="radio" name="time" value={time} required className="peer sr-only" />
      <span
        className={`flex items-center justify-center rounded-lg border px-2 py-3 text-sm select-none transition-colors active:scale-95 peer-checked:border-primary-dark peer-checked:bg-primary-dark peer-checked:text-white peer-focus-visible:ring-2 peer-focus-visible:ring-primary ${
          busy ? "border-orange-300" : "border-primary-light"
        }`}
      >
        {time}
      </span>
    </label>
  );
}
