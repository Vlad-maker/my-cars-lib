# Исследование: 001 Библиотека автомобилей

> Артефакт фазы 5 (`/plan`). Здесь записано, почему выбраны именно эти решения.

## R-1. База данных: SQLite
- **Решение:** SQLite, один файл `backend/data/cars.db`.
- **Почему:** не нужен сервер и Docker, базу легко открыть в GUI (DB Browser for SQLite, TablePlus) или через `sqlite3` в терминале, который на macOS уже есть. SQL тот же, что и в «больших» СУБД, поэтому знания переносятся на PostgreSQL.
- **Альтернатива:** PostgreSQL в Docker. Отложена до деплоя.

## R-2. Драйвер: `modernc.org/sqlite` вместо GORM
- `go-standards` рекомендует GORM, но только для PostgreSQL. Для SQLite у GORM есть два драйвера: один требует CGO (`mattn/go-sqlite3`), другой (`glebarez/sqlite`) регистрирует драйвер `sqlite` и конфликтует с `golang-migrate`.
- **Решение:** `database/sql` + `modernc.org/sqlite` (чистый Go, без CGO) + явные SQL-запросы в репозитории. Для учебного проекта это даже плюс: видно настоящий SQL.

## R-3. Миграции: `golang-migrate` + `embed`
- Стандарт `go-standards`. SQL-файлы лежат в `backend/migrations/` и вшиваются в бинарник через `//go:embed`. При старте сервер применяет новые миграции сам.
- Стартовые данные тоже оформлены миграцией (`000002_seed_cars.up.sql`). Добавить машину значит добавить файл `00000N_add_<car>.up.sql`.

## R-4. HTTP: Gin
- Стандарт `go-standards/references/libraries.md`.

## R-5. Структура бэкенда: плоская
- По критериям `go-clean-architecture`: домен тонкий (только чтение), транспорт один, разработчик один. Поэтому `internal/car` содержит модель, сервис и SQLite-репозиторий. Четыре слоя были бы переусложнением.

## R-6. UI: Astryx
- `@astryxdesign/core` 0.6.x, React ≥ 19, peer-зависимость `@stylexjs/stylex`.
- Для Vite нужен плагин `astryxStylex()` из `@astryxdesign/build/vite` (так сделано в официальном `apps/example-vite`).
- Компоненты, которые используем: `AppShell`/`TopNav`, `TextInput`, `Grid`, `ClickableCard`, `Card`, `Heading`, `Text`, `Badge`, `Carousel` или `Thumbnail`, `MetadataList`/`Table`, `Button`/`Link`, `Breadcrumbs`, `EmptyState`, `Skeleton`, `Banner`.

## R-7. Состояние: Zustand
- Лёгкий, без бойлерплейта. Стор `useCarsStore`: список, статус загрузки, строка поиска, кэш деталей по slug.

## R-8. Фото: Wikimedia Commons
- Прямые URL вида `upload.wikimedia.org/wikipedia/commons/thumb/<a>/<ab>/<file>/1280px-<file>`. Лицензии CC0, CC BY, CC BY-SA требуют указать автора и лицензию, поэтому показываем подпись под фото.

## R-9. Ссылки на агрегаторы
- auto.ru: `https://auto.ru/cars/<brand>/<model>/all/`
- Авито: `https://www.avito.ru/all/avtomobili/<brand>/<model>`
- Ссылки хранятся в БД целиком, поэтому, если формат URL у агрегатора поменяется, достаточно новой миграции.
