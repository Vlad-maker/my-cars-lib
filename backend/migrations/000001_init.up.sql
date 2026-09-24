-- 000001_init: базовая схема каталога автомобилей.
-- См. specs/001-cars-library/data-model.md

CREATE TABLE brands (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    slug         TEXT    NOT NULL UNIQUE,
    name         TEXT    NOT NULL,
    country      TEXT    NOT NULL,
    founded_year INTEGER NOT NULL,
    history      TEXT    NOT NULL
);

CREATE TABLE cars (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    slug        TEXT    NOT NULL UNIQUE,
    brand_id    INTEGER NOT NULL REFERENCES brands (id),
    model       TEXT    NOT NULL,
    generation  TEXT    NOT NULL,
    year_from   INTEGER NOT NULL,
    year_to     INTEGER,
    body_type   TEXT    NOT NULL,
    car_class   TEXT    NOT NULL,
    description TEXT    NOT NULL,
    aliases     TEXT    NOT NULL DEFAULT '',
    auto_ru_url TEXT    NOT NULL,
    avito_url   TEXT    NOT NULL,
    sort_order  INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_cars_brand_id ON cars (brand_id);

CREATE TABLE car_specs (
    car_id             INTEGER PRIMARY KEY REFERENCES cars (id) ON DELETE CASCADE,
    version_note       TEXT    NOT NULL,
    engine_type        TEXT    NOT NULL,
    engine_volume_cc   INTEGER,
    power_hp           INTEGER NOT NULL,
    torque_nm          INTEGER NOT NULL,
    transmission       TEXT    NOT NULL,
    drive              TEXT    NOT NULL,
    acceleration_s     REAL,
    top_speed_kmh      INTEGER,
    fuel_consumption_l REAL,
    fuel_tank_l        INTEGER,
    length_mm          INTEGER NOT NULL,
    width_mm           INTEGER NOT NULL,
    height_mm          INTEGER NOT NULL,
    wheelbase_mm       INTEGER NOT NULL,
    curb_weight_kg     INTEGER,
    trunk_l            INTEGER,
    seats              INTEGER NOT NULL
);

CREATE TABLE car_images (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    car_id     INTEGER NOT NULL REFERENCES cars (id) ON DELETE CASCADE,
    url        TEXT    NOT NULL,
    source_url TEXT    NOT NULL,
    author     TEXT    NOT NULL,
    license    TEXT    NOT NULL,
    position   INTEGER NOT NULL,
    UNIQUE (car_id, position)
);
