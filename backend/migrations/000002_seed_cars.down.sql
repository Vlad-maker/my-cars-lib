-- Откат стартовых данных.
DELETE FROM car_images WHERE car_id IN (SELECT id FROM cars WHERE slug IN ('toyota-camry', 'lada-vesta', 'kia-rio', 'hyundai-creta', 'volkswagen-tiguan', 'skoda-octavia', 'bmw-3-series', 'mercedes-benz-e-class', 'mazda-cx-5', 'haval-jolion'));
DELETE FROM car_specs WHERE car_id IN (SELECT id FROM cars WHERE slug IN ('toyota-camry', 'lada-vesta', 'kia-rio', 'hyundai-creta', 'volkswagen-tiguan', 'skoda-octavia', 'bmw-3-series', 'mercedes-benz-e-class', 'mazda-cx-5', 'haval-jolion'));
DELETE FROM cars WHERE slug IN ('toyota-camry', 'lada-vesta', 'kia-rio', 'hyundai-creta', 'volkswagen-tiguan', 'skoda-octavia', 'bmw-3-series', 'mercedes-benz-e-class', 'mazda-cx-5', 'haval-jolion');
DELETE FROM brands WHERE slug IN ('toyota', 'lada', 'kia', 'hyundai', 'volkswagen', 'skoda', 'bmw', 'mercedes-benz', 'mazda', 'haval');
