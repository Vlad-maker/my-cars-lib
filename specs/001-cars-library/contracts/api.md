# API-контракт: 001 Библиотека автомобилей

Базовый путь: `/api/v1`. Формат JSON, поля в `snake_case`.

## GET /api/v1/cars

Список автомобилей в кратком виде, отсортированный по `sort_order`.

Query-параметры:

| Параметр | Обязателен | Описание |
|---|---|---|
| `q` | нет | Регистронезависимый поиск подстроки в марке, модели, поколении и aliases |

Ответ `200 OK`:

```json
{
  "data": [
    {
      "slug": "toyota-camry",
      "brand": "Toyota",
      "model": "Camry",
      "generation": "XV70",
      "year_from": 2017,
      "year_to": 2024,
      "body_type": "Седан",
      "power_hp": 181,
      "aliases": "тойота камри",
      "cover_image_url": "https://upload.wikimedia.org/..."
    }
  ],
  "meta": { "total": 10 }
}
```

`year_to` может быть `null`, если модель выпускается сейчас. `cover_image_url` может быть `null`, если у машины нет фото.

## GET /api/v1/cars/{slug}

Полная информация об автомобиле.

Ответ `200 OK`:

```json
{
  "data": {
    "slug": "toyota-camry",
    "model": "Camry",
    "generation": "XV70",
    "year_from": 2017,
    "year_to": 2024,
    "body_type": "Седан",
    "car_class": "E (бизнес)",
    "description": "...",
    "brand": {
      "slug": "toyota",
      "name": "Toyota",
      "country": "Япония",
      "founded_year": 1937,
      "history": "..."
    },
    "specs": {
      "version_note": "2.5 AT (181 л.с.)",
      "engine_type": "Бензиновый, атмосферный",
      "engine_volume_cc": 2494,
      "power_hp": 181,
      "torque_nm": 231,
      "transmission": "Автомат, 8 ступеней",
      "drive": "Передний",
      "acceleration_s": 9.1,
      "top_speed_kmh": 210,
      "fuel_consumption_l": 7.8,
      "fuel_tank_l": 60,
      "length_mm": 4885,
      "width_mm": 1840,
      "height_mm": 1455,
      "wheelbase_mm": 2825,
      "curb_weight_kg": 1570,
      "trunk_l": 493,
      "seats": 5
    },
    "images": [
      {
        "url": "https://upload.wikimedia.org/...",
        "source_url": "https://commons.wikimedia.org/wiki/File:...",
        "author": "Alexander-93",
        "license": "CC BY-SA 4.0"
      }
    ],
    "links": {
      "auto_ru": "https://auto.ru/cars/toyota/camry/all/",
      "avito": "https://www.avito.ru/all/avtomobili/toyota/camry"
    }
  }
}
```

Числовые поля в `specs` могут быть `null`, если значение неизвестно.

Ошибки:

| Статус | code | Когда |
|---|---|---|
| 404 | `NOT_FOUND` | Машины с таким slug нет |
| 500 | `INTERNAL` | Непредвиденная ошибка (детали пишутся в лог, клиенту не отдаются) |

```json
{ "error": { "code": "NOT_FOUND", "message": "car not found" } }
```

## Служебные эндпоинты

- `GET /health/live` отвечает `200 {"status":"ok"}`.
- `GET /health/ready` отвечает `200`, если база доступна, иначе `503`.
