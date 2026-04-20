# Session Management

## Starting a Session

```
/sc:load                                  # Restore SC context
/gsd:resume-work                          # Restore GSD state
OR
/gsd:progress                             # Check status and auto-route
```

## Mid-Session Context Pressure

```
/gsd:pause-work                           # Snapshot current state
/sc:save                                  # Persist SC context
Serena: write_memory "key-insight"        # Save critical knowledge
/clear                                    # Free context
/gsd:resume-work                          # Restore in clean context
```

## Ending a Session

```
/sc:save                                  # Persist session context
/gsd:pause-work                           # If mid-phase
/sc:git                                   # Commit and push
/claude-md-management:revise-claude-md    # Update CLAUDE.md with learnings
```

## GSD Configuration

```
/gsd:settings                             # Interactive config (agents, mode)
/gsd:set-profile quality                  # Opus everywhere (max quality)
/gsd:set-profile balanced                 # Opus planning, Sonnet execution (default)
/gsd:set-profile budget                   # Sonnet writing, Haiku research
/gsd:set-profile inherit                  # Use parent model for all agents
```

## Parallel Development

### Multiple Terminal Sessions

Run 2-5 Claude Code sessions in parallel terminal tabs for independent tasks. Each gets its own context window.

### Git Worktrees for Isolation

```bash
git worktree add ../my-feature-worktree feature-branch
cd ../my-feature-worktree
claude   # Fresh Claude Code session with isolated working copy
```

Use the `superpowers:using-git-worktrees` skill for managed worktree creation with safety checks.

### Agent Teams (Experimental)

Multiple Claude Code sessions coordinating on shared work via shared task list:

```bash
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

### Cross-Session Task Persistence

Tasks persist at `~/.claude/tasks/`. Share across sessions:

```bash
CLAUDE_CODE_TASK_LIST_ID=my-project-tasks claude
```

---

**Previous:** [Cross-Cutting Workflows](11-cross-cutting-workflows.md) | **Next:** [Mysti + VSCode](13-mysti-vscode.md)
