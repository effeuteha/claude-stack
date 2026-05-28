# Context Discipline

Context management is the difference between Claude producing great output and producing garbage. Your context window is ~200K tokens. When conversation history exceeds ~70% of that, Claude starts deprioritizing earlier instructions and output quality degrades silently.

## The Context Budget

```
+---------------------------------------------------------------+
|                    CONTEXT WINDOW                              |
|                                                                |
|  [System Prompt + CLAUDE.md + rules + MCP tool defs]  ~15-25% |
|  [Conversation history]                               ~50-60% |
|  [Current working set]                                ~15-25% |
|                                                                |
|  THE "AGENT DUMB ZONE": When history fills >70%,              |
|  Claude loses track of earlier instructions and               |
|  starts making mistakes.                                       |
+---------------------------------------------------------------+
```

## Rules of Thumb

| Situation | Action | Why |
|-----------|--------|-----|
| Context at ~50% | Run `/compact` manually | Don't wait for auto-compact at 80% — quality degrades before that |
| Switching to a new task | Run `/clear` | Fresh context > bloated context |
| About to `/clear` | Run `/gsd-pause-work` + `/sc:save` first | Snapshot state before wiping |
| Complex planning done, ready to execute | `/clear` then `/gsd-resume-work` | Planning tokens bloat execution quality |
| Claude going off-track | `Esc Esc` or `/rewind` | Undo bad turns instead of arguing in degraded context |
| Need to check context health | `/context` | Shows usage breakdown |
| Need to check token spend | `/cost` | Shows session cost |
| Important session you'll return to | `/rename "meaningful name"` | Then `/resume` it later |
| MCP tools consuming too much context | Disable unused MCP servers | Each server's tool definitions cost tokens even when idle |

## Context-Efficient Patterns

### Use Subagents to Offload Work

Say "use subagents for [task]" to delegate research/analysis to isolated contexts. Each subagent gets its own context window and reports results back. Use `/sc:pm` to coordinate multiple subagents. This keeps your main context clean for the work that matters.

### Use `/sc:index-repo` for Orientation

Reading the full codebase costs ~58K tokens. A project index costs ~3K tokens. That's a **94% reduction**.

### Use Serena for Targeted Code Reading

Instead of reading entire files, use `find_symbol` and `get_symbols_overview` to read only what you need. Serena provides semantic navigation — you don't have to guess which file contains the code you need.

### Auto-Compact Configuration

```json
{
  "env": {
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "80"
  }
}
```

Add this to your `.claude/settings.json`. But remember: manual `/compact` at 50% is better than waiting for auto-compact at 80%.

### MCP Tool Search (Automatic Deferral)

When MCP tool descriptions exceed 10% of context, Claude Code automatically defers them — loading full schemas only when needed. Built-in since v2.1.7. Configure with:

```json
{
  "env": {
    "ENABLE_TOOL_SEARCH": "auto:10"
  }
}
```

## The Context Lifecycle

```
START SESSION
    |
    v
[Load context: CLAUDE.md + MCP + state]  ~20% used
    |
    v
[Work: code, research, planning]         ~50% used
    |
    v
[Manual /compact]                         ~30% used (recovered)
    |
    v
[More work]                               ~60% used
    |
    v
[/gsd-pause-work + /sc:save]             state saved
    |
    v
[/clear]                                  ~20% used (fresh)
    |
    v
[/gsd-resume-work]                        full context restored
    |
    v
[Continue work with clean context]
```

## Common Mistakes

| Mistake | Impact | Fix |
|---------|--------|-----|
| Never compacting | Quality degrades silently | `/compact` at 50% |
| `/clear` without saving state | Lose work-in-progress | Always `/gsd-pause-work` first |
| Keeping Playwright/HuggingFace enabled when not using them | Wastes 5-15% of context on idle tool definitions | Disable, enable on demand |
| Arguing with Claude when it's confused | Burns tokens in polluted context | `Esc Esc`, re-prompt cleanly |
| Reading entire files when you need one function | Wastes context on irrelevant code | Use Serena `find_symbol` |
| Not using `/sc:index-repo` | 58K tokens per session for codebase orientation | Index once, read 3K per session |

---

**Previous:** [Claude Code Internals](03-claude-code-internals.md) | **Next:** [Task Routing](05-task-routing.md)
