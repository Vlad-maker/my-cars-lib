// The only place in the app that talks to the backend (constitution, Article IV.2).
import type {CarDetail, CarSummary, ItemResponse, ListResponse} from './types';

const API_BASE = import.meta.env.VITE_API_BASE ?? '/api/v1';

export class NotFoundError extends Error {
  constructor(message = 'not found') {
    super(message);
    this.name = 'NotFoundError';
  }
}

async function request<T>(path: string, signal?: AbortSignal): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: {Accept: 'application/json'},
    signal,
  });
  if (res.status === 404) {
    throw new NotFoundError();
  }
  if (!res.ok) {
    throw new Error(`API ${path} responded ${res.status}`);
  }
  return (await res.json()) as T;
}

export async function fetchCars(signal?: AbortSignal): Promise<CarSummary[]> {
  const body = await request<ListResponse<CarSummary>>('/cars', signal);
  return body.data;
}

export async function fetchCar(slug: string, signal?: AbortSignal): Promise<CarDetail> {
  const body = await request<ItemResponse<CarDetail>>(`/cars/${encodeURIComponent(slug)}`, signal);
  return body.data;
}
