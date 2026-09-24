#!/usr/bin/env bash
# Устанавливает зависимости и прогоняет все проверки проекта.
# Результат пишется в .check.log (его читает Claude).
# Запуск:  bash scripts/check.sh
set -u
cd "$(dirname "$0")/.."
LOG=".check.log"
exec > >(tee "$LOG") 2>&1

step() { echo; echo "=== $* ==="; }
fail=0
# run <dir> <command...>: выполняет команду в каталоге, запоминает ошибку
run() { local dir=$1; shift; (cd "$dir" && "$@") || { echo "!!! FAILED: $*"; fail=1; }; }

step "Инструменты"
for t in go node npm; do
  if command -v "$t" >/dev/null; then echo "$t: $($t version 2>/dev/null || $t --version)"; else echo "!!! $t не установлен: brew install go node"; fail=1; fi
done
[ $fail -ne 0 ] && exit 1

step "Backend: go mod tidy"
run backend go mod tidy
step "Backend: go vet"
run backend go vet ./...
step "Backend: go test"
run backend go test -race ./...
step "Backend: build"
run backend go build -o bin/server ./cmd/server

step "Frontend: npm install"
run frontend npm install --no-fund --no-audit
step "Frontend: typecheck"
run frontend npm run typecheck
step "Frontend: unit tests"
run frontend npm test
step "Frontend: build"
run frontend npm run build

echo
[ $fail -eq 0 ] && echo "ВСЕ ПРОВЕРКИ ПРОЙДЕНЫ" || echo "ЕСТЬ ОШИБКИ, см. выше"
