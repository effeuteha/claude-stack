# 01 — Architecture Overview

> **Four layers, clean separation of concerns.** Each layer has a distinct job; each tool has a home.

The stack is one coherent system with four layers — **Discipline, Strategic, Lifecycle, Code** — where each layer operates at a different abstraction level and each tool owns a single responsibility in exactly one layer. This chapter is the map. The rest of the guide is the territory.

## The four layers

![claude-stack architecture](../assets/architecture.svg)

### Discipline — Superpowers (how you work)

Superpowers is a plugin, but it behaves more like a set of commitments: brainstorm before building, write the failing test first, verify before claiming done, debug with method, work on an isolated worktree when the blast radius matters. Discipline wraps every other layer — you can use the right tool the wrong way, and that's what this layer prevents. Deep dive in [Chapter 02](02-discipline-layer.md).

### Strategic — SuperClaude (what to build and why)

`/sc:*` commands handle research, brainstorming, design, analysis, and multi-expert review (`/sc:spec-panel`, `/sc:business-panel`). This is the source of direction — it tells you *what* the right thing to build is, and surfaces the tradeoffs. It does not turn that direction into committed artifacts; that's the next layer down.

### Lifecycle — GSD (shepherding the work)

GSD (`/gsd:*`) runs the lifecycle: spec → discuss → plan → execute → verify → ship. Plus workstreams and threads for parallel work, and specialized phase types (`/gsd:ai-integration-phase`, `/gsd:ui-phase`, `/gsd:sketch`, `/gsd:spike`) for shapes that need extra rigor or extra permission to fail. GSD turns strategic direction into committed, reviewable artifacts under `.planning/`.

### Code — Serena + Context7 (manipulating the code)

Serena MCP gives you symbol-level navigation (`find_symbol`, `get_symbols_overview`, `replace_symbol_body`) and per-project memories. Context7 MCP gives you live library documentation — actual current APIs for React, Next.js, Prisma, whatever you're working in — not stale docs from training data. This is where code actually changes hands.

## Data flows between layers

```
Discipline (Superpowers) ---- wraps every action below ----

Strategic (SC) ----> Lifecycle (GSD) ----> Code (Serena + Context7)
      |                   |                           |
      +-- spec -->        plan --->                symbols/docs
      |                   |                           |
      +-- review <--------+                           |
                          |                           |
                          +----- verify <-------------+
```

The flow: strategic tools produce a spec; the spec flows into the lifecycle layer as a plan; the plan drives code-layer edits; verification results flow back up the chain to close the loop. Discipline wraps all of it — every layer's actions are bound by brainstorm-first, test-first, verify-before-complete. No layer short-circuits the ones above or below it.

## Where tools live

| Tool | Layer | Owns |
|---|---|---|
| Superpowers | Discipline | methodology skills (brainstorm, TDD, verify, debug, worktrees, subagents, plans) |
| SuperClaude (`/sc:*`) | Strategic | research, design, analyze, spec-panel, business-panel |
| GSD (`/gsd:*`) | Lifecycle | spec, plan, execute, verify, ship, workstreams, threads, forensics, audit-fix |
| Serena MCP | Code | symbol-level code navigation, memories |
| Context7 MCP | Code | live library documentation |
| Playwright MCP | Code (browser) | browser automation for web-UI workflows |
| Sequential Thinking MCP | Strategic | structured multi-step reasoning |
| Mysti | Strategic (GUI) | multi-model brainstorm in VSCode |
| `feature-dev` plugin | Strategic | guided feature discovery and architecture |
| `frontend-design` plugin | Code | production-grade UI component generation |
| `code-review` plugin | Discipline | standalone fresh-context code review |
| `claude-md-management` plugin | Code | `CLAUDE.md` audits and improvements |
| `claude-code-setup` plugin | Discipline | automation recommendations (hooks, skills, MCPs) |
| `remember` plugin | Discipline (memory) | per-session continuity |
| `ralph-loop` plugin | Discipline | run-loop automation |
| `graphify` plugin | Code | input-to-knowledge-graph |

## Why this model

The old three-layer model (Strategic → Lifecycle → Code) missed that Superpowers is *how* you work at every layer, not another step in the chain. A team using GSD without brainstorm-first will build the wrong spec correctly. A team with brainstorm-first + GSD will build the right spec correctly. That's the whole point of elevating Discipline: it makes the methodology shift visible before the tool tour, and it matches the reality that a team with discipline beats a team with more tools.

## What Gets Created

When you use GSD, it materializes a `.planning/` directory:

```
.planning/
|-- PROJECT.md            # Vision, goals
|-- ROADMAP.md            # Phase breakdown
|-- REQUIREMENTS.md       # REQ-IDs with v1/v2/out-of-scope
|-- STATE.md              # Living project memory
|-- config.json           # Workflow mode (interactive/yolo)
|-- research/             # Domain research artifacts
|-- codebase/             # Map artifacts (parallel mapper agents)
|-- graphs/               # /gsd:graphify knowledge graphs
+-- phases/               # Phase plans, specs, verification records, session reports
```

This state persists across sessions and is typically git-tracked, so your team's planning history travels with the code. See [Chapter 09 — Memory Systems](09-memory-systems.md) for how this relates to the other memory mechanisms in the stack.

## See also

- [02 Discipline Layer](02-discipline-layer.md) — deep dive on Superpowers
- [06 Workflow Phases](06-workflow-phases.md) — the GSD lifecycle in detail
- [03 Claude Code Internals](03-claude-code-internals.md) — what each layer runs on

---

**Prev:** [← 00 Getting Started](00-getting-started.md) | **Next:** [02 Discipline Layer →](02-discipline-layer.md)
