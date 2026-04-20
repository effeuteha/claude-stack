# Tool Inventory

> **Tiered catalog.** Every tool in the stack, honest one-liner per entry. Use this as the definitive reference when you forget what something does or where it fits.

## Tier definitions

- **Core** — load-bearing in the golden path; removing one changes how you work.
- **Workflow** — meaningful to a specific phase or task shape; you reach for it on purpose.
- **On-Demand** — niche but sharp; installed, used occasionally, good to know exists.

Each entry carries: *what it is* · *one-line value* · *when to use* · *commands/trigger* · *what it pairs with*.

---

## Core

### Claude Code
- **What it is:** The CLI agent. Everything else plugs into it.
- **Value:** Without it, nothing else runs.
- **When:** Every day.
- **Trigger:** `claude` in any terminal.
- **Pairs with:** Every tool in this document.

### GSD
- **What it is:** Project lifecycle management — spec → discuss → plan → execute → verify → ship.
- **Value:** Turns vague requests into atomic, committed artifacts with a traceable history.
- **When:** Any non-trivial feature or phase.
- **Commands (~79):** `/gsd:progress`, `/gsd:spec-phase`, `/gsd:discuss-phase`, `/gsd:plan-phase`, `/gsd:execute-phase`, `/gsd:verify-work`, `/gsd:ship`, `/gsd:autonomous`, `/gsd:quick`, `/gsd:fast`, `/gsd:debug`, `/gsd:forensics`, `/gsd:audit-fix`, `/gsd:ai-integration-phase`, `/gsd:ui-phase`, `/gsd:sketch`, `/gsd:spike`, `/gsd:workstreams`, `/gsd:thread`, `/gsd:review`, `/gsd:map-codebase`, `/gsd:scan`, `/gsd:intel`, `/gsd:graphify`, `/gsd:pause-work`, `/gsd:resume-work`, `/gsd:session-report`, `/gsd:ship`, `/gsd:do`, `/gsd:help`, … (full list: `/gsd:help`)
- **Pairs with:** Superpowers (discipline wraps every call), SuperClaude (strategy feeds plan).

### SuperClaude
- **What it is:** Strategic thinking commands (`/sc:*`).
- **Value:** Brainstorm, design, analyze, review — the "what and why" layer above the lifecycle.
- **When:** Before planning; during review; during quality scan.
- **Commands (~33):** `/sc:research`, `/sc:brainstorm`, `/sc:design`, `/sc:analyze`, `/sc:spec-panel`, `/sc:business-panel`, `/sc:implement`, `/sc:test`, `/sc:improve`, `/sc:cleanup`, `/sc:pm`, `/sc:document`, `/sc:explain`, `/sc:troubleshoot`, `/sc:estimate`, `/sc:load`, `/sc:save`, `/sc:git`, `/sc:index-repo`, `/sc:index`, `/sc:recommend`, `/sc:reflect`, `/sc:workflow`, `/sc:task`, `/sc:spawn`, … (full list: `/sc:help`)
- **Pairs with:** GSD (strategy → lifecycle), Superpowers (discipline wraps every call).

### Superpowers
- **What it is:** Plugin with 14 discipline skills.
- **Value:** How you work — brainstorm-first, TDD, verify-before-complete, systematic-debugging, worktrees, subagent orchestration.
- **When:** Every conversation. Most skills auto-trigger on matching context.
- **Skills (14):** `using-superpowers`, `brainstorming`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `requesting-code-review`, `receiving-code-review`, `using-git-worktrees`, `dispatching-parallel-agents`, `finishing-a-development-branch`, `writing-skills`.
- **Pairs with:** Every layer — discipline is orthogonal.

### Serena MCP
- **What it is:** Semantic code intelligence via MCP.
- **Value:** Symbol-level navigation + per-project memories. No grepping for class definitions.
- **When:** Whenever you need to understand or edit unfamiliar code.
- **Tools:** `find_symbol`, `get_symbols_overview`, `find_referencing_symbols`, `search_for_pattern`, `replace_symbol_body`, `insert_before_symbol`, `insert_after_symbol`, `read_memory`, `write_memory`, `list_memories`.
- **Pairs with:** Context7 (docs complement symbols), GSD (code phase).

### Context7 MCP
- **What it is:** Live library documentation via MCP.
- **Value:** Current API docs for React, Next.js, Prisma, et al — not the stale ones in training data.
- **When:** Any library / framework / SDK question.
- **Tools:** `resolve-library-id`, `query-docs`.
- **Pairs with:** Serena (code intelligence), `/sc:implement`.

---

## Workflow

### `feature-dev` plugin
- **What it is:** Guided feature development with codebase understanding and architecture focus.
- **Value:** Scaffolds a discovery → architecture → implementation path when the shape of the feature isn't yet clear.
- **When:** Early-stage feature work; greenfield with ambiguity.
- **Trigger:** `/feature-dev:feature-dev`.
- **Pairs with:** `/gsd:spec-phase`, `/gsd:discuss-phase`.

### `frontend-design` plugin
- **What it is:** Distinctive, production-grade UI component generation.
- **Value:** Avoids the generic-AI aesthetic — polished, creative frontend code.
- **When:** Building web components, pages, or applications.
- **Trigger:** `/frontend-design:frontend-design`.
- **Pairs with:** `/gsd:ui-phase` (design contract), `/gsd:ui-review` (audit), Playwright MCP (visual verification).

### `code-review` plugin
- **What it is:** Standalone code-review agent running in a fresh context.
- **Value:** Independent second-eye review, uncorrelated from the agent that wrote the code.
- **When:** Before merging any significant change; after a major feature step.
- **Trigger:** `/code-review:code-review`.
- **Pairs with:** `/gsd:code-review` (phase-scoped), `/gsd:code-review-fix` (auto-fix findings).

### `claude-md-management` plugin
- **What it is:** `CLAUDE.md` audit and improvement skills.
- **Value:** Keeps `CLAUDE.md` files tight and accurate over time; prevents memory-file rot.
- **When:** `/claude-md-management:revise-claude-md` after a significant project shift; `/claude-md-management:claude-md-improver` for targeted audit.
- **Pairs with:** `/sc:index` (project docs generation), `CLAUDE.md` precedence (Ch 03).

### `claude-code-setup` plugin
- **What it is:** Automation recommender for Claude Code.
- **Value:** Suggests hooks, subagents, skills, plugins, MCP servers based on your codebase.
- **When:** Initial project setup or mid-project audit.
- **Trigger:** `/claude-code-setup:claude-automation-recommender`.
- **Pairs with:** `/gsd:new-project`.

### Mysti
- **What it is:** VSCode extension for multi-model brainstorm.
- **Value:** Two AI models debate (Debate / Red-Team / Perspectives / Delphi) an architecture decision or security question.
- **When:** Pre-design, when the decision is irreversible; high-stakes review.
- **Trigger:** `Ctrl+Shift+M` in VSCode.
- **Pairs with:** `/sc:spec-panel`, `/gsd:review` (both CLI alternatives to Red-Team).

### Playwright MCP
- **What it is:** Browser automation via MCP.
- **Value:** Claude drives a real browser — test flows, fill forms, take screenshots.
- **When:** Frontend testing, visual verification, UI audits.
- **Tools:** `browser_navigate`, `browser_snapshot`, `browser_take_screenshot`, `browser_click`, `browser_fill_form`, `browser_evaluate`, … (see MCP config).
- **Pairs with:** `/gsd:ui-review`, `frontend-design` plugin.

### Sequential Thinking MCP
- **What it is:** Structured multi-step reasoning via MCP.
- **Value:** Forces Claude to externalize a reasoning chain rather than collapsing to a single answer.
- **When:** Complex architecture decisions; race-condition debugging; state-machine design.
- **Pairs with:** `/sc:design --think-hard`.

### `remember` plugin
- **What it is:** Per-session continuity buffer.
- **Value:** Save and resume conversational context across `/clear` or sessions without committing to a named GSD thread.
- **When:** Pausing mid-task; session startup.
- **Trigger:** `/remember`.
- **Files:** `.remember/now.md`, `today-*.md`, `recent.md`, `archive.md`, `core-memories.md`.
- **Pairs with:** `/gsd:thread`, `/gsd:resume-work`.

---

## On-Demand

### `ralph-loop` plugin
- **What it is:** Run-loop automation for recurring tasks.
- **Value:** Kick off repeated cycles on a prompt (monitoring, retries, supervise-and-loop workflows).
- **When:** Polling, retry, or supervise-and-loop workflows.
- **Pairs with:** `/loop`, `/schedule`.

### `graphify` plugin
- **What it is:** Input → knowledge graph + clustered communities → HTML + JSON + audit report.
- **Value:** Convert any input (code, docs, papers, images) into a navigable graph.
- **When:** Ad-hoc knowledge-structuring work; converting research into a graph.
- **Trigger:** `/graphify`.
- **Pairs with:** `/gsd:graphify` (project-graph equivalent scoped to `.planning/`).

### Hugging Face MCP
- **What it is:** Hugging Face Hub + papers search via MCP.
- **Value:** Find models, datasets, papers, spaces without leaving Claude.
- **When:** ML research; pre-implementation model selection.

### Gmail / Calendar / Drive MCPs
- **What they are:** Google Workspace bridges (read/send mail, calendar ops, Drive files).
- **Value:** Claude can reason over your inbox and schedule alongside code work.
- **When:** Ops/calendar work adjacent to code.

---

## Count summary

| Layer | Count |
|---|---|
| GSD commands | ~79 |
| SuperClaude commands | ~33 |
| Superpowers skills | 14 |
| Claude Code native (update-config, keybindings-help, loop, schedule, simplify, fewer-permission-prompts) | ~6 |
| Core tools | 6 |
| Workflow tools | 10 |
| On-Demand tools | 4 (+ 3 Workspace MCPs) |

**Total surface area:** ~150+ commands, skills, and MCP tools across the stack.

---

## See also

- [Tool Matrix](tool-matrix.md) — "primary vs secondary" per task type
- [Quick Reference](quick-reference.md) — golden path + top commands
- [Getting Started](../docs/00-getting-started.md) — which profile to start with
- [02 Discipline Layer](../docs/02-discipline-layer.md) — deep dive on Superpowers skills
