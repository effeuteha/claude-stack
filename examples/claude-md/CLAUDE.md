# CLAUDE.md

<!--
  TEMPLATE + EXAMPLE

  This file has two parts:
  1. A filled-in example (TaskFlow project) showing what good looks like
  2. Annotations (HTML comments) explaining each section

  To use: copy this file, delete the TaskFlow content, fill in your own.
  Target: under 200 lines. Split into .claude/rules/ if larger.
  Commit to git. Use CLAUDE.local.md (gitignored) for personal preferences.
-->

## Project Overview

<!-- What is this project? 2-3 sentences max. -->

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

<!-- Show your project structure. Include data flow if not obvious. -->

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

<!--
  ONLY put rules here that Claude has violated or could easily get wrong.
  Don't document obvious things. Focus on surprises and gotchas.
  Use CORRECT/WRONG format — Claude responds well to concrete examples.
-->

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

<!-- Only if relevant. Focus on patterns Claude needs to follow. -->

- JWT auth with 15-min access tokens, 7-day refresh tokens
- All user input validated via Pydantic schemas
- Rate limiting: 100 req/min per user (configurable)
- CORS: frontend origin only in production

## Superpowers expectations

<!--
  If your team uses the Superpowers plugin, document which discipline
  commitments you expect Claude (and teammates) to honor on this project.
  These are enforced by Superpowers skills that auto-trigger on matching
  context — listing them here clarifies WHEN they apply on this codebase.
-->

Team norms on this project:

- **brainstorm-first:** invoke `/superpowers:brainstorming` (or `/gsd-spec-phase`) before any new feature work.
- **TDD:** write the failing test before any implementation code.
- **verify-before-complete:** no `done` / `fixed` claim without running the verification command and citing output.
- **git worktrees:** for parallel feature work, use `git worktree add` to avoid checkout pollution.
- **cross-AI review:** high-stakes plans (AI integration, security-sensitive, data migrations) get both `/sc:spec-panel` (multi-expert in Claude) AND `/gsd-review` (cross-AI peer review).

Corresponding skills auto-trigger on matching context; see `.claude/plugins/.../superpowers/` for the full set.

## Testing

```bash
make test                         # All tests
pytest tests/api/ -v              # API tests only
pytest tests/services/ -v         # Service tests only
cd frontend && npm test           # Frontend tests
```

## Documentation Index

<!-- Point to detailed docs. Only include docs that exist. -->

| Doc | When to Read |
|-----|-------------|
| docs/API.md | Working on API endpoints |
| docs/EVENTS.md | Working on real-time features |
| docs/DEPLOY.md | Deployment procedures |
