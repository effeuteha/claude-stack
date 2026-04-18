# Claude Code Internals

Understanding how Claude Code loads configuration and manages memory is critical for effective use. Misunderstanding these mechanics is the #1 cause of "why isn't Claude following my rules?"

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

### Three Rules

1. **Ancestor loading (UP)** — Claude walks upward from CWD to root, loading every CLAUDE.md. Immediate at startup.
2. **Descendant loading (DOWN)** — CLAUDE.md in subdirectories are lazily loaded only when Claude reads/edits files in that directory.
3. **Siblings never load** — Working in `frontend/` will never load `backend/CLAUDE.md`.

### Practical Implications

- Put universal rules in root CLAUDE.md (architecture, conventions, security)
- Put component-specific rules in component CLAUDE.md files (frontend patterns, API conventions)
- Use `.claude/rules/*.md` to split a large root CLAUDE.md into modular files (see [examples](../examples/rules/))
- Use `CLAUDE.local.md` (gitignored) for personal preferences
- Target: **under 200 lines** per CLAUDE.md file
- After correcting Claude, say: *"Update your CLAUDE.md so you don't make that mistake again."* Claude is effective at writing rules for itself.

## Memory Hierarchy (4 Systems)

| System | Who Writes | Who Reads | Scope | Persists |
|--------|-----------|-----------|-------|----------|
| **CLAUDE.md** | Human (manual) | Main Claude + all agents | Project (git-tracked) | Yes |
| **Auto-memory** | Claude (automatic) | Main Claude only | Per-project, per-user | Yes |
| **`/memory` command** | Human (via editor) | Main Claude only | Per-project, per-user | Yes |
| **Agent memory** | Agent itself | That specific agent only | Configurable | Yes |

With MCP servers, you get additional persistence:
- **Serena memories** — persist across all conversations, good for deep domain knowledge
- **GSD `.planning/` files** — git-tracked project state (plans, summaries, verification reports)

### When to Use Which

| Need | Use |
|------|-----|
| Team conventions, architecture rules | CLAUDE.md (committed) |
| Personal preferences | CLAUDE.local.md (gitignored) |
| Let Claude learn from corrections | Auto-memory (automatic) |
| Manually store context for later | `/memory` command |
| Domain knowledge for specialized agents | Agent memory |
| Non-obvious patterns, debugging insights | Serena memories |
| Project lifecycle state | GSD `.planning/` |

### Agent Memory

Introduced in Claude Code v2.1.33. The first 200 lines of an agent's `MEMORY.md` are injected into its system prompt at startup. Three scopes:

- **`user`** (recommended default) — cross-project, personal
- **`project`** — team-shared, version controlled
- **`local`** — personal, gitignored

## Settings Hierarchy (6 Priority Levels)

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

## Command vs Skill vs Subagent

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

### Decision Tree

```
Is it triggered by the user typing "/"?
  YES --> Does it need isolated context or persistent memory?
    YES --> Agent (with a command wrapper to trigger it)
    NO  --> Command
  NO  --> Should Claude invoke it automatically based on intent?
    YES --> Skill
    NO  --> It's probably just CLAUDE.md instructions
```

### Orchestration Pattern

```
User triggers /command
  --> Command orchestrates workflow
    --> Command invokes Agent (separate context, autonomous)
      --> Agent uses preloaded Skill (domain knowledge)
    --> Command invokes Skill (inline, for output generation)
```

## Useful Hooks

### Auto-Format After Edits

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

### Auto-Lint

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

See [examples/hooks/](../examples/hooks/) for ready-to-use hook configurations. Configure hooks via `/update-config` or directly in settings.json.

## Permission Wildcards

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

**Previous:** [Architecture Overview](01-architecture.md) | **Next:** [Context Discipline](03-context-discipline.md)
