// Types mirror specs/001-cars-library/contracts/api.md

export interface CarSummary {
  slug: string;
  brand: string;
  model: string;
  generation: string;
  year_from: number;
  year_to: number | null;
  body_type: string;
  power_hp: number;
  aliases: string;
  cover_image_url: string | null;
}

export interface Brand {
  slug: string;
  name: string;
  country: string;
  founded_year: number;
  history: string;
}

export interface Specs {
  version_note: string;
  engine_type: string;
  engine_volume_cc: number | null;
  power_hp: number;
  torque_nm: number;
  transmission: string;
  drive: string;
  acceleration_s: number | null;
  top_speed_kmh: number | null;
  fuel_consumption_l: number | null;
  fuel_tank_l: number | null;
  length_mm: number;
  width_mm: number;
  height_mm: number;
  wheelbase_mm: number;
  curb_weight_kg: number | null;
  trunk_l: number | null;
  seats: number;
}

export interface CarImage {
  url: string;
  source_url: string;
  author: string;
  license: string;
}

export interface CarDetail {
  slug: string;
  model: string;
  generation: string;
  year_from: number;
  year_to: number | null;
  body_type: string;
  car_class: string;
  description: string;
  brand: Brand;
  specs: Specs;
  images: CarImage[];
  links: {auto_ru: string; avito: string};
}

export interface ListResponse<T> {
  data: T[];
  meta: {total: number};
}

export interface ItemResponse<T> {
  data: T;
}

export interface ErrorResponse {
  error: {code: string; message: string};
}
