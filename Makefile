.PHONY: build vet test check

build:
	go build ./...

vet:
	go vet ./...

test:
	go test ./...

check: vet test
