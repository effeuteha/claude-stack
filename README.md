# Claude Stack

**The definitive guide to orchestrating AI-assisted development with Claude Code.**

> You installed Claude Code. Then GSD for lifecycle. SuperClaude for thinking. Serena for code intelligence. Context7 for docs. Maybe Mysti for VSCode.
>
> Now you have **100+ commands** and no idea how they fit together. **This is the missing manual.**

<p align="center">
  <img src="assets/architecture.svg" alt="Claude Stack Architecture" width="100%">
</p>

```
Strategic Layer (SC)  -->  Lifecycle Layer (GSD)  -->  Code Layer (Serena + Context7)
  brainstorm, design        plan, execute, verify       find_symbol, query-docs
  analyze, research         debug, progress             memories, code navigation
```

---

## Quick Start

### 1. Install the Prerequisites

| Component | Install | Purpose |
|-----------|---------|---------|
| **Claude Code** | `npm install -g @anthropic-ai/claude-code` | Core AI agent CLI |
| **GSD** | [Installation guide](https://github.com/gsd-build/get-shit-done) | Project lifecycle management |
| **SuperClaude** | [Installation guide](https://github.com/NomenAK/SuperClaude) | Strategic thinking skills |
| **Serena MCP** | [Configure in MCP settings](https://github.com/oraios/serena) | Semantic code intelligence |
| **Context7 MCP** | [Configure in MCP settings](https://github.com/upstash/context7) | Library documentation |

Optional: [Mysti](https://github.com/DeepMyst/Mysti) (VSCode), [Playwright MCP](https://github.com/microsoft/playwright-mcp), [Sequential Thinking MCP](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking), [nWave](https://github.com/nWave-ai/nWave) (SDLC methodology)

> **Not sure how much to install?** See [Stack Profiles](docs/00-getting-started.md) — from 3-tool minimal to 10+ tool full stack.

### 2. Run the Setup Wizard

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/effeuteha/claude-stack/main/setup.sh)
```

Or manually: `cp examples/settings.json .claude/settings.json && cp examples/mcp.json .mcp.json`

### 3. Learn the Golden Path

```bash
/gsd:progress                    # Where am I?
/gsd:discuss-phase N             # Share vision for next phase
/gsd:plan-phase N                # Create plan
/sc:spec-panel .planning/...     # Review plan (don't skip!)
/gsd:execute-phase N             # Build it
/sc:analyze                      # Quality scan
/gsd:verify-work N               # Verify it works
```

### 4. What You Get

- **Structured lifecycle** — every feature goes through discuss -> plan -> review -> execute -> verify
- **Plan review before coding** — `/sc:spec-panel` catches gaps that would cost hours to fix later
- **Context that persists** — GSD state + Serena memories survive across sessions and `/clear`
- **Multi-model input** — Mysti lets two AI models debate your architecture decisions

See the [end-to-end walkthrough](docs/walkthrough-api-feature.md) for a real feature built with this stack (~35 min).

---

## Which Tool Should I Use?

### Thinking & Planning

```
Don't know which tool?                 -> /gsd:do "description" (auto-routes)
Brainstorm an idea                     -> /sc:brainstorm
Research a domain or market            -> /sc:research
Research a specific library            -> Context7 query-docs
Design architecture                    -> /sc:design --think-hard
Two AI models debating it              -> Mysti Brainstorm (Debate/Red-Team)
Plan a phase                           -> /gsd:discuss-phase N -> /gsd:plan-phase N
Review a plan before executing         -> /sc:spec-panel .planning/phases/...
```

### Building & Executing

```
Execute a planned phase                -> /gsd:execute-phase N
Execute all phases hands-free          -> /gsd:autonomous
Quick one-off task                     -> /gsd:quick or /sc:implement
Build UI                              -> /frontend-design:frontend-design
Understand unfamiliar code             -> Serena find_symbol / get_symbols_overview
```

### Quality & Verification

```
Code quality / security scan           -> /sc:analyze [--focus security|performance]
Run tests                              -> /sc:test
Verify phase deliverables              -> /gsd:verify-work N
Review a PR                            -> /code-review:code-review
Debug a complex bug                    -> /gsd:debug "description"
```

---

## Glossary

| Term | Meaning |
|------|---------|
| **Phase** | A unit of work within a milestone (e.g., "Add user preferences API") |
| **Milestone** | A release boundary containing multiple phases (e.g., "v1.2") |
| **Plan** | A task breakdown with dependencies and verification criteria, stored in `.planning/phases/` |
| **Subagent** | An isolated Claude Code context spawned for parallel work — keeps main context clean |
| **Memory** | Persistent knowledge (CLAUDE.md, Serena memories, GSD state) that survives across sessions |
| **MCP Server** | A tool server that gives Claude Code extra capabilities (Serena for code nav, Context7 for docs) |
| **Hotspot** | A file that changes frequently in git history — where bugs cluster and reviews matter most |

---

## Documentation

### Start Here

| Guide | What You'll Learn |
|-------|-------------------|
| [**Getting Started**](docs/00-getting-started.md) | Pick your profile (Minimal/Standard/Full) and set up in 10 minutes |
| [**Walkthrough: API Feature**](docs/walkthrough-api-feature.md) | See the full workflow on a real feature, start to finish |
| [**Troubleshooting**](docs/troubleshooting.md) | Common problems and how to fix them |

### Foundations (read in order)

| # | Guide | What You'll Learn |
|---|-------|-------------------|
| 1 | [Architecture Overview](docs/01-architecture.md) | How the tools connect and data flows between them |
| 2 | [Claude Code Internals](docs/03-claude-code-internals.md) | CLAUDE.md loading, 4 memory systems, settings, hooks, commands vs skills vs agents |
| 3 | [Context Discipline](docs/04-context-discipline.md) | Token management — when to compact, clear, and use subagents |
| 4 | [Task Routing](docs/05-task-routing.md) | Different workflows for features, bugs, refactors + rigor scaling |

### The Workflow

| # | Guide | What You'll Learn |
|---|-------|-------------------|
| 5 | [Workflow Phases (0-7)](docs/06-workflow-phases.md) | The complete phase lifecycle from bootstrap to milestone completion |
| 6 | [Quality Scaling](docs/07-quality-scaling.md) | Reviewer pattern, git hotspots, mutation testing, cross-model review |
| 7 | [Knowledge Management](docs/08-knowledge-management.md) | Codebase mapping, indexing, Serena memories |
| 8 | [Cross-Cutting Workflows](docs/11-cross-cutting-workflows.md) | Debugging, ideas, UI dev, ML, parallelization |
| 9 | [Session Management](docs/12-session-management.md) | Start, pause, resume, parallel development |
| 10 | [Mysti + VSCode](docs/13-mysti-vscode.md) | Multi-agent brainstorm, personas, when to use GUI vs CLI |

### Reference

| Guide | What You'll Learn |
|-------|-------------------|
| [Tool Matrix](reference/tool-matrix.md) | Primary vs secondary tool for every need |
| [Quick Reference](reference/quick-reference.md) | Golden path, SC flags, decision tree |
| [Tool Inventory](reference/tool-inventory.md) | Complete catalog of all commands and skills |
| [Prompting Patterns](docs/14-prompting-patterns.md) | Effective prompting from Claude Code's creator |
| [Anti-Patterns](docs/15-anti-patterns.md) | 22 mistakes to avoid |
| [SC Flags](cheatsheets/sc-flags.md) | SuperClaude flags cheat sheet |

### Examples (copy-paste ready)

| File | Purpose |
|------|---------|
| [settings.json](examples/settings.json) | Team settings with permission wildcards |
| [mcp.json](examples/mcp.json) | MCP server configuration |
| [CLAUDE.md](examples/claude-md/CLAUDE.md) | Annotated template with filled-in example |
| [rules/](examples/rules/) | Modular `.claude/rules/` files |
| [hooks/](examples/hooks/) | Auto-format and auto-lint hooks |
| [commands/](examples/commands/) | Custom slash commands |

---

## Credits

Built on: [GSD](https://github.com/gsd-build/get-shit-done), [SuperClaude](https://github.com/NomenAK/SuperClaude), [Superpowers](https://github.com/obra/superpowers), [Mysti](https://github.com/DeepMyst/Mysti), [nWave](https://github.com/nWave-ai/nWave), [Serena](https://github.com/oraios/serena), [Context7](https://github.com/upstash/context7)

Informed by: [claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) (18k+ stars)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). PRs welcome for workflow patterns, tool integrations, and example configs.

## License

MIT

---

*Built by developers who got tired of having 100 tools and no manual.*
