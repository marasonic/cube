.PHONY: vet test check

vet:
	go vet ./...

test:
	go test ./...

check: vet test
