run:
	go run ./cmd/server

test:
	go test -race ./...

lint:
	go vet ./...
	golangci-lint run ./...

build:
	go build -o bin/server ./cmd/server

# Reset the local database (it will be recreated from migrations on next run).
db-reset:
	rm -f data/cars.db

.PHONY: run test lint build db-reset
