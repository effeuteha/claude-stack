# 02 — The Discipline Layer (Superpowers)

> **Discipline is orthogonal to every other layer.** You can use the right tool
> the wrong way. This chapter covers the Superpowers methodology — how you
> *approach* work across the whole stack.

Superpowers is a plugin, but it behaves less like a tool and more like a set of commitments. The plugin ships 14 skills in its current version; this chapter covers the load-bearing ones — the commitments that change how you work, not just what commands you type. None of them is sufficient alone. Brainstorm-first without TDD produces well-conceived features that regress. TDD without verification-before-completion produces green tests and broken deploys. Each commitment compounds with the others, and the gap between teams that have internalized them and teams that haven't is the gap between AI-assisted pair-programming and AI engineering.

## The commitments (1 paragraph each)

### `brainstorm-first`

**WHY:** Implementation questions hide requirement ambiguity. You don't discover that a feature is underspecified by staring at a blank editor — you discover it when a Socratic conversation forces you to answer questions you hadn't asked.
**WHEN:** Any creative work — new feature, new component, new behavior.
**HOW:** `/superpowers:brainstorming` forces a structured dialogue before a single line of code is written. The output is a shared understanding of the problem, not a design doc nobody reads.

### `test-driven-development`

**WHY:** The failing test *defines* the behavior; the passing test *proves* it. Writing tests after the code is a form of confirmation bias — you test the behavior you implemented, not the behavior you intended.
**WHEN:** Every feature and bugfix. Especially bugfixes — a bug without a regression test is a bug that will return.
**HOW:** Red → Green → Refactor. One expected-to-fail test at a time. `/superpowers:test-driven-development` keeps the cycle honest.

### `verification-before-completion`

**WHY:** "It should work" is not a claim. "I ran it, here's the output" is. The discipline of citing evidence — pasting the actual command output, not summarizing it — closes the gap between what was built and what was believed to be built.
**WHEN:** Before saying `done`, `fixed`, `passing`, or opening a PR.
**HOW:** Run the command, read the output, cite it. No success claim without evidence. `/superpowers:verification-before-completion` enforces this before any task is declared complete.

### `systematic-debugging`

**WHY:** Pattern-matching fixes the symptom, not the cause. Experienced engineers debug systematically because they've learned — usually the hard way — that "I've seen this before" is a 50% prior, not a diagnosis.
**WHEN:** Any bug that didn't fall to a 2-minute read.
**HOW:** Scientific method — hypothesis, predicted observation, experiment. One variable changes per experiment. `/superpowers:systematic-debugging` structures the loop and prevents the thrash of undirected changes.

### `requesting-code-review` / `receiving-code-review`

**WHY:** Two minds, two priors, two sets of blindspots. Code review isn't about catching bugs — experienced reviewers know bugs survive review routinely. It's about transferring knowledge, surfacing implicit assumptions, and catching design mistakes before they calcify.
**WHEN:** On completion of major features; before merging to `main`.
**HOW:** A fresh-agent review against the spec; respond to feedback with rigor, not deference. Agreeing with every comment is as bad as dismissing every comment. `/superpowers:requesting-code-review` and `/superpowers:receiving-code-review` split the roles deliberately — the commitments are different.

### `using-git-worktrees`

**WHY:** Parallel feature work pollutes a single checkout — state leaks between branches. A stash forgotten, a file half-edited, a test database in the wrong state. Worktrees eliminate the class of bugs caused by shared working-directory state.
**WHEN:** 2+ features in flight simultaneously; high-stakes refactors where you want to keep `main` pristine beside your branch.
**HOW:** `git worktree add` into a sibling directory; each worktree is an isolated filesystem sharing one `.git`. `/superpowers:using-git-worktrees` walks through setup and cleanup.

### `subagent-driven-development`

**WHY:** Sequential implementation is slow when tasks are independent. Parallel subagents finish in overlapping time, with fresh context per task — no context bleed, no accumulated confusion from prior steps.
**WHEN:** Implementation plans with 2 or more independent tasks.
**HOW:** Dispatch one subagent per task; review between tasks. The discipline is in the review step — subagents finish fast and the quality bar still applies. `/superpowers:subagent-driven-development` structures dispatch and handoff.

### `dispatching-parallel-agents`

**WHY:** 2+ unrelated queries run sequentially only because sequential is the default. The cost of running them in parallel is zero; the time saving is proportional to the number of parallel branches.
**WHEN:** Any turn where you have independent research questions, independent verifications, or independent reads.
**HOW:** Multiple Agent tool calls in a single message. The results come back in parallel and are synthesized before the next step. `/superpowers:dispatching-parallel-agents` demonstrates the pattern.

### `writing-plans` / `executing-plans`

**WHY:** A plan is a contract with yourself — atomic, testable, reversible tasks. Without a written plan, implementation scope drifts and "almost done" becomes a permanent state.
**WHEN:** Any non-trivial feature after the spec is locked. If you can't write down the steps, you don't understand the problem yet.
**HOW:** Plan saved to `docs/superpowers/plans/`; executed task-by-task with verification at each step. `/superpowers:writing-plans` and `/superpowers:executing-plans` enforce the separation — planning and execution are different cognitive modes and should not be mixed.

## How this layer compounds with the others

The discipline layer is *how*, not *what*:
- SuperClaude tells you **what to build and why** (research, design, spec-panel).
- GSD tells you **how to shepherd it through the lifecycle** (spec → discuss → plan → execute → verify).
- Serena + Context7 tell you **how to manipulate the code itself**.
- **Superpowers tells you how to work at all three.**

A team using GSD without `brainstorm-first` will build the wrong spec correctly. A team with `brainstorm-first` + GSD will build the right spec correctly. Add TDD and `verification-before-completion` and the output is not just correct — it's provably correct, with the evidence in the commit history.

The discipline layer doesn't replace any of the others. It is the multiplier applied to all of them.

## See also

- [04 — Context Discipline](04-context-discipline.md)
- [06 — Workflow Phases](06-workflow-phases.md)
- [07 — Quality Scaling](07-quality-scaling.md)

---

**Prev:** [← 01 Architecture](01-architecture.md) | **Next:** [03 Claude Code Internals →](03-claude-code-internals.md)
