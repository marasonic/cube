.PHONY: build vet test check

build:
	go build -o bin/cube .

vet:
	go vet ./...

test:
	go test ./...

check: vet test
