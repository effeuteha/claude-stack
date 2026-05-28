# 10 — Parallel Work

> **Two features in flight ≠ twice the output.** Parallel work compounds only when the pieces truly don't share state. This chapter maps five mechanisms — from filesystem isolation to in-turn concurrency — and tells you which one fits which shape of work.

Parallelism costs attention. Every mechanism below adds a dimension (a second checkout, a second planning track, a second conversation thread), and each dimension needs to be held in your head. The payoff is only there when the work is *actually* independent — a refactor that touches the same hot files as your other feature will conflict on merge no matter how cleanly you parallelized the writing.

## The five mechanisms

### 1. Git worktrees (filesystem isolation)

- **What it isolates:** the checkout. Each worktree is a separate directory with its own `HEAD`, index, and working tree.
- **Cost:** disk (one copy per worktree) · friction (switching directories).
- **Use for:** simultaneous feature branches, high-stakes refactors, anything where you'd otherwise pollute a single checkout with half-staged state.
- **Superpowers skill:** [`using-git-worktrees`](02-discipline-layer.md) — smart directory selection plus safety verification so you don't accidentally nuke in-progress work.

### 2. GSD workstreams (planning-level isolation)

- **What it isolates:** independent phase lineages. `/gsd-workstreams` tracks multiple parallel planning tracks within one project.
- **Cost:** cognitive — you're shepherding multiple workstreams at once.
- **Use for:** larger projects with teams, or solo work juggling unrelated feature areas concurrently.
- **Commands:** `/gsd-workstreams list|create|switch|status|progress|complete|resume`.
- **Optional pairing:** `/gsd-workspace` creates and manages isolated workspaces with repo copies and an independent `.planning/` — use this when even the planning artifacts shouldn't mingle.

### 3. GSD threads (persistent conversational context)

- **What it isolates:** conversational context. `/gsd-thread` saves a context thread you can resume later — potentially in a fresh session, potentially weeks out.
- **Cost:** you must name threads and remember they exist.
- **Use for:** long-running investigations, cross-session work, switching between active threads without losing state.

### 4. Subagent-driven development (one-session orchestration)

- **What it isolates:** per-task context within one session.
- **Cost:** review overhead between subagents (spec compliance + code quality reviews after each task).
- **Use for:** executing a plan with ≥2 independent tasks when you want fresh context per task and checkpoints in between.
- **Superpowers skill:** [`subagent-driven-development`](02-discipline-layer.md).

### 5. Dispatching parallel agents (in-turn concurrency)

- **What it isolates:** individual tool calls within a single assistant turn.
- **Cost:** none — it's literally the right way to do independent lookups.
- **Use for:** ≥2 independent research queries, file reads, or agent dispatches that have no shared state.
- **Superpowers skill:** [`dispatching-parallel-agents`](02-discipline-layer.md).

## Decision tree

```
Need parallelism in WHAT dimension?

  Filesystem (two checkouts)?
    -> Git worktrees.

  Planning (multiple phases in flight)?
    -> /gsd-workstreams (same repo)
    -> /gsd-workspace (isolated copy + independent .planning/)

  Conversation (context that outlives a session)?
    -> /gsd-thread

  Execution of one plan?
    -> subagent-driven-development (per-task subagents, review gates)

  Within one turn (independent lookups)?
    -> dispatching-parallel-agents (multiple Agent calls in one message)
```

## What parallelism does NOT solve

- **Sequential dependencies.** Two tasks that share state run in series even with four subagents.
- **Review bottlenecks.** Parallel execution widens the review queue — plan for the review, not just the work.
- **Merge conflicts.** Two parallel worktrees editing the same file still conflict on merge. Parallel work doesn't cheat `git`.
- **Ambiguous specs.** Four subagents given a vague plan produce four diverging interpretations. Lock the spec before you parallelize.

The rule of thumb: *if the two pieces share anything — a file, a data model, a dependency, a deadline — parallelism turns into coordination cost, not speedup.*

## See also

- [02 Discipline Layer](02-discipline-layer.md) — `using-git-worktrees`, `subagent-driven-development`, `dispatching-parallel-agents` as skills.
- [06 Workflow Phases](06-workflow-phases.md) — how workstreams and threads interact with the GSD lifecycle.
- [12 Session Management](12-session-management.md) — `remember` and `/gsd-thread` for cross-session continuity.

---

**Prev:** [← 09 Memory Systems](09-memory-systems.md) | **Next:** [11 Cross-Cutting Workflows →](11-cross-cutting-workflows.md)
