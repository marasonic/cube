# Cube

A Go orchestrator for running tasks in Docker containers, based on the code from chapter 12 of **Build an Orchestrator in Go** (Tim Boring).

## Starting point

The first commit (`Initial import: code from Build an Orchestrator in Go, chapter 12`) is the unmodified chapter 12 code. Every commit after it is my own work on top of that baseline.

Known issues in the baseline:

- `store/store.go` imports `"cube/task"`; it should be `"github.com/marasonic/cube/task"`.
- `task/` imports `github.com/docker/docker/...`, which is not listed in `go.mod` (`go.mod` uses `github.com/moby/moby/client`).

## Development

Requires Go (the version in `go.mod`) and `make`.

| Command | What it does |
| --- | --- |
| `make build` | Builds the `cube` binary to `bin/cube`. |
| `make fmt` | Fails if any file isn't formatted with `gofmt`. |
| `make vet` | Runs `go vet ./...`. |
| `make test` | Runs `go test ./...`. |
| `make check` | Runs `fmt`, `vet`, and `test`. Run it before pushing. |

Changes go through pull requests. Pushing directly to `main` is not allowed. CI runs `make check` on every PR to `main` and on every push to `main`, and a PR can only be merged once that check passes.
