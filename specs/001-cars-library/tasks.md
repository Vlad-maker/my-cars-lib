# Задачи: 001 Библиотека автомобилей

> SDD, фаза 6 (генерация задач из plan.md). Каждая задача заканчивается проверкой. `[P]` означает, что задачу можно делать параллельно с соседними.
> Отмечаем `[x]` по мере выполнения. После каждой фазы делаем коммит (сообщение указано в конце фазы).

## Фаза A. Каркас репозитория
- [x] T001 Структура каталогов, `.gitignore`, корневой `Makefile`, `README.md` → `ls`
- [x] T002 SDD-артефакты: product, constitution, spec, plan, research, data-model, contracts, tasks → ревью
> Коммит: `docs: add SDD artifacts for cars library (spec 001)`

## Фаза B. База данных
- [x] T010 `migrations/000001_init.up.sql` / `.down.sql`: таблицы по data-model.md → `sqlite3 :memory: < 000001_init.up.sql`
- [x] T011 `migrations/000002_seed_cars.up.sql` / `.down.sql`: 10 марок, 10 машин, характеристики, 30 фото → тест `TestMigrate_SeedsTenCars`
- [x] T012 `migrations/embed.go` (`//go:embed *.sql`) → `go build ./...`
> Коммит: `feat(db): add SQLite schema and seed data for 10 cars`

## Фаза C. Бэкенд (Go)
- [x] T020 `go.mod`, `internal/config`: чтение env с дефолтами + тест → `go test ./internal/config`
- [x] T021 `internal/storage`: `Open` + `Migrate` + тест на in-memory БД → `go test ./internal/storage`
- [x] T022 `internal/car`: модели, `ErrNotFound`, `Repository`, `Service` + unit-тесты с фейковым репозиторием → `go test ./internal/car`
- [x] T023 `internal/car/sqlite_repository.go`: `List(q)`, `GetBySlug` + интеграционный тест на реальных миграциях → `go test ./internal/car`
- [x] T024 `internal/httpapi`: роутер, `/api/v1/cars`, `/api/v1/cars/:slug`, `/health/*`, формат ошибок, CORS + тесты через `httptest` → `go test ./internal/httpapi`
- [x] T025 `cmd/server/main.go`: wiring, graceful shutdown → `go run ./cmd/server` + `curl localhost:8080/api/v1/cars`
- [x] T026 `.golangci.yml`, `Makefile` (run/test/lint) → `make -C backend test`
> Коммит: `feat(backend): Go API for cars list and car details`

## Фаза D. Фронтенд (React)
- [x] T030 Vite + React + TS, Astryx + тема, `astryxStylex()`, proxy `/api` → `npm run build`
- [x] T031 `src/api`: типы и `fetchCars` / `fetchCar` → `tsc -b`
- [x] T032 `src/store/carsStore.ts` + `filterCars` → `tsc -b`
- [x] T033 Layout (`AppShell` + `TopNav`), роутинг → ручная проверка
- [x] T034 HomePage: поиск, сетка `CarCard`, скелетон, пустое состояние, ошибка → AC-1.1…1.6
- [x] T035 CarPage: хлебные крошки, галерея, основная информация, характеристики, история марки, кнопки агрегаторов, 404 → AC-2.1…2.7
> Коммит: `feat(frontend): React UI with Astryx for cars list and car page`

## Фаза E. Проверка
- [x] T040 Аудит соответствия спеке (`audit-report.md`)
- [ ] T041 E2E: запуск обоих сервисов, прогон всех AC в браузере
- [x] T042 README: запуск, добавление машины, работа с БД
> Коммит: `docs: add audit report and run instructions`
