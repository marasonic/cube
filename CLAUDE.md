# Cube

Go orchestrator that runs tasks as Docker containers. A manager schedules tasks on workers. See `README.md` for the project history.

## Read first

Before changing code, read these:

- `docs/architecture.md`: packages, deployment, task flow, and the task lifecycle.
- `docs/manager-api.md` and `docs/openapi-manager.yaml`: manager HTTP API.
- `docs/openapi-worker.yaml`: worker HTTP API.

Keep the docs in sync with the code. If a change alters an endpoint, a state transition, or the flow, update the matching doc in the same PR.

## Commands

- `make build`: builds `bin/cube`.
- `make check`: runs `fmt`, `vet`, and `test`. CI runs the same target.
- `make test`, `make vet`, `make fmt`: individual checks.

Run `make check` before every commit that changes code. It must pass before a PR can merge.

## Workflow

- Never push to `main`. Create a feature branch, push it, and open a PR into `main`.
- Branch names: `fix/...`, `feat/...`, `chore/...`, or `docs/...`.
- Merge only with the user's approval.
- Do not delete branches, close PRs, or push to `main` without asking.
- PR descriptions include a summary and a test plan.
- Do not add `Co-Authored-By` trailers or "Generated with Claude Code" lines to commits or PRs.

## Conventions

- Format with `gofmt`. `make fmt` fails on unformatted files.
- Follow the style of the surrounding code.
- Do not commit binaries or `bin/`. Build output is git-ignored.

## Known issues

- Worker `DELETE /tasks/{taskID}` panics for an unknown task instead of returning 404. Tracked in issue #19.
