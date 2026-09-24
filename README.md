# My Cars Lib

Сайт-библиотека автомобилей: поиск по каталогу, страница каждой машины с фото, характеристиками, историей марки и ссылками на auto.ru и Авито.

**Стек:** React 19 + TypeScript + Vite · [Astryx](https://astryx.atmeta.com/) (UI) · Zustand · Go + Gin · SQLite · golang-migrate.
Разработка ведётся по SDD (Specification-Driven Development), см. [docs/SDD-GUIDE.md](docs/SDD-GUIDE.md).

## Быстрый старт (macOS)

### 1. Установить инструменты (один раз)

```bash
brew install go node           # Go ≥ 1.25, Node ≥ 20
brew install golangci-lint     # необязательно, для make lint
```

### 2. Скачать зависимости

```bash
cd ~/Documents/dev/my-cars-lib
cd backend && go mod tidy && cd ..    # Go-модули (создаст go.sum)
cd frontend && npm install && cd ..   # npm-пакеты
```

### 3. Запустить (в двух окнах терминала)

```bash
make backend    # API на http://localhost:8080
make frontend   # сайт на http://localhost:5173
```

Откройте http://localhost:5173.

При первом запуске бэкенд сам создаёт файл базы `backend/data/cars.db` и применяет миграции из `backend/migrations/`, поэтому 10 машин появятся автоматически.

### Проверки

```bash
make test                       # Go-тесты + проверка типов TS
cd frontend && npm test         # unit-тесты фронтенда (vitest)
make -C backend lint            # go vet + golangci-lint
```

## Структура

```
memory/        продукт и «конституция» проекта (SDD)
specs/001-*/   спецификация, план, модель данных, API-контракт, задачи, аудит
backend/       Go API (cmd/server, internal/{car,httpapi,storage,config}, migrations)
frontend/      React-приложение (src/{api,store,pages,components,lib})
```

## API

| Метод | Путь | Что возвращает |
|---|---|---|
| GET | `/api/v1/cars?q=` | список машин (краткая форма), `q` — необязательный поиск |
| GET | `/api/v1/cars/{slug}` | всё о машине: характеристики, фото, марка, ссылки |
| GET | `/health/live`, `/health/ready` | проверки живости |

Подробности: [specs/001-cars-library/contracts/api.md](specs/001-cars-library/contracts/api.md).

```bash
curl -s localhost:8080/api/v1/cars | head -c 400
curl -s localhost:8080/api/v1/cars/lada-vesta
```

## Работа с базой данных

База — один файл `backend/data/cars.db` (SQLite). Посмотреть данные:

- **GUI:** [DB Browser for SQLite](https://sqlitebrowser.org/) (`brew install --cask db-browser-for-sqlite`) → Open Database → `backend/data/cars.db`.
- **Терминал** (`sqlite3` уже есть в macOS):

```bash
sqlite3 backend/data/cars.db
sqlite> .tables
sqlite> .mode box
sqlite> SELECT slug, model, year_from FROM cars;
sqlite> SELECT c.slug, s.power_hp FROM cars c JOIN car_specs s ON s.car_id = c.id ORDER BY s.power_hp DESC;
sqlite> .quit
```

Таблицы: `brands` (марки) → `cars` (модели) → `car_specs` (характеристики, 1:1) и `car_images` (фото, 1:N). Схема: [data-model.md](specs/001-cars-library/data-model.md).

Сбросить базу к исходному состоянию: `make db-reset` и перезапустить бэкенд.

## Как добавить новую машину

Данные меняются **только новыми миграциями**. Уже применённые файлы не редактируем.

1. Создайте два файла в `backend/migrations/` со следующим номером:
   - `000003_add_toyota_rav4.up.sql` — что добавить;
   - `000003_add_toyota_rav4.down.sql` — как откатить.
2. В `.up.sql` скопируйте блок одной машины из `000002_seed_cars.up.sql` и поменяйте значения. Если марки ещё нет — сначала `INSERT INTO brands ...`.
3. В `.down.sql`:
   ```sql
   DELETE FROM cars WHERE slug = 'toyota-rav4';   -- specs и фото удалятся каскадно
   ```
4. Перезапустите `make backend` — миграция применится сама, машина появится на сайте.

Фото удобно брать с [Wikimedia Commons](https://commons.wikimedia.org): откройте файл → «Use this file» → ссылка на картинку; автора и лицензию запишите в `car_images`.

## Git

```bash
git add -A
git commit -m "feat: ..."
git push
```

Сообщения коммитов по фазам — в [specs/001-cars-library/tasks.md](specs/001-cars-library/tasks.md).

## Лицензии фото

Фотографии загружаются с Wikimedia Commons (CC0, CC BY, CC BY-SA); автор и лицензия показываются под каждым фото на странице машины. Технические характеристики — справочные.
