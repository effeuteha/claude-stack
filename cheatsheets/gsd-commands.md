# GSD Commands Quick Reference

## Project Lifecycle

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:new-project` | Initialize project | First time setup |
| `/gsd:new-milestone` | Define milestone scope | Starting new work cycle |
| `/gsd:complete-milestone` | Archive and tag | All phases done |
| `/gsd:audit-milestone` | Check requirements coverage | Before completing |
| `/gsd:plan-milestone-gaps` | Create phases for gaps | After audit finds issues |

## Phase Workflow

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:discuss-phase N` | Share vision, set boundaries | Before planning |
| `/gsd:discuss-phase N --auto` | Auto-answer questions | When you trust defaults |
| `/gsd:list-phase-assumptions N` | Surface Claude's assumptions | Before planning |
| `/gsd:research-phase N` | Domain research | Specialized domains |
| `/gsd:plan-phase N` | Create detailed plan | After discussion |
| `/gsd:execute-phase N` | Build the phase | After plan review |
| `/gsd:verify-work N` | User acceptance testing | After execution |
| `/gsd:validate-phase N` | Retroactive validation | Shipped without enough tests |
| `/gsd:add-tests N` | Generate phase tests | After execution |

## Navigation & Status

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:progress` | Check status, route to next action | Session start |
| `/gsd:stats` | Project statistics and metrics | Anytime |
| `/gsd:health` | Diagnose .planning/ issues | Something seems wrong |

## Session Management

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:resume-work` | Restore context | Session start |
| `/gsd:pause-work` | Snapshot state | Before /clear or ending |

## Quick Actions

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:quick` | Quick task with GSD tracking | Small, defined tasks |
| `/gsd:do "text"` | Auto-route to right command | Don't know which command |
| `/gsd:autonomous` | Hands-free execution | Trust the plan |
| `/gsd:note "idea"` | Capture idea | Don't break flow |
| `/gsd:add-todo "task"` | Add to todo list | Actionable items |
| `/gsd:check-todos` | Review pending todos | Between phases |

## Phase Management

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:add-phase "name"` | Add phase at end | Scope addition |
| `/gsd:insert-phase N "name"` | Insert urgent phase (e.g., 5.1) | Urgent work |
| `/gsd:remove-phase N` | Remove and renumber | Scope reduction |

## UI/Frontend

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/gsd:ui-phase N` | Generate UI design spec | Before building UI |
| `/gsd:ui-review` | 6-pillar visual audit | After building UI |

## Configuration

| Command | Purpose |
|---------|---------|
| `/gsd:settings` | Interactive config |
| `/gsd:set-profile quality` | Opus everywhere |
| `/gsd:set-profile balanced` | Opus planning, Sonnet execution |
| `/gsd:set-profile budget` | Sonnet + Haiku |
| `/gsd:set-profile inherit` | Use parent model |

## Maintenance

| Command | Purpose |
|---------|---------|
| `/gsd:cleanup` | Archive phase directories |
| `/gsd:map-codebase` | Refresh codebase analysis |
| `/gsd:debug "issue"` | Persistent debug session |
| `/gsd:update` | Update GSD version |
