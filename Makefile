# Корневые команды проекта. Запускать из папки my-cars-lib.

backend:          ## Запустить Go API на :8080
	$(MAKE) -C backend run

frontend:         ## Запустить React dev-сервер на :5173
	cd frontend && npm run dev

install:          ## Скачать зависимости (Go-модули и npm-пакеты)
	cd backend && go mod download
	cd frontend && npm install

test:             ## Тесты бэкенда и проверка типов фронтенда
	$(MAKE) -C backend test
	cd frontend && npm run typecheck

db-reset:         ## Удалить локальную БД (пересоздастся при старте бэкенда)
	$(MAKE) -C backend db-reset

.PHONY: backend frontend install test db-reset
