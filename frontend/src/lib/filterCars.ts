import type {CarSummary} from '../api/types';

/**
 * Filters cars by a free-text query: every word of the query must occur
 * (case-insensitively) in brand, model, generation or aliases.
 * Mirrors the backend rule in internal/car/service.go.
 */
export function filterCars(cars: CarSummary[], query: string): CarSummary[] {
  const terms = query.toLowerCase().trim().split(/\s+/).filter(Boolean);
  if (terms.length === 0) {
    return cars;
  }
  return cars.filter((car) => {
    const haystack = [car.brand, car.model, car.generation, car.aliases].join(' ').toLowerCase();
    return terms.every((term) => haystack.includes(term));
  });
}
