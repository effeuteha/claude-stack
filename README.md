# Claude Stack

**The definitive guide to orchestrating AI-assisted development with Claude Code.**

> You installed Claude Code. Then Superpowers for discipline. GSD for lifecycle. SuperClaude for thinking. Serena for code intelligence. Context7 for docs. And a dozen other plugins.
>
> Now you have **150+ commands, skills, and MCP tools** across the stack. **This is the missing manual.**

<p align="center">
  <img src="assets/architecture.svg" alt="Claude Stack Architecture" width="100%">
</p>

```
Discipline (Superpowers)  ->  Strategic (SC)  ->  Lifecycle (GSD)  ->  Code (Serena + Context7)
  brainstorm-first · TDD      research · design     spec → plan → ship     symbols · docs
  verify · debug · worktrees  analyze · spec-panel  workstreams · threads  memories
```

---

## Quick Start

### 1. Install the Prerequisites

| Component | Install | Purpose |
|-----------|---------|---------|
| **Claude Code** | `npm install -g @anthropic-ai/claude-code` | Core AI agent CLI |
| **Superpowers** | [Install via marketplace](https://github.com/obra/superpowers) | Discipline methodology (TDD, brainstorm, verify) |
| **GSD** | [Installation guide](https://github.com/gsd-build/get-shit-done) | Project lifecycle management |
| **SuperClaude** | [Installation guide](https://github.com/NomenAK/SuperClaude) | Strategic thinking skills |
| **Serena MCP** | [Configure in MCP settings](https://github.com/oraios/serena) | Semantic code intelligence |
| **Context7 MCP** | [Configure in MCP settings](https://github.com/upstash/context7) | Library documentation |

Optional workflow tier: [Mysti](https://github.com/DeepMyst/Mysti) (VSCode), [Playwright MCP](https://github.com/microsoft/playwright-mcp), [Sequential Thinking MCP](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking), plus plugins — `feature-dev`, `frontend-design`, `code-review`, `claude-md-management`, `claude-code-setup`, `remember`.

> **Not sure how much to install?** See [Stack Profiles](docs/00-getting-started.md) — from 4-tool Minimal to 15+ tool Full.

### 2. Run the Setup Wizard

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/effeuteha/claude-stack/main/setup.sh)
```

Or manually: `cp examples/settings.json .claude/settings.json && cp examples/mcp.json .mcp.json`

### 3. Learn the Golden Path

```bash
/gsd:progress                    # Where am I?
/gsd:spec-phase N                # Lock WHAT (recommended for non-trivial phases)
/gsd:discuss-phase N             # Gray-area decisions
/gsd:plan-phase N                # Plan
/sc:spec-panel .planning/…       # Multi-expert plan review (in Claude)
/gsd:review .planning/…          # Cross-AI peer review (high-stakes phases)
/gsd:execute-phase N             # Build it
/sc:analyze                      # Quality scan
/gsd:verify-work N               # UAT
/gsd:ship                        # PR + review + merge
```

See the [Golden Path cheatsheet](cheatsheets/golden-path.md) for the one-page version.

### 4. What You Get

- **Discipline baked in** — brainstorm-first, TDD, verify-before-complete as Superpowers skills that auto-trigger on matching context.
- **Structured lifecycle** — every feature: `spec → discuss → plan → review → execute → analyze → verify → ship`.
- **Plan review in two flavors** — `/sc:spec-panel` (multi-expert inside Claude) + `/gsd:review` (cross-AI peer review via Gemini/Codex/other CLIs). Pair both for high-stakes work.
- **Context that persists** — 6 memory systems (`CLAUDE.md`, auto-memory, Serena memories, GSD state, `remember` plugin, `CLAUDE.local.md`).
- **Parallel work that actually parallelizes** — worktrees, workstreams, threads, subagent-driven-development.
- **Multi-model input** — Mysti lets two AI models debate your architecture decisions (GUI); `/gsd:review` does the same in CLI.

See the [end-to-end walkthrough](docs/walkthrough-api-feature.md) for a real feature built with this stack (~40 min).

---

## Which Tool Should I Use?

### Thinking & Planning

```
Don't know which tool?                 -> /gsd:progress "description" (auto-routes freeform intent)
Brainstorm an idea                     -> /sc:brainstorm or /superpowers:brainstorming
Research a domain or market            -> /sc:research
Research a specific library            -> Context7 query-docs
Design architecture                    -> /sc:design --think-hard
Two AI models debating it              -> Mysti Brainstorm / /gsd:review
Lock WHAT before HOW                   -> /gsd:spec-phase N
Plan a phase                           -> /gsd:discuss-phase N -> /gsd:plan-phase N
Review a plan before executing         -> /sc:spec-panel (multi-expert in Claude)
High-stakes plan review                -> /sc:spec-panel AND /gsd:review (cross-AI)
```

### Building & Executing

```
Execute a planned phase                -> /gsd:execute-phase N
Execute all phases hands-free          -> /gsd:autonomous
Quick one-off task                     -> /gsd:quick
Single-line fix                        -> /gsd:fast
Build UI                              -> /gsd:ui-phase N + frontend-design plugin
AI/LLM feature                         -> /gsd:ai-integration-phase N
Explore before committing              -> /gsd:sketch (UI) or /gsd:spike (code)
Understand unfamiliar code             -> Serena find_symbol / get_symbols_overview
```

### Quality & Verification

```
Code quality / security scan           -> /sc:analyze [--focus security|performance]
Run tests                              -> /sc:test
Verify phase deliverables              -> /gsd:verify-work N
Review a PR                            -> /code-review:code-review
Review source files for a phase        -> /gsd:code-review
Auto-fix code review findings          -> /gsd:code-review --fix
Autonomous audit -> fix pipeline       -> /gsd:audit-fix
Debug a complex bug                    -> /gsd:debug "description"
Post-mortem a failed workflow          -> /gsd:forensics
Ship it                                -> /gsd:ship
```

### Parallel work

```
Two features in flight                 -> git worktree + /gsd:workstreams
Cross-session context                  -> /gsd:thread
Multi-task in one session              -> superpowers:subagent-driven-development
Multiple independent lookups           -> superpowers:dispatching-parallel-agents
```

---

## Glossary

| Term | Meaning |
|------|---------|
| **Phase** | A unit of work within a milestone (e.g., "Add user preferences API") |
| **Milestone** | A release boundary containing multiple phases (e.g., "v1.2") |
| **Spec** | Falsifiable requirements for a phase produced by `/gsd:spec-phase`, with an ambiguity score |
| **Plan** | A task breakdown with dependencies and verification criteria, stored in `.planning/phases/` |
| **Subagent** | An isolated Claude Code context spawned for parallel work — keeps main context clean |
| **Memory** | Persistent knowledge (`CLAUDE.md`, Serena memories, GSD state, `remember`) that survives across sessions |
| **MCP server** | A tool server giving Claude Code extra capabilities (Serena for code nav, Context7 for docs) |
| **Skill** | A discipline or behavior module, often auto-triggered on matching context (Superpowers uses this model heavily) |
| **Hotspot** | A file that changes frequently in git history — where bugs cluster and reviews matter most |
| **Worktree** | A filesystem-isolated checkout of a git branch (`git worktree add`) — for parallel feature work |

---

## Documentation

### Start Here

| Guide | What You'll Learn |
|-------|-------------------|
| [**Getting Started**](docs/00-getting-started.md) | Pick your profile (Minimal / Standard / Full) and set up in 10 minutes |
| [**Walkthrough: API Feature**](docs/walkthrough-api-feature.md) | See the full workflow on a real feature, start to finish |
| [**Golden Path cheatsheet**](cheatsheets/golden-path.md) | One-page mental model |
| [**Troubleshooting**](docs/troubleshooting.md) | Common problems and how to fix them |

### Foundations (read in order)

| # | Guide | What You'll Learn |
|---|-------|-------------------|
| 1 | [Architecture Overview](docs/01-architecture.md) | The 4-layer model and how tools connect |
| 2 | [Discipline Layer](docs/02-discipline-layer.md) | Superpowers methodology (TDD, brainstorm, verify, debug, worktrees) |
| 3 | [Claude Code Internals](docs/03-claude-code-internals.md) | `CLAUDE.md` loading, env vars, settings, hooks, commands vs skills vs agents |
| 4 | [Context Discipline](docs/04-context-discipline.md) | Token management — when to compact, clear, and use subagents |
| 5 | [Task Routing](docs/05-task-routing.md) | Decision tree: feature / bug / refactor / AI / UI / spike |

### The Workflow

| # | Guide | What You'll Learn |
|---|-------|-------------------|
| 6 | [Workflow Phases (0–7)](docs/06-workflow-phases.md) | Spec-first golden path + new phase types (AI, UI, sketch, spike) |
| 7 | [Quality Scaling](docs/07-quality-scaling.md) | `/sc:spec-panel`, `/gsd:review`, `audit-fix`, reviewer pattern |
| 8 | [Knowledge Management](docs/08-knowledge-management.md) | Codebase mapping, scan, graphify |
| 9 | [Memory Systems](docs/09-memory-systems.md) | The six memory mechanisms, compared |
| 10 | [Parallel Work](docs/10-parallel-work.md) | Worktrees, workstreams, threads, subagents |
| 11 | [Cross-Cutting Workflows](docs/11-cross-cutting-workflows.md) | Debug, forensics, audit-fix, AI/UI phase walkthroughs |
| 12 | [Session Management](docs/12-session-management.md) | `remember`, thread, resume-work, pause-work |
| 13 | [Mysti + VSCode](docs/13-mysti-vscode.md) | GUI multi-agent brainstorm |

### Reference

| Guide | What You'll Learn |
|-------|-------------------|
| [Tool Matrix](reference/tool-matrix.md) | Primary vs secondary tool for every need |
| [Quick Reference](reference/quick-reference.md) | Golden path, SC flags, decision tree |
| [Tool Inventory](reference/tool-inventory.md) | Tiered catalog — Core / Workflow / On-Demand |
| [Golden Path cheatsheet](cheatsheets/golden-path.md) | One-page mental-model card |
| [Prompting Patterns](docs/14-prompting-patterns.md) | Effective prompting — brainstorm-first and friends |
| [Anti-Patterns](docs/15-anti-patterns.md) | 28 mistakes to avoid |
| [SC Flags](cheatsheets/sc-flags.md) | SuperClaude flags cheat sheet |

### Examples (copy-paste ready)

| File | Purpose |
|------|---------|
| [settings.json](examples/settings.json) | Team settings with permission wildcards |
| [mcp.json](examples/mcp.json) | MCP server configuration (Serena, Context7, Sequential Thinking + optional Playwright) |
| [CLAUDE.md](examples/claude-md/CLAUDE.md) | Annotated template with Superpowers expectations section |
| [rules/](examples/rules/) | Modular `.claude/rules/` files |
| [hooks/](examples/hooks/) | Auto-format and auto-lint hooks |
| [commands/](examples/commands/) | Custom slash commands |

---

## Credits

Built on: [Superpowers](https://github.com/obra/superpowers), [GSD](https://github.com/gsd-build/get-shit-done), [SuperClaude](https://github.com/NomenAK/SuperClaude), [Mysti](https://github.com/DeepMyst/Mysti), [Serena](https://github.com/oraios/serena), [Context7](https://github.com/upstash/context7)

Informed by: [claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). PRs welcome for workflow patterns, tool integrations, and example configs.

## License

MIT

---

*Built by developers who got tired of having 150 tools and no manual.*
