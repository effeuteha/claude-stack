# CLAUDE.md

## Project Overview

**TaskFlow** — Team task management API with real-time updates.

| | |
|---|---|
| **Stack** | Python 3.12 + FastAPI + PostgreSQL 16 + Redis + React 19 + TypeScript |
| **Status** | Production (v2.1) |

## Quick Commands

```bash
source venv/bin/activate          # Environment
make dev                          # API at :8000/docs + frontend at :5173
make test                         # Run all tests (pytest + vitest)
make lint                         # Ruff + ESLint
make db-migrate                   # Run pending migrations
```

## Architecture

```
src/
├── api/
│   ├── routes/          # FastAPI route handlers
│   ├── middleware/       # Auth, rate limiting, CORS
│   └── deps.py          # Dependency injection
├── models/              # SQLAlchemy models
├── schemas/             # Pydantic request/response schemas
├── services/            # Business logic (TaskService, UserService)
├── repositories/        # Database queries (never raw SQL in routes)
└── events/              # Redis pub/sub for real-time updates

frontend/
├── src/components/      # React components
├── src/hooks/           # Custom hooks (useTask, useWebSocket)
├── src/lib/api.ts       # Generated API client (openapi-typescript)
└── src/pages/           # Route-level pages
```

**Data flow:** Route -> Service -> Repository -> PostgreSQL

## Critical Conventions

### Database Queries

```python
# CORRECT — always go through repositories
result = await task_repo.get_by_id(task_id)

# WRONG — no raw queries in routes or services
result = await db.execute("SELECT * FROM tasks WHERE id = :id", {"id": task_id})
```

### Authentication

```python
# CORRECT — use the dependency
@router.get("/tasks")
async def list_tasks(user: User = Depends(get_current_user)):
    ...

# WRONG — manual token parsing
token = request.headers.get("Authorization")
```

### Real-Time Events

```python
# CORRECT — emit events through EventService
await event_service.emit("task.updated", task_id, payload)

# WRONG — direct Redis publish (bypasses event schema validation)
await redis.publish("task.updated", json.dumps(payload))
```

## Security

- JWT auth with 15-min access tokens, 7-day refresh tokens
- All user input validated via Pydantic schemas
- Rate limiting: 100 req/min per user (configurable)
- CORS: frontend origin only in production

## Testing

```bash
make test                         # All tests
pytest tests/api/ -v              # API tests only
pytest tests/services/ -v         # Service tests only
cd frontend && npm test           # Frontend tests
```

## Documentation Index

| Doc | When to Read |
|-----|-------------|
| docs/API.md | Working on API endpoints |
| docs/EVENTS.md | Working on real-time features |
| docs/DEPLOY.md | Deployment procedures |
