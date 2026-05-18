# 08 — Codebase Knowledge Management

Your codebase knowledge goes stale as you build. This chapter is about keeping the map fresh — the tools that materialize the codebase as text so Claude can reason about it without reading every file every session.

(Memory systems — `CLAUDE.md`, auto-memory, Serena memories, GSD state, `remember` — are covered in [09 Memory Systems](09-memory-systems.md). This chapter covers the *codebase-mapping* tools specifically.)

## When to re-map / re-index

| Trigger | Action | Why |
|---|---|---|
| **Project start (brownfield)** | `/gsd:map-codebase` + `/sc:index-repo` | Baseline understanding |
| **After every 2–3 phases** | `/gsd:map-codebase` | Architecture may have shifted |
| **After major refactors** | `/gsd:map-codebase` + `/sc:index-repo` | Structure has changed significantly |
| **New session on large project** | `/sc:index-repo` (if stale) | Token-efficient session bootstrap |
| **Before milestone audit** | `/gsd:map-codebase` | Auditor needs current state |
| **After adding new integrations** | `/gsd:map-codebase` | `INTEGRATIONS.md` needs updating |
| **When planning touches unfamiliar areas** | Serena `get_symbols_overview` | Targeted understanding |
| **When context window is tight** | `/sc:index-repo` | Big token savings (3 KB vs 58 KB) |
| **Quick project assessment** | Serena `get_symbols_overview` | Targeted scope; doesn't require a full map |

## Codebase mapping — four tools

### `/gsd:map-codebase` — deep parallel analysis

Dispatches parallel mapper agents, each focused on one dimension, and writes documents directly to `.planning/codebase/`:

```
.planning/codebase/
  STACK.md              # technologies, versions
  ARCHITECTURE.md       # component boundaries, data flow
  STRUCTURE.md          # directory layout, naming
  CONVENTIONS.md        # coding style, patterns
  TESTING.md            # test strategy, coverage gaps
  INTEGRATIONS.md       # external systems, APIs
  CONCERNS.md           # known issues, tech debt
```

**Best for:** before planning a non-trivial phase; brownfield onboarding; milestone audits.

**Update cadence:** every 2–3 phases, or after structural changes.

### `/sc:index-repo` — compact index for session bootstrap

Creates `PROJECT_INDEX.md` + `.json` — one compact file (~3 KB) that replaces ~58 KB of codebase reading per session.

**Best for:** the start of every session on a large project; tight-context situations; quick orientation.

**Update:** when structure changes significantly.

### `/gsd:ns-context` — the codebase-intelligence cluster landing page

Once intel exists under `.planning/codebase/`, the work splits across a few commands rather than one umbrella `intel` verb. `/gsd:ns-context` is the namespace page that surfaces them:

```
/gsd:ns-context                              # Landing page: map | graphify | docs | learnings
/gsd:map-codebase                            # Re-run the deep mapper (regenerates all 7 docs)
/gsd:map-codebase --focus ARCHITECTURE       # Re-run just one document
/gsd:graphify                                # Build/query the project knowledge graph
/gsd:docs-update                             # Generate or refresh project docs verified against code
/gsd:extract-learnings                       # Pull decisions / lessons / surprises from phase artifacts
```

To *query* the intel files, just read them — they're plain Markdown in `.planning/codebase/`. The old `/gsd:intel query` verb was replaced by direct reads (Serena's `read_file` or grep) because LLM-level question-answering over a few Markdown files turned out to be cheaper than dispatching a query agent.

## Knowledge graphs

Two complementary graph tools — different scopes.

### `/gsd:graphify` — project knowledge graph

Builds, queries, and inspects the project's knowledge graph stored in `.planning/graphs/`. The graph captures relationships between components, requirements, decisions, and artifacts — enabling structural queries like "what phases depend on the auth subsystem?"

**Best for:** large multi-milestone projects where the graph becomes a navigation aid; audits that need relationship queries.

### `graphify` plugin (`/graphify`)

General-purpose: any input (code, docs, papers, images) → knowledge graph → clustered communities → HTML + JSON + audit report.

**Best for:** one-off knowledge-structuring work; converting research notes into a navigable graph; exploratory analysis of an external corpus.

The two don't overlap: `/gsd:graphify` is scoped to the current GSD-managed project; `/graphify` is a standalone tool for arbitrary input.

## Serena symbol navigation — the "point of contact" layer

When planning or executing a change, you often want to understand one specific symbol — a class, a function, a route handler — not the whole codebase. Serena's symbol-level tools are the right scope:

```
Serena: find_symbol "UserService"                    # Where is it?
Serena: get_symbols_overview "backend/api.py"        # What's in this file?
Serena: find_referencing_symbols "authenticate"      # Who calls it?
Serena: replace_symbol_body "UserService.login"      # Rewrite a whole method
Serena: search_for_pattern "@deprecated"             # Regex across codebase
```

For *curated* project knowledge ("here's why we decided X," "here's the recovery recipe for Y"), use Serena memories — see [09 Memory Systems](09-memory-systems.md).

---

**Previous:** [Quality Scaling](07-quality-scaling.md) | **Next:** [Memory Systems](09-memory-systems.md)
