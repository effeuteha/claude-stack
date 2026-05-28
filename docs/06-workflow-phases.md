# 06 — Workflow Phases (0–7)

> **The lifecycle turns a vague ask into shipped code.** Eight phases, each one producing a committed artifact, each one reviewable. Skip a phase only when the work is genuinely trivial — the phases exist because shortcuts compound into rewrites.

For the short version, see [Quick Reference](../reference/quick-reference.md) and the [Golden Path cheatsheet](../cheatsheets/golden-path.md). This chapter walks the full path.

**Prerequisites:** [01 Architecture Overview](01-architecture.md) for the 4-layer model; [02 Discipline Layer](02-discipline-layer.md) for the Superpowers commitments that wrap every phase.

---

## The Golden Path

```
/gsd-progress                 -> Where am I?
/gsd-spec-phase N             -> Lock WHAT (falsifiable reqs, ambiguity score) — recommended
/gsd-discuss-phase N          -> Gray-area decisions before implementation choices
/gsd-plan-phase N             -> Task breakdown, goal-backward verification
  |
  +-- /sc:spec-panel …        -> Multi-expert review inside Claude
  +-- /gsd-review …           -> Cross-AI peer review (Gemini / Codex / other CLIs)
  |
/gsd-execute-phase N          -> Wave-based parallelization
/sc:analyze                   -> Quality scan
/gsd-verify-work N            -> UAT
/gsd-ship                     -> PR + review + prep for merge
```

**Is `spec-phase` mandatory?** No — it's recommended good practice. For trivial, one-shot work, `/gsd-quick` or `/sc:implement` route around the whole lifecycle. For any phase where requirements are non-obvious, start with `spec-phase`.

---

## Phase 0 — Bootstrap

**Goal:** Restore full context in minimal tokens before any real work starts.

**Which bootstrap do I need?**

```
Existing project, returning?       -> Resume flow (restore state)
Brand new project?                 -> Init flow (map + index)
Context window getting full?       -> Pressure flow (save + clear + resume)
Paused mid-task?                   -> /gsd-resume-work (one-shot restore)
Need persistent cross-session work? -> /gsd-thread (named context threads)
```

### Resume flow (existing project)
```
1. /sc:load                          # Restore SC session context via Serena
2. /gsd-resume-work                  # Restore GSD state from STATE.md
3. Serena: list_memories             # Check for relevant project memories
4. Serena: read_memory (if relevant) # Load domain-specific knowledge
5. /gsd-progress                     # See where you are; route to next action
```

### Init flow (brand-new project)
```
1. /gsd-map-codebase                 # If brownfield (existing code)
2. /sc:index-repo                    # Project index (big token saving per session)
3. Proceed to Phase 1
```

### Pressure flow (context getting full)
```
1. /gsd-pause-work                   # Snapshot state to .continue-here
2. /sc:save                          # Persist SC session via Serena
3. Serena: write_memory              # Save critical insights
4. /clear                            # Free context
5. /gsd-resume-work                  # Restore in fresh context
```

See [04 Context Discipline](04-context-discipline.md) for token management detail and [09 Memory Systems](09-memory-systems.md) for the backing stores.

---

## Phase 1 — Spec (recommended)

**Goal:** Lock WHAT before HOW.

```
/gsd-spec-phase N
```

`spec-phase` produces `SPEC.md` with **falsifiable requirements** and an **ambiguity score**. It forces a separation: what the phase must deliver (locked) versus how it gets delivered (deferred to `discuss-phase` and `plan-phase`). High ambiguity surfaces as a score, not a silent failure — you rephrase until it drops or acknowledge explicit open questions.

**When to skip:** trivial, one-shot work where requirements are already obvious. If you can describe the phase in one sentence and everyone would agree what "done" means, skip to `/gsd-quick` or `/sc:implement`.

**Why this is the new front door:** the old lifecycle started at `discuss-phase`, which mixed requirement questions with implementation questions. Implementation decisions got smuggled in before requirements were locked, and the rework cost showed up later. `spec-phase` separates the two.

---

## Phase 2 — Discuss

**Goal:** Surface gray-area decisions *before* planning.

```
/gsd-discuss-phase N
/gsd-discuss-phase N --auto          # Claude picks recommended defaults
/gsd-discuss-phase N --all           # Discuss all gray areas, no area picker
/gsd-discuss-phase N --chain         # Interactive discuss then automatic plan + execute
/gsd-discuss-phase N --power         # Bulk questions to a file-based UI, answer at your pace
```

Creates `DISCUSS.md`. Adaptive questioning — by the end, the planner has enough context that mechanical planning is possible.

### Research happens automatically inside `/gsd-plan-phase`

The planner spawns a researcher subagent (`gsd-phase-researcher`) that surfaces ecosystem patterns, best practices, and assumption-level questions inline. You no longer need to call a separate `research-phase` or `list-phase-assumptions` command — the planner does both as part of its work.

For library-specific queries during planning or execution, reach for these directly:

```
Context7: resolve-library-id -> query-docs    # Live library docs
/sc:research --c7 "specific technical query"  # Combined web + docs
```

---

## Phase 3 — Plan

**Goal:** Produce an executable plan with atomic tasks and goal-backward verification.

```
/gsd-plan-phase N
```

Creates `PLAN.md` with task breakdown, dependency analysis, and per-task verification criteria. Every task should be atomic, testable, and reversible.

---

## Phase 3.5 — Plan review *(both are better than one for high-stakes)*

Two orthogonal review mechanisms:

### Multi-expert review inside Claude

```
/sc:spec-panel .planning/phases/NN/PLAN.md --mode critique
```

Shifts persona inside the same model — different expert priors reviewing the same plan. Catches over-engineering, missing edge cases, scope creep.

### Cross-AI peer review

```
/gsd-review .planning/phases/NN/PLAN.md
```

Dispatches the plan to *other* AI CLIs — Gemini, Codex, Copilot CLI — for a different-model second opinion. Catches shared Claude biases that `spec-panel` can't because it's still Claude.

**When to use which:**
- Low-stakes phase → `/sc:spec-panel` alone.
- High-stakes, AI-integration, security-sensitive → **both**.

Requires at least one other AI CLI installed for `/gsd-review`.

---

## Phase 4 — Execute

**Goal:** Build the phase with quality and traceability.

```
/gsd-execute-phase N
```

Wave-based parallelization — tasks grouped by dependency; each wave runs plans in parallel internally. Atomic commits per plan. Deviations handled with checkpoint protocol: if a plan diverges from the written task, the executor pauses, reports, and waits for direction.

### Autonomous alternative

```
/gsd-autonomous
```

Runs all remaining phases hands-free (discuss → plan → execute per phase). Use when you trust the spec and want to come back to a completed milestone.

### Tool selection during execution

| Tool | Use when | Example |
|---|---|---|
| Serena `find_symbol` | You know the symbol name but not the file | `find_symbol("UserService")` before extending |
| Serena `replace_symbol_body` | Rewriting a whole function/method | Replace a route handler with new impl |
| Serena `find_referencing_symbols` | Changing a public API — what breaks? | Callers of `authenticate()` before signature change |
| Serena `search_for_pattern` | Regex search across codebase | Find all `@deprecated` annotations |
| Context7 `query-docs` | Live library docs, not stale training data | "How does SQLAlchemy handle JSONB merge?" |
| Sequential Thinking | Complex logic that benefits from externalized reasoning | State machines, race-condition debugging |

### Ad-hoc implementation

For one-shot work that doesn't warrant the full lifecycle:

```
/sc:implement "feature description"
/feature-dev:feature-dev "feature description"
/gsd-quick
/gsd-progress "natural language description"  # Auto-routes freeform intent (unified situational command)
/gsd-fast                                     # Single-line fixes, skip planning entirely
```

---

## Phase 5 — Analyze

**Goal:** Quality / security / performance scan.

```
/sc:analyze                                 # All dimensions
/sc:analyze --focus security                # Security only
/sc:analyze --focus performance             # Performance only
/sc:analyze --think-hard                    # Deep analysis (more tokens)
```

For source-file review tied to a phase:

```
/gsd-code-review                            # Review files changed during the phase
/gsd-code-review --fix                      # Same review, then auto-apply mechanical findings
/code-review:code-review                    # Standalone fresh-context PR review
```

---

## Phase 6 — Verify

**Goal:** Confirm the phase delivers what was promised.

### UAT

```
/gsd-verify-work N
```

Interactive yes/no verification with auto-diagnosis of failures. Goal-backward — checks the *phase goal* was met, not just that tasks completed.

### Retroactive validation

```
/gsd-validate-phase N
```

Fills validation gaps, generates tests, verifies coverage where the plan didn't prescribe it.

### Test generation from UAT criteria

```
/gsd-add-tests N
```

Generates test scaffolds from the phase's acceptance criteria.

### UI phases

```
/gsd-ui-review
```

6-pillar visual audit. Pair with Playwright MCP for automated screenshot checks.

### The verification gate (Superpowers discipline)

Before claiming completion:

```
1. IDENTIFY what command proves the claim
2. RUN the full command (fresh)
3. READ full output, check exit code
4. VERIFY output confirms the claim
5. ONLY THEN make the claim
```

This is the `verification-before-completion` skill at work — no success claims without evidence. See [Chapter 02](02-discipline-layer.md).

---

## Phase 7 — Ship

**Goal:** Hand the phase off cleanly — PR, review, merge prep.

```
/gsd-ship
```

Creates the PR, runs code review, prepares the commit chain for merge. Replaces ad-hoc `gh pr create` workflows.

### Milestone completion

When a milestone (not just a phase) is done:

```
/gsd-audit-milestone                        # Audit completion against original intent (surfaces gaps)
/gsd-audit-uat                              # Cross-phase audit of outstanding UAT items
/gsd-milestone-summary                      # Generate team-facing summary for onboarding/review
/gsd-extract-learnings                      # Pull decisions, lessons, surprises from phase artifacts
/gsd-complete-milestone 1.0.0               # Archive + git tag
/sc:git                                     # Push tags, clean git state
/claude-md-management:revise-claude-md      # Update CLAUDE.md with session learnings
/gsd-cleanup                                # Archive completed phase directories
```

### Knowledge persistence

```
Serena: write_memory                        # Curated project knowledge
/sc:save                                    # Persist SC session context
```

---

## New phase types

Specialized shapes for work that needs extra rigor or explicit permission to throw code away.

### `/gsd-ai-integration-phase`

For AI/LLM feature phases. Produces `AI-SPEC.md` with framework selection, evaluation strategy, domain-expert rubrics, guardrails. Pairs with `/gsd-eval-review` post-implementation for retroactive coverage audit. Use this whenever the phase depends on LLM behavior, because generic plan-phase doesn't know to ask about evals.

### `/gsd-ui-phase`

For frontend phases. Produces `UI-SPEC.md` design contract. Pairs with the `frontend-design` plugin for generation and `/gsd-ui-review` for the 6-pillar post-implementation audit.

### `/gsd-mvp-phase`

Plans a phase as a *vertical MVP slice* — a thin end-to-end implementation chosen with SPIDR splitting (Spike / Path / Interfaces / Data / Rules). The output is a user story plus a plan-phase invocation scoped to the slice. Use when a phase is larger than one focused sitting; the MVP slice ships first, follow-ups become their own phases.

### `/gsd-sketch`

Throwaway UI exploration — multi-variant HTML mockups before committing to a real `ui-phase`. Findings are packaged automatically into a persistent skill at the end of the sketch session.

### `/gsd-spike`

Throwaway code experiments to validate feasibility before planning. Findings are captured automatically at the end of the spike session.

### `/gsd-secure-phase`

Retroactive threat-mitigation audit for a completed phase — verifies the threat model from `PLAN.md` was actually implemented. Produces `SECURITY.md`. Pair with security-sensitive phases as a post-execution gate.

### `/gsd-eval-review`

Retroactive coverage audit for an AI-integration phase — scores each eval dimension from `AI-SPEC.md` as COVERED / PARTIAL / MISSING and produces `EVAL-REVIEW.md`. The post-execution counterpart to `/gsd-ai-integration-phase`.

---

## When to skip the golden path

| Scenario | Use |
|---|---|
| Single-line fix | `/gsd-fast` or direct edit |
| "Just do it" task | `/gsd-quick` |
| AI/LLM phase | `/gsd-ai-integration-phase` (adds eval gates) |
| Frontend phase | `/gsd-ui-phase` (adds design contract) |
| Explore feasibility before planning | `/gsd-spike` |
| Explore UI variants before `ui-phase` | `/gsd-sketch` |
| Urgent insert into a live roadmap | `/gsd-phase insert` (decimal phase N.1) |
| Phase too big to plan as one slice | `/gsd-mvp-phase` (SPIDR splitting, vertical MVP first) |

---

## Anti-patterns in this layer

- **Skipping `spec-phase`** on a non-trivial phase — implementation decisions smuggle in before requirements.
- **Running only one kind of plan review** on a high-stakes phase — same-model blindspots survive.
- **Choosing `/gsd-quick`** when `/gsd-spec-phase` would have caught the ambiguity.
- **Not verifying after execute** — "tests pass" is weaker than "the phase goal is met."
- **Wrong phase type** — running generic `/gsd-plan-phase` for an AI feature; you lose the eval gate.

See [15 Anti-Patterns](15-anti-patterns.md) for the full list.

---

## See also

- [02 Discipline Layer](02-discipline-layer.md) — how Superpowers wraps every phase
- [07 Quality Scaling](07-quality-scaling.md) — review tools and the reviewer pattern
- [11 Cross-Cutting Workflows](11-cross-cutting-workflows.md) — debug / forensics / audit-fix / AI-integration walkthroughs

---

**Previous:** [Task Routing](05-task-routing.md) | **Next:** [Quality Scaling](07-quality-scaling.md)
