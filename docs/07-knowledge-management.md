# Codebase Knowledge Management

Your codebase knowledge goes stale as you build. Here's how to keep it fresh.

## When to Re-Map / Re-Index

| Trigger | Action | Why |
|---------|--------|-----|
| **Project start (brownfield)** | `/gsd:map-codebase` + `/sc:index-repo` | Baseline understanding |
| **After every 2-3 phases** | `/gsd:map-codebase` | Architecture may have shifted |
| **After major refactors** | `/gsd:map-codebase` + `/sc:index-repo` | Structure has changed significantly |
| **New session on large project** | `/sc:index-repo` (if stale) | Token-efficient session bootstrap |
| **Before milestone audit** | `/gsd:map-codebase` | Auditor needs current state |
| **After adding new integrations** | `/gsd:map-codebase` | INTEGRATIONS.md needs updating |
| **When planning touches unfamiliar areas** | Serena `get_symbols_overview` | Targeted understanding |
| **When context window is tight** | `/sc:index-repo` | 94% token reduction (58K -> 3K) |

## The Two Mapping Tools

```
/gsd:map-codebase                         /sc:index-repo
-----------------                         --------------
Creates 7 deep analysis documents         Creates 1 compact index file
.planning/codebase/                        PROJECT_INDEX.md + .json
  STACK.md
  ARCHITECTURE.md                         ~3KB (94% token reduction)
  STRUCTURE.md
  CONVENTIONS.md                          Purpose: Token-efficient session
  TESTING.md                              bootstrap. Read this INSTEAD of
  INTEGRATIONS.md                         reading the whole codebase.
  CONCERNS.md
                                          Best for: Start of sessions,
Purpose: Deep understanding for           context pressure situations,
planning and execution.                   quick orientation.

Best for: Before planning phases,         Update: When structure changes
brownfield onboarding, audits.            significantly.

Update: Every 2-3 phases or after
major structural changes.
```

## Serena Memories — Persistent Project Knowledge

Unlike GSD's `.planning/` files (which are git-tracked), Serena memories persist across all conversations:

```
Serena: write_memory                      # Save insight
  "auth-architecture"                     # e.g., "Our auth uses JWT with refresh rotation..."

Serena: list_memories                     # Check what's stored
Serena: read_memory "auth-architecture"   # Recall in future session
```

### When to Write Memories

- After discovering non-obvious architectural patterns
- When you've debugged a tricky issue (save the root cause)
- Domain-specific knowledge that would be expensive to re-discover
- Integration quirks or gotchas
- "This is NOT documented anywhere but it matters"
