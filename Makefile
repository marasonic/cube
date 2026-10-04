.PHONY: build fmt vet test check

build:
	go build -o bin/cube .

fmt:
	@out=$$(gofmt -l .); if [ -n "$$out" ]; then echo "gofmt needed on:"; echo "$$out"; exit 1; fi

vet:
	go vet ./...

test:
	go test ./...

check: fmt vet test
