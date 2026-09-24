const numberFormat = new Intl.NumberFormat('ru-RU');

/** "2017–2024" or "с 2017, выпускается" */
export function formatYears(from: number, to: number | null): string {
  return to === null ? `с ${from}, выпускается` : `${from}–${to}`;
}

/** Formats a number with a unit, or "—" when the value is unknown. */
export function withUnit(value: number | null, unit: string): string {
  return value === null ? '—' : `${numberFormat.format(value)} ${unit}`;
}

/** 2487 cc → "2,5 л (2 487 см³)" */
export function formatEngineVolume(cc: number | null): string {
  if (cc === null) {
    return '—';
  }
  const liters = (Math.round(cc / 100) / 10).toLocaleString('ru-RU', {minimumFractionDigits: 1});
  return `${liters} л (${numberFormat.format(cc)} см³)`;
}
