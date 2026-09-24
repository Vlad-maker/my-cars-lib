import {create} from 'zustand';
import {fetchCar, fetchCars, NotFoundError} from '../api/cars';
import type {CarDetail, CarSummary} from '../api/types';

export type LoadStatus = 'idle' | 'loading' | 'ready' | 'error';
export type DetailStatus = LoadStatus | 'not-found';

interface CarsState {
  /** Catalog list for the home page. */
  cars: CarSummary[];
  listStatus: LoadStatus;
  /** Search box value; kept in the store so it survives navigation back to the list. */
  query: string;
  /** Cache of full car cards by slug. */
  details: Record<string, CarDetail>;
  detailStatus: Record<string, DetailStatus>;

  setQuery: (query: string) => void;
  loadCars: (opts?: {force?: boolean}) => Promise<void>;
  loadCar: (slug: string) => Promise<void>;
}

export const useCarsStore = create<CarsState>()((set, get) => ({
  cars: [],
  listStatus: 'idle',
  query: '',
  details: {},
  detailStatus: {},

  setQuery: (query) => set({query}),

  loadCars: async ({force = false} = {}) => {
    const {listStatus} = get();
    if (!force && (listStatus === 'loading' || listStatus === 'ready')) {
      return;
    }
    set({listStatus: 'loading'});
    try {
      const cars = await fetchCars();
      set({cars, listStatus: 'ready'});
    } catch (err) {
      console.error('failed to load cars', err);
      set({listStatus: 'error'});
    }
  },

  loadCar: async (slug) => {
    const status = get().detailStatus[slug];
    if (status === 'loading' || status === 'ready') {
      return;
    }
    set((s) => ({detailStatus: {...s.detailStatus, [slug]: 'loading'}}));
    try {
      const car = await fetchCar(slug);
      set((s) => ({
        details: {...s.details, [slug]: car},
        detailStatus: {...s.detailStatus, [slug]: 'ready'},
      }));
    } catch (err) {
      const next: DetailStatus = err instanceof NotFoundError ? 'not-found' : 'error';
      if (next === 'error') {
        console.error(`failed to load car ${slug}`, err);
      }
      set((s) => ({detailStatus: {...s.detailStatus, [slug]: next}}));
    }
  },
}));
