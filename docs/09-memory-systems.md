# 09 — Memory Systems

> **Every conversation is amnesia by default.** The stack has six mechanisms that turn conversation into durable memory. Each one has a different scope, persistence, and invocation model. Pick the right one per need.

A single project rarely needs all six. But knowing which exists — and which gap each fills — is what separates "re-explaining the codebase every session" from "Claude picks up where you left off." The trick is matching the lifespan of the thing you're remembering to the mechanism whose scope fits.

## The six systems

### `CLAUDE.md` (project, team)

- **Scope:** the project this file lives in.
- **Persistence:** git-tracked — committed and shared.
- **Invocation:** auto-loaded into every conversation started inside this project.
- **Use for:** team conventions, architecture summaries, coding standards, domain glossary, "things every teammate (human or AI) should know on day one."
- **Don't use for:** per-user preferences, secrets, working-state notes.
- **See:** [03 Claude Code Internals](03-claude-code-internals.md) for the full `CLAUDE.md` precedence table.

### `CLAUDE.local.md` (project, personal)

- **Scope:** the same project; a personal overlay.
- **Persistence:** gitignored (the `setup.sh` wizard will add it to your `.gitignore` automatically).
- **Invocation:** auto-loaded with the same precedence rules as `CLAUDE.md`.
- **Use for:** personal preferences that shouldn't pollute the team file — your preferred commit message style, aliases, taste calls that are yours alone.

### Auto-memory (cross-session, per-cwd)

- **Scope:** every conversation in this working directory, across sessions.
- **Persistence:** `~/.claude/projects/<cwd-hash>/memory/` on your local machine — not in the project directory, so never committed.
- **Invocation:** automatic. `MEMORY.md` is an index that's always loaded into each conversation; individual detail files are read on demand when relevant.
- **Use for:** user-role facts (who you are), feedback / corrections, project context that travels with *you* rather than with the repo, and references to external systems (dashboards, issue trackers).
- **Types:** **user** · **feedback** · **project** · **reference** — each entry is typed so Claude knows when to pull it in.
- **How Claude writes them:** automatically, when it learns something durable. You don't need to ask.

### Serena memories (per-project, via MCP)

- **Scope:** per-project, via the Serena MCP server.
- **Persistence:** `.serena/memories/` inside the project (Serena manages it).
- **Invocation:** explicit — `read_memory`, `write_memory`, `list_memories` through the Serena MCP tool surface.
- **Use for:** curated project knowledge a future session should read *on demand* — subsystem maps, recovery recipes, "here's how we decided to shape this module," things too heavy for `CLAUDE.md` and too project-specific for auto-memory.

### GSD state (per-project, workflow)

- **Scope:** per-project, GSD-managed.
- **Persistence:** `.planning/` — **typically git-tracked** in a user's own project so workflow history travels with the code. (The `claude-stack` repo itself gitignores `.planning/` because it's a docs repo, not a GSD-managed project.)
- **Invocation:** the GSD commands read and write it as part of the lifecycle — you don't manipulate these files by hand.
- **Use for:** phase plans, discuss-phase outputs, verification results, session reports, milestone artifacts. Every phase leaves an audit trail.

### `remember` plugin (session continuity buffer)

- **Scope:** per-session, buffered across a small window of recent sessions.
- **Persistence:** `.remember/` with a four-tier structure — `now.md` (current buffer), `today-*.md` (daily), `recent.md` (7-day window), `archive.md` (older), plus `core-memories.md` for key moments you want preserved.
- **Invocation:** explicit — `/remember` to save, and `/remember` at session start restores continuity.
- **Use for:** resuming a paused task, carrying context across `/clear`, any "I need to pick this back up tomorrow" moment.

## Comparison

| System | Scope | Persistence | Invocation | Primary use |
|---|---|---|---|---|
| `CLAUDE.md` | project, team | git-tracked | auto | conventions |
| `CLAUDE.local.md` | project, personal | gitignored | auto | personal overlay |
| auto-memory | cross-session cwd | `~/.claude/…` | auto | user / feedback / project / reference |
| Serena memories | per-project | `.serena/…` | explicit (MCP) | curated project knowledge |
| GSD state | per-project | `.planning/` (usually tracked) | workflow | lifecycle artifacts |
| `remember` | per-session buffer | `.remember/` | explicit (`/remember`) | continuity across `/clear` |

## Which to use when

- **"Claude should always know this about our project."** → `CLAUDE.md`
- **"Claude should always know this about my setup."** → `CLAUDE.local.md`
- **"Claude should remember this about me across any project."** → auto-memory (writes automatically)
- **"Claude should read this file when it's relevant."** → Serena memory
- **"This is workflow state — the plan, the spec, the verification record."** → GSD state (GSD manages it)
- **"I'm pausing; pick up where I left off."** → `remember` plugin

The litmus test: *who needs to read this, and over what timescale?* Project-scoped + shared → `CLAUDE.md`. Cross-project + about you → auto-memory. Mid-task + short-lived → `remember`. Everything else usually lives in the natural artifact (spec, plan, code).

## Excluded from the stack

- **`goodmem`** — requires special credentials, so a reader can't install it from this guide.

If you adopt a memory tool outside this list, the question to ask yourself is the same: *what timescale and scope does it cover, and does it overlap with something that's already pulling its weight?* Memory tools that capture *everything* without curation trade attention for breadth — decide whether that trade fits your threat model.

## See also

- [03 Claude Code Internals](03-claude-code-internals.md) — `CLAUDE.md` precedence table
- [04 Context Discipline](04-context-discipline.md) — when to `/clear`, when to compact
- [06 Workflow Phases](06-workflow-phases.md) — the GSD state lifecycle
- [12 Session Management](12-session-management.md) — `remember` plugin workflows

---

**Prev:** [← 08 Knowledge Management](08-knowledge-management.md) | **Next:** [10 Parallel Work →](10-parallel-work.md)
