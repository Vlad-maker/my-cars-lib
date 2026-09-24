import {describe, expect, it} from 'vitest';
import type {CarSummary} from '../api/types';
import {filterCars} from './filterCars';

const car = (slug: string, brand: string, model: string, generation: string, aliases: string): CarSummary => ({
  slug,
  brand,
  model,
  generation,
  aliases,
  year_from: 2020,
  year_to: null,
  body_type: 'Седан',
  power_hp: 100,
  cover_image_url: null,
});

const cars = [
  car('toyota-camry', 'Toyota', 'Camry', 'XV70', 'тойота камри'),
  car('lada-vesta', 'Lada', 'Vesta', 'I (NG)', 'лада веста'),
  car('skoda-octavia', 'Škoda', 'Octavia', 'IV (A8)', 'шкода октавия'),
];

const slugs = (list: CarSummary[]) => list.map((c) => c.slug);

describe('filterCars', () => {
  it('returns everything for an empty query', () => {
    expect(slugs(filterCars(cars, '  '))).toEqual(['toyota-camry', 'lada-vesta', 'skoda-octavia']);
  });

  it.each([
    ['CAMRY', ['toyota-camry']],
    ['Камри', ['toyota-camry']],
    ['xv70', ['toyota-camry']],
    ['škoda', ['skoda-octavia']],
    ['лада веста', ['lada-vesta']],
    ['лада камри', []],
    ['ferrari', []],
  ])('query %s', (query, expected) => {
    expect(slugs(filterCars(cars, query))).toEqual(expected);
  });
});
