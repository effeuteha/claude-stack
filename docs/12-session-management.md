# 12 — Session Management

Every conversation is bounded — by context window, by attention span, by the occasional `/clear`. Session management is how you make continuity cheap.

## Starting a session

```
/sc:load                                  # Restore SC context from last session
/gsd:resume-work                          # Restore GSD state from STATE.md
OR
/gsd:progress                             # Check status and auto-route to next action
```

If `remember` plugin is installed, it will auto-load `.remember/now.md` into the conversation at session start — no explicit call needed.

## Pause / resume — `/gsd:pause-work` and `/gsd:resume-work`

The canonical handoff pair.

```
/gsd:pause-work                           # Snapshot current state to .continue-here
```

Produces a handoff document covering: what's done, what's partially done, what's next, what to know. Use this when you're mid-phase and need to stop — the snapshot captures the conversational context that `STATE.md` alone doesn't.

```
/gsd:resume-work                          # Read .continue-here + STATE.md, restore context
```

Resumes from the handoff. Safe to run in a fresh session after `/clear`, or even in a new terminal days later.

## Cross-session threads — `/gsd:thread`

For persistent context threads that outlive a single `/clear`:

```
/gsd:thread create "auth-rewrite"         # Name a new thread
/gsd:thread switch "auth-rewrite"         # Resume context from this thread
/gsd:thread list                          # See open threads
/gsd:thread archive "old-thread"          # Done with it; archive
```

Unlike `/gsd:pause-work` (which is one-shot), threads are *named, parallel context containers*. Use threads when you're juggling 2+ unrelated investigations that each need their own memory. See [10 Parallel Work](10-parallel-work.md) for the broader parallel-context story.

## `remember` plugin — session continuity buffer

Lightweight save/resume without committing to a named thread:

```
/remember                                 # Save current session state
                                          # Also restores continuity at session start
```

Backs to `.remember/` with a four-tier structure:
- `now.md` — current session buffer
- `today-*.md` — daily snapshots
- `recent.md` — 7-day rolling window
- `archive.md` — older
- `core-memories.md` — key moments you want preserved across all tiers

See [09 Memory Systems](09-memory-systems.md) for how `remember` relates to the other memory mechanisms.

## Mid-session context pressure

When the context window is getting full:

```
1. /gsd:pause-work                        # Snapshot current state
2. /sc:save                               # Persist SC context via Serena
3. Serena: write_memory "key-insight"     # Save critical knowledge
4. /clear                                 # Free context
5. /gsd:resume-work                       # Restore in clean context
```

See [04 Context Discipline](04-context-discipline.md) for the full story on when to compact vs clear vs subagent.

## Ending a session

```
/sc:save                                  # Persist session context
/gsd:pause-work                           # If mid-phase, leave a handoff
/sc:git                                   # Commit and push
/claude-md-management:revise-claude-md    # Update CLAUDE.md with session learnings
/gsd:stats                                # Project statistics: phases, plans, git metrics, timeline
/gsd:milestone-summary                    # Comprehensive milestone summary (run when closing a milestone)
/gsd:extract-learnings                    # Pull decisions / lessons / surprises from completed phases
```

For retrospectives at milestone boundaries, pair `/gsd:milestone-summary` with `/gsd:extract-learnings` — the summary captures *what* shipped, the learnings capture *what was surprising*. For mid-flight check-ins, `/gsd:stats` and `/gsd:progress` are lighter alternatives.

## GSD configuration

Model and workflow configuration is interactive. Pick the right surface:

```
/gsd:config                               # Workflow toggles, integrations, model profile (broad)
/gsd:settings                             # Workflow toggles + model profile (narrower)
/gsd:surface                              # Which skill clusters are surfaced in your menu
```

Profile semantics (set via `/gsd:config` or `/gsd:settings`):

```
quality      # Opus everywhere (max quality)
balanced     # Opus planning, Sonnet execution (default)
budget       # Sonnet writing, Haiku research
inherit      # Use parent model for all agents
```

## Parallel development

Multiple sessions on the same project — see [10 Parallel Work](10-parallel-work.md) for the full mechanism catalog. Summary:

- **Multiple terminal sessions** — open 2–5 Claude Code tabs, each independent.
- **Git worktrees** — isolated working copies so sessions don't collide on `HEAD`:
  ```bash
  git worktree add ../my-feature-worktree feature-branch
  cd ../my-feature-worktree && claude
  ```
  The Superpowers `using-git-worktrees` skill handles safety checks.
- **`/gsd:workstreams`** — planning-level isolation within one repo.
- **`/gsd:workspace`** — isolated repo copy + independent `.planning/`.

### Agent teams (experimental)

```bash
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

Multiple Claude Code sessions coordinating on shared work via a shared task list.

### Cross-session task persistence

```bash
CLAUDE_CODE_TASK_LIST_ID=my-project-tasks claude
```

Tasks persist at `~/.claude/tasks/` and can be shared across sessions via `CLAUDE_CODE_TASK_LIST_ID`.

---

**Previous:** [Cross-Cutting Workflows](11-cross-cutting-workflows.md) | **Next:** [Mysti + VSCode](13-mysti-vscode.md)
