# Manager API

The manager exposes a small HTTP API for submitting tasks, stopping tasks, and listing tasks and worker nodes.

By default it listens on `0.0.0.0:5555`. Start it with:

```sh
cube manager --host 0.0.0.0 --port 5555 --workers localhost:5556
```

All endpoints accept and return JSON. Field names match the Go struct fields exactly (`ID`, `State`, `Timestamp`, and so on).

## Task states

`State` is sent and returned as an integer:

| Value | Name        |
| ----- | ----------- |
| 0     | `Pending`   |
| 1     | `Scheduled` |
| 2     | `Running`   |
| 3     | `Completed` |
| 4     | `Failed`    |

## Endpoints

### `POST /tasks`

Submits a task event. The manager queues it and schedules the task on a worker.

Unknown JSON fields are rejected.

Request body (`TaskEvent`):

```json
{
  "ID": "6f1c1b7e-2f0a-4c4e-9d4a-3b6f0c1e2a10",
  "State": 1,
  "Timestamp": "2026-10-04T10:00:00Z",
  "Task": {
    "ID": "0b9d6c52-7e1a-4f4e-8c3d-5a2b1f0e9d11",
    "Name": "web",
    "Image": "nginx:latest",
    "Cpu": 0.5,
    "Memory": 256,
    "Disk": 1,
    "ExposedPorts": { "80/tcp": {} },
    "RestartPolicy": "always"
  }
}
```

- `Memory` is in MiB and `Disk` is in GiB, as documented on the `Config` type.
- `State: 1` (`Scheduled`) is what a new task event normally carries.

Responses:

| Status | Meaning |
| ------ | ------- |
| `201`  | Accepted. The body is the submitted `Task`. |
| `400`  | The body is not valid JSON for `TaskEvent`, or it has unknown fields. The body is `{"HTTPStatusCode": 400, "Message": "..."}`. |

### `GET /tasks`

Returns all tasks known to the manager, as a JSON array of `Task` objects.

| Status | Meaning |
| ------ | ------- |
| `200`  | The task list. |

### `DELETE /tasks/{taskID}`

Stops a task. The manager records a `Completed` event for the task, and the worker stops the container.

`taskID` is the task's UUID.

| Status | Meaning |
| ------ | ------- |
| `204`  | The stop request was accepted. The container may still be stopping. |
| `404`  | No task with that ID exists. An ID that is not a valid UUID also returns `404`. |

### `GET /nodes`

Returns the worker nodes the manager knows about, as a JSON array of `Node` objects, including memory, disk, role, task count, and stats.

| Status | Meaning |
| ------ | ------- |
| `200`  | The node list. |

## Example

Submit a task:

```sh
curl -X POST http://localhost:5555/tasks \
  -H 'Content-Type: application/json' \
  -d @task-event.json
```

List tasks:

```sh
curl http://localhost:5555/tasks
```

Stop a task:

```sh
curl -X DELETE http://localhost:5555/tasks/0b9d6c52-7e1a-4f4e-8c3d-5a2b1f0e9d11
```
