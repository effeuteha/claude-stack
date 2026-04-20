# 03 — Claude Code Internals

Understanding how Claude Code loads configuration, memory, and extensions is load-bearing. Misunderstanding these mechanics is the #1 cause of "why isn't Claude following my rules?"

## CLAUDE.md Loading Mechanics

```
Filesystem root (/)
  |
  +-- home/
       |
       +-- you/
            |
            +-- ~/.claude/CLAUDE.md          <-- Global (applies to ALL projects)
            |
            +-- projects/
                 |
                 +-- my-app/
                      |
                      +-- CLAUDE.md          <-- Root project (loaded immediately)
                      +-- .claude/
                      |    +-- rules/        <-- Modular rule files (loaded immediately)
                      |    |    +-- sql.md
                      |    |    +-- testing.md
                      |    +-- settings.json
                      |
                      +-- frontend/
                      |    +-- CLAUDE.md     <-- LAZY: only when touching frontend/ files
                      |
                      +-- backend/
                           +-- CLAUDE.md     <-- LAZY: only when touching backend/ files
```

### Three rules

1. **Ancestor loading (UP)** — Claude walks upward from CWD to root, loading every `CLAUDE.md`. Immediate at startup.
2. **Descendant loading (DOWN)** — `CLAUDE.md` in subdirectories are lazily loaded only when Claude reads/edits files in that directory.
3. **Siblings never load** — Working in `frontend/` will never load `backend/CLAUDE.md`.

### Practical implications

- Put universal rules in root `CLAUDE.md` (architecture, conventions, security).
- Put component-specific rules in component `CLAUDE.md` files (frontend patterns, API conventions).
- Use `.claude/rules/*.md` to split a large root `CLAUDE.md` into modular files (see [examples](../examples/rules/)).
- Use `CLAUDE.local.md` (gitignored) for personal preferences.
- Target: **under 200 lines** per `CLAUDE.md` file.
- After correcting Claude, say: *"Update your CLAUDE.md so you don't make that mistake again."* Claude is effective at writing rules for itself.

## Memory systems (pointer)

The stack has **six** memory mechanisms; `CLAUDE.md` is one of them. See [09 Memory Systems](09-memory-systems.md) for the full comparison table (scope, persistence, invocation, use).

At a glance:
- **`CLAUDE.md` / `CLAUDE.local.md`** — project-level rules, auto-loaded.
- **Auto-memory** (`~/.claude/projects/…/memory/`) — cross-session, per-cwd, written automatically by Claude.
- **Serena memories** — per-project, explicit via the Serena MCP tool.
- **GSD state** (`.planning/`) — workflow artifacts, git-tracked in your project.
- **`remember` plugin** (`.remember/`) — session continuity buffer.

## Settings hierarchy (6 priority levels)

```
1. Managed settings (organization-enforced)         <-- HIGHEST PRIORITY
2. Command-line flags (session-level)
3. .claude/settings.local.json (project, gitignored)
4. .claude/settings.json (project, committed)
5. ~/.claude/settings.local.json (global personal)
6. ~/.claude/settings.json (global defaults)         <-- LOWEST PRIORITY
```

**Critical:** `deny` rules have the highest safety precedence and cannot be overridden by lower-priority `allow`/`ask` rules.

**Example conflict resolution:**
```
Global settings.json:      allow: ["Bash(rm *.log)"]
Project settings.json:     deny:  ["Bash(rm *)"]
Result:                    DENIED — deny always wins, regardless of priority level
```

See [examples/settings.json](../examples/settings.json) for a team-ready configuration.

## Useful env vars

Set in `.claude/settings.json` under `env`, or in `~/.claude/settings.json` for global defaults.

| Var | Values | Effect |
|---|---|---|
| `CLAUDE_CODE_EFFORT_LEVEL` | `low` / `medium` / `high` / `max` | Tunes reasoning depth on each turn; higher = more thinking, more tokens |
| `CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING` | `0` / `1` | `1` pins effort at the configured level instead of adapting to task complexity |
| `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` | integer 1–99 | Triggers auto-compact at this % of context window (default ~75) |

Example:
```json
{
  "env": {
    "CLAUDE_CODE_EFFORT_LEVEL": "high",
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "80"
  }
}
```

## Extensions: Commands, Skills, Subagents, Plugins, MCPs

Five kinds of extension live in the Claude Code ecosystem — each solves a different problem.

### Commands

Files in `.claude/commands/`. User-invoked via `/` slash. Run inline in the main conversation.

### Skills

Files in `.claude/skills/`. Can auto-trigger based on context (skill description matches the task), or user-invoked via `/`. Reshape behavior for a specific task shape.

### Subagents

Files in `.claude/agents/`. Run in a separate context, autonomous. Invoked by the orchestrator Claude when the task matches the agent's description. Have their own memory, hooks, and tools.

### Plugins

Bundle commands + skills + agents + hooks + MCPs under one installable package. Current stack plugins:

- **Superpowers** — discipline methodology (14 skills: `brainstorming`, `writing-plans`, `executing-plans`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `subagent-driven-development`, `dispatching-parallel-agents`, `using-git-worktrees`, `requesting-code-review`, `receiving-code-review`, `finishing-a-development-branch`, `writing-skills`, `using-superpowers`). See [02 Discipline Layer](02-discipline-layer.md).
- **GSD** — project lifecycle management (~79 commands).
- **SuperClaude** — strategic thinking (~33 commands under `/sc:*`).
- **`feature-dev`** — guided feature development.
- **`frontend-design`** — production-grade UI component generation.
- **`code-review`** — standalone code review agent.
- **`claude-md-management`** — `CLAUDE.md` audits.
- **`claude-code-setup`** — automation recommender (hooks, skills, MCPs).
- **`remember`** — per-session continuity buffer.
- **`ralph-loop`** — run-loop automation.
- **`graphify`** — input-to-knowledge-graph.

See [Tool Inventory](../reference/tool-inventory.md) for the tiered catalog.

### MCPs (Model Context Protocol servers)

External servers that extend Claude Code with domain-specific tools. Current stack:

- **Serena** — semantic code intelligence (symbol navigation, memories).
- **Context7** — live library documentation.
- **Playwright** — browser automation.
- **Sequential Thinking** — structured multi-step reasoning.
- **Hugging Face** — model / paper / space search.
- **Gmail / Calendar / Drive** — Google Workspace bridges.

### Command vs Skill vs Subagent — decision table

| | Command | Skill | Subagent |
|---|---|---|---|
| **Location** | `.claude/commands/` | `.claude/skills/` | `.claude/agents/` |
| **Context** | Inline (main conversation) | Inline (unless `context: fork`) | Separate, isolated |
| **Auto-invocable by Claude** | No — always user-initiated via `/` | Yes (based on description match) | Yes (based on description match) |
| **User invocable via `/`** | Yes | Yes (unless disabled) | No |
| **Accepts arguments** | `$ARGUMENTS`, `$0`, `$1` | `$ARGUMENTS`, `$0`, `$1` | Via `prompt` parameter |
| **Has persistent memory** | No | No | Yes (`memory:` frontmatter) |
| **Has hooks** | No | Yes | Yes |
| **Can preload skills** | No | No | Yes (`skills:` frontmatter) |
| **Has MCP servers** | No | No | Yes |

### Decision tree

```
Is it triggered by the user typing "/"?
  YES --> Does it need isolated context or persistent memory?
    YES --> Agent (with a command wrapper to trigger it)
    NO  --> Command
  NO  --> Should Claude invoke it automatically based on intent?
    YES --> Skill
    NO  --> It's probably just CLAUDE.md instructions
```

### Orchestration pattern

```
User triggers /command
  --> Command orchestrates workflow
    --> Command invokes Agent (separate context, autonomous)
      --> Agent uses preloaded Skill (domain knowledge)
    --> Command invokes Skill (inline, for output generation)
```

## Useful hooks

### Auto-format after edits

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{ "type": "command", "command": "npx prettier --write $FILEPATH || true" }]
    }]
  }
}
```

### Auto-lint

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{ "type": "command", "command": "npx eslint --fix $FILEPATH 2>/dev/null || true" }]
    }]
  }
}
```

See [examples/hooks/](../examples/hooks/) for ready-to-use hook configurations. Configure hooks via `/update-config` or directly in `settings.json`.

## Permission wildcards

Reduce permission fatigue by pre-approving common operations in `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(make *)",
      "Bash(pytest *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)"
    ]
  }
}
```

Share these with your team by committing `.claude/settings.json`. Use `.claude/settings.local.json` for personal overrides.

---

**Previous:** [← 02 Discipline Layer](02-discipline-layer.md) | **Next:** [Context Discipline](04-context-discipline.md)
