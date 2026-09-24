---
spec: 001-cars-library
status: planned
---

# План реализации: 001 Библиотека автомобилей

> SDD, фаза 5 (`/plan`). Здесь описано, **как** будем строить: архитектура, контракты и структура файлов. Тела функций в план не пишем (правило `go-code-planning`), код появляется только при реализации.

Связанные документы: [spec.md](spec.md) · [research.md](research.md) · [data-model.md](data-model.md) · [contracts/api.md](contracts/api.md) · [tasks.md](tasks.md)

## Архитектура

```
Браузер ──► Vite dev server :5173 ──(proxy /api)──► Go/Gin :8080 ──► SQLite (data/cars.db)
            React + Astryx + Zustand                 internal/httpapi → internal/car
```

В режиме разработки Vite проксирует `/api` на бэкенд, поэтому настраивать CORS в dev не нужно. Бэкенд всё равно разрешает `http://localhost:5173` через переменную `CORS_ORIGINS`.

## Структура репозитория

```
my-cars-lib/
├── memory/            product.md, constitution.md        (SDD фазы 1–2)
├── specs/001-.../     spec, plan, research, data-model, contracts, tasks, audit
├── plans/ todos/ event-stream.md                          (SDD-синхронизация)
├── backend/
│   ├── cmd/server/main.go        точка входа: только wiring
│   ├── internal/config/          конфиг из env
│   ├── internal/car/             модель, сервис, SQLite-репозиторий, ошибки
│   ├── internal/storage/         открытие SQLite + применение миграций
│   ├── internal/httpapi/         Gin-роутер, хендлеры, формат ответов
│   ├── migrations/               *.sql + embed.go
│   ├── Makefile, .golangci.yml, go.mod
├── frontend/
│   ├── src/api/                  типы и функции запросов
│   ├── src/store/                Zustand-стор
│   ├── src/pages/                HomePage, CarPage, NotFoundPage
│   ├── src/components/           CarCard, Gallery, SpecsSection, ...
│   └── vite.config.ts            astryxStylex() + proxy
└── Makefile                      make backend / make frontend / make test
```

## Контракты бэкенда

```go
package car

// Summary: элемент списка. Detail: полная карточка.
type Summary struct { Slug, Brand, Model, Generation, BodyType, Aliases string; YearFrom int; YearTo *int; PowerHP int; CoverImageURL *string }
type Detail  struct { Slug, Model, Generation, BodyType, CarClass, Description string; YearFrom int; YearTo *int; Brand Brand; Specs Specs; Images []Image; Links Links }

var ErrNotFound = errors.New("car not found")

// Repository объявлен в пакете car, потому что его потребитель — Service.
type Repository interface {
    List(ctx context.Context) ([]Summary, error)                // все машины, sort_order
    GetBySlug(ctx context.Context, slug string) (Detail, error) // ErrNotFound
}

type Service struct{ /* repo Repository */ }
func NewService(repo Repository) *Service
func (s *Service) List(ctx context.Context, query string) ([]Summary, error) // фильтрация по query в Go (см. примечание)
func (s *Service) Get(ctx context.Context, slug string) (Detail, error)   // валидация slug → ErrNotFound

func NewSQLiteRepository(db *sql.DB) *SQLiteRepository
```

```go
package httpapi

// CarService объявлен здесь, потому что его потребитель — хендлер.
type CarService interface {
    List(ctx context.Context, query string) ([]car.Summary, error)
    Get(ctx context.Context, slug string) (car.Detail, error)
}
func NewRouter(cfg RouterConfig, cars CarService, db Pinger, log *slog.Logger) *gin.Engine
```

```go
package storage
func Open(ctx context.Context, path string) (*sql.DB, error)   // создаёт каталог, включает foreign_keys
func Migrate(db *sql.DB) error                                  // golang-migrate + embed, ErrNoChange не считается ошибкой
```

Конфиг (env): `HTTP_ADDR` (по умолчанию `:8080`), `DB_PATH` (`data/cars.db`), `CORS_ORIGINS` (`http://localhost:5173`), `LOG_LEVEL` (`info`).

Примечание (drift, исправлено при реализации): фильтрация `q` перенесена из SQL в `Service`, потому что `LOWER()` в SQLite не понимает кириллицу, а `strings.ToLower` в Go работает с Unicode. Для каталога из сотен машин это дёшево.

Ошибки: репозиторий возвращает `car.ErrNotFound` на `sql.ErrNoRows` и оборачивает остальные ошибки как `fmt.Errorf("query car %s: %w", slug, err)`. Хендлер отдаёт 404 на `errors.Is(err, car.ErrNotFound)` и 500 на всё остальное (с логом).

## Контракты фронтенда

```ts
// src/api/types.ts повторяет contracts/api.md
export interface CarSummary { slug; brand; model; generation; year_from; year_to: number|null; body_type; power_hp; aliases; cover_image_url: string|null }
export interface CarDetail { ...; brand: Brand; specs: Specs; images: CarImage[]; links: {auto_ru; avito} }

// src/api/cars.ts
fetchCars(): Promise<CarSummary[]>
fetchCar(slug): Promise<CarDetail>          // бросает NotFoundError на 404

// src/store/carsStore.ts (Zustand)
{ cars, listStatus: 'idle'|'loading'|'ready'|'error', query, setQuery, loadCars(),
  details: Record<slug, CarDetail>, loadCar(slug) }
// selectFilteredCars(state): фильтрация по query (brand, model, generation, aliases)
```

Маршруты: `/` → HomePage, `/cars/:slug` → CarPage, `*` → NotFoundPage.

## Проверка

| Что | Команда |
|---|---|
| Бэкенд собирается | `cd backend && go build ./...` |
| Тесты бэкенда | `cd backend && go test ./...` |
| Линт бэкенда | `cd backend && go vet ./... && golangci-lint run` |
| Типы фронтенда | `cd frontend && npx tsc -b` |
| Сборка фронтенда | `cd frontend && npm run build` |
| E2E вручную | `make backend` + `make frontend`, открыть http://localhost:5173 |
