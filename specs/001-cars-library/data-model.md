# Модель данных: 001 Библиотека автомобилей

> Артефакт фазы 5 (`/plan`). SQL-схема здесь описана контрактом: таблицы, колонки, ограничения. Сами миграции лежат в `backend/migrations/`.

## ER-диаграмма

```
brands 1 ──── * cars 1 ──── 1 car_specs
                    1
                    └────── * car_images
```

## Таблица `brands`, марки

| Колонка | Тип | Ограничения | Пример |
|---|---|---|---|
| id | INTEGER | PK, autoincrement | 1 |
| slug | TEXT | NOT NULL, UNIQUE | `toyota` |
| name | TEXT | NOT NULL | `Toyota` |
| country | TEXT | NOT NULL | `Япония` |
| founded_year | INTEGER | NOT NULL | 1937 |
| history | TEXT | NOT NULL | Несколько абзацев, разделённых `\n\n` |

## Таблица `cars`, модели (конкретное поколение)

| Колонка | Тип | Ограничения | Пример |
|---|---|---|---|
| id | INTEGER | PK | 1 |
| slug | TEXT | NOT NULL, UNIQUE | `toyota-camry` |
| brand_id | INTEGER | NOT NULL, FK → brands.id | 1 |
| model | TEXT | NOT NULL | `Camry` |
| generation | TEXT | NOT NULL | `XV70` |
| year_from | INTEGER | NOT NULL | 2017 |
| year_to | INTEGER | NULL (NULL означает «выпускается») | 2024 |
| body_type | TEXT | NOT NULL | `Седан` |
| car_class | TEXT | NOT NULL | `E (бизнес)` |
| description | TEXT | NOT NULL | Короткое описание |
| aliases | TEXT | NOT NULL, DEFAULT '' | `тойота камри` (русские написания для поиска) |
| auto_ru_url | TEXT | NOT NULL | `https://auto.ru/cars/toyota/camry/all/` |
| avito_url | TEXT | NOT NULL | `https://www.avito.ru/all/avtomobili/toyota/camry` |
| sort_order | INTEGER | NOT NULL, DEFAULT 0 | порядок на главной |

## Таблица `car_specs`, характеристики (1:1 с `cars`)

| Колонка | Тип | Пример |
|---|---|---|
| car_id | INTEGER PK, FK → cars.id ON DELETE CASCADE | 1 |
| engine_type | TEXT | `Бензиновый, атмосферный` |
| engine_volume_cc | INTEGER NULL | 2494 |
| power_hp | INTEGER | 181 |
| torque_nm | INTEGER | 231 |
| transmission | TEXT | `Автомат, 8 ступеней` |
| drive | TEXT | `Передний` |
| acceleration_s | REAL NULL | 9.1 |
| top_speed_kmh | INTEGER NULL | 210 |
| fuel_consumption_l | REAL NULL | 7.8 (смешанный цикл, л/100 км) |
| fuel_tank_l | INTEGER NULL | 60 |
| length_mm, width_mm, height_mm, wheelbase_mm | INTEGER | 4885, 1840, 1455, 2825 |
| curb_weight_kg | INTEGER NULL | 1570 |
| trunk_l | INTEGER NULL | 493 |
| seats | INTEGER | 5 |
| version_note | TEXT | `2.5 AT (181 л.с.)`: для какой версии указаны данные |

## Таблица `car_images`, фотографии

| Колонка | Тип | Ограничения |
|---|---|---|
| id | INTEGER | PK |
| car_id | INTEGER | NOT NULL, FK → cars.id ON DELETE CASCADE |
| url | TEXT | NOT NULL (прямая ссылка на картинку) |
| source_url | TEXT | NOT NULL (страница файла на Commons) |
| author | TEXT | NOT NULL |
| license | TEXT | NOT NULL |
| position | INTEGER | NOT NULL; 0 = обложка |

Индекс: `UNIQUE(car_id, position)`.

## Инварианты

- Первая фотография (`position = 0`) служит обложкой в списке.
- `slug` состоит только из `[a-z0-9-]`, он используется в URL.
- Удаление машины каскадно удаляет её характеристики и фото.
