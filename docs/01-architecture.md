# Architecture Overview

## The Stack

Your development stack has 6 layers, each with a distinct responsibility:

| Layer | Tool | Role | Analogy |
|-------|------|------|---------|
| **Strategic thinking** | SuperClaude (SC) | Brainstorm, research, analyze, design | The brain |
| **Project lifecycle** | GSD | Plan, execute, verify, audit milestones | The spine |
| **Code intelligence** | Serena MCP | Symbol navigation, refactoring, memories | The hands |
| **Documentation** | Context7 MCP | Library docs, API references, code examples | The library |
| **Browser testing** | Playwright MCP | E2E testing, visual verification | The eyes |
| **Multi-agent GUI** | Mysti (VSCode) | Multi-model brainstorm, @-mentions | The bridge |

Plus supporting layers:
- **Sequential Thinking MCP** — Multi-step reasoning for complex logic
- **Superpowers Skills** — Discipline-enforcing workflow skills (TDD, debugging, verification)
- **Plugins** — Specialized workflows (feature-dev, code-review, frontend-design)
- **Claude Code Native Skills** — Built-in automation (hooks, config, loops)

## Data Flow

```
SC (thinking) --> GSD (state + plans) --> Serena (code ops) --> Context7 (docs)
      ^                    |                      |                    |
      +--------------------+----------------------+--------------------+
                         feedback loops
```

1. **SC** helps you think about what to build (brainstorm, research, design)
2. **GSD** manages the lifecycle (plan phases, execute, verify, complete milestones)
3. **Serena** navigates and edits code at the symbol level during execution
4. **Context7** provides library documentation when coding or researching
5. Results feed back into SC for analysis, reflection, and quality checks

## How VSCode Users Fit In

```
+-----------------------------------------------------------+
|                    VSCode (Mysti)                           |
|                                                            |
|  +--------------+    +--------------+                      |
|  |  Mysti UI     |    |  Your Editor  |                    |
|  |  (webview)    |    |  (code)       |                    |
|  +------+-------+    +--------------+                      |
|         |                                                  |
|         v                                                  |
|  +----------------------------------------------------+   |
|  |  Claude Code CLI (subprocess)                       |   |
|  |                                                      |   |
|  |  +----------+ +----------+ +----------+             |   |
|  |  | Serena   | | Context7 | | Seq.     |             |   |
|  |  | MCP      | | MCP      | | Thinking |             |   |
|  |  +----------+ +----------+ +----------+             |   |
|  |                                                      |   |
|  |  CLAUDE.md rules <-- still loaded and respected      |   |
|  |  GSD .planning/ <-- still read/written               |   |
|  |  SC skills     <-- still available                   |   |
|  +----------------------------------------------------+   |
|                                                            |
|  +----------------------------------------------------+   |
|  |  Other Providers (optional, for brainstorm)         |   |
|  |  Gemini, Codex, Copilot CLI, Cline, etc.            |   |
|  +----------------------------------------------------+   |
+-----------------------------------------------------------+
```

When Mysti spawns Claude Code, it inherits your full setup. CLAUDE.md, MCP servers, GSD state, SC skills — everything works the same. Mysti adds multi-model capabilities on top.

## What Gets Created

When you use GSD for project management, it creates a `.planning/` directory:

```
.planning/
|-- PROJECT.md            # Vision, goals
|-- ROADMAP.md            # Phase breakdown
|-- REQUIREMENTS.md       # REQ-IDs with v1/v2/out-of-scope
|-- STATE.md              # Living project memory
|-- config.json           # Workflow mode (interactive/yolo)
|-- research/             # Domain research artifacts
|-- codebase/             # Map artifacts (7 deep analysis docs)
+-- phases/               # Phase plans, summaries, verification
```

This state persists across sessions and is git-tracked, so your entire team can see the project's planning history.
