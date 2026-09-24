# Аудит: 001 Библиотека автомобилей

> SDD, фаза 7 (`/audit`). Проверяем, что спека, план, задачи и код согласованы и не нарушают конституцию.
> Дата: 2026-09-24 · Итог: **PASS** (осталась ручная E2E-проверка T041)

## Покрытие критериев приёмки

| AC | Где реализовано | Чем проверено |
|---|---|---|
| AC-1.1 список с фото, маркой, поколением, кузовом, годами, мощностью | `HomePage`, `CarCard`; `GET /api/v1/cars` | `TestSQLiteRepository_List`, E2E |
| AC-1.2 фильтрация при вводе | `HomePage` + `filterCars` (Zustand `query`) | E2E |
| AC-1.3 регистр, подстрока, русские названия | `filterCars.ts`, `car.Service.List` + колонка `aliases` | `filterCars.test.ts`, `TestService_List` |
| AC-1.4 пустое состояние + сброс | `EmptyState` в `HomePage` | E2E |
| AC-1.5 клик → `/cars/<slug>` | `ClickableCard href` + `LinkProvider(RouterLink)` | E2E |
| AC-1.6 скелетон / ошибка + «Повторить» | `Skeleton`, `Banner` в `HomePage` | E2E (остановить бэкенд) |
| AC-2.1 галерея + автор/лицензия | `Gallery` | E2E |
| AC-2.2 основная информация | `CarPage` → `MetadataList` | E2E |
| AC-2.3 характеристики в 3 группах | `SpecsSection` | E2E |
| AC-2.4 история марки | `CarPage` (страна, год, текст) | `TestSQLiteRepository_GetBySlug` |
| AC-2.5 кнопки auto.ru / Авито в новой вкладке | `Button target=_blank` | E2E |
| AC-2.6 несуществующий slug → «Автомобиль не найден» | `CarPage` + `NotFoundError`; 404 `NOT_FOUND` в API | `TestGetCar/not_found`, `TestService_Get_InvalidSlug` |
| AC-2.7 хлебные крошки | `Breadcrumbs` в `CarPage` | E2E |
| AC-3.1 новая машина = новая миграция | `migrations/` + `storage.Migrate` при старте | `TestMigrate_IsIdempotent` |
| AC-3.2 инструкция в README | README → «Как добавить новую машину» | ревью |

## Соответствие конституции

| Статья | Статус | Комментарий |
|---|---|---|
| II. Стек | ✅ | React 19, Astryx 0.6, Zustand 5, Gin, SQLite (modernc), golang-migrate |
| III.1 плоская структура | ✅ | `internal/{car,httpapi,storage,config}` |
| III.2 `car` без HTTP | ✅ | закреплено правилом `depguard` в `.golangci.yml` |
| III.3 интерфейс у потребителя | ✅ | `car.Repository`, `httpapi.CarService` |
| III.4 обёртка ошибок | ✅ | `fmt.Errorf("...: %w")`, 404/500 только в хендлере |
| III.6 формат ответов | ✅ | `{"data"}` / `{"error":{"code","message"}}` |
| IV.2 fetch только в `src/api` | ✅ | |
| V.1 данные только миграциями | ✅ | |
| V.2 атрибуция фото | ✅ | автор + лицензия + ссылка под фото |

## Отклонения от плана (drift)

1. Поиск `q` перенесён из SQL в `car.Service`: `LOWER()` в SQLite не работает с кириллицей. План обновлён.
2. Отдельный пакет `internal/wiring` не понадобился: сборка зависимостей занимает ~10 строк в `cmd/server/main.go`.

## Замечания (не блокируют)

- Бандл фронтенда 585 КБ: при росте приложения стоит сделать code-splitting страниц (`React.lazy`).
- Характеристики справочные, их стоит сверить с официальными источниками при расширении каталога.
