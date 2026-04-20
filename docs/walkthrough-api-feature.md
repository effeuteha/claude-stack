# Walkthrough: Building an API Feature End-to-End

This walkthrough shows the complete lifecycle of building a real feature using the stack. We'll add a "user preferences" API endpoint to an existing project, following the spec-first golden path.

**Profile used:** Standard (Claude Code + Superpowers + GSD + SuperClaude + Serena + Context7)

---

## Step 0: Session Start (2 minutes)

```bash
# Start Claude Code in your project
claude

# Check where we are
/gsd:progress
```

GSD reports: Milestone v1.2 in progress, Phase 3 (User Preferences API) is next.

```bash
# Refresh codebase understanding (if stale)
/sc:index-repo
```

This creates a 3KB project index instead of reading 58K tokens of source code.

---

## Step 1: Spec the Phase — Lock WHAT (5 minutes)

```bash
/gsd:spec-phase 3
```

`spec-phase` produces `SPEC.md` with falsifiable requirements and an **ambiguity score**. For this phase the first pass returns:

```
Ambiguity: 3/10 (moderate — 2 open questions)

Requirements:
  REQ-1: CRUD API endpoints for user preferences (theme, notifications, language)
  REQ-2: Preferences stored in users table (existing schema), not new table
  REQ-3: Uses existing auth middleware
  REQ-4: No breaking changes to existing API surface
  REQ-5: [open] Partial update semantics — PUT or PATCH?
  REQ-6: [open] Default preference values — hardcoded or config-driven?

Out of scope:
  - UI for preferences
  - Cross-device syncing
```

You answer the open questions: **PATCH** for partial updates, **hardcoded defaults** as a constant. Re-run ambiguity check: 1/10. `SPEC.md` is locked.

---

## Step 2: Discuss — Gray-Area Implementation Decisions (5 minutes)

```bash
/gsd:discuss-phase 3
```

Now the requirements are locked, we discuss *how*. GSD asks:

> **Q: JSONB column or separate table?**
> A: JSONB column. SPEC says no new table; this aligns.
>
> **Q: Schema validation for preference values?**
> A: Pydantic schema per preference key. Unknown keys return 400.
>
> **Q: Version the preference shape?**
> A: Yes — add `preferences_version` field for forward compatibility.

GSD writes `DISCUSS.md`.

---

## Step 3: Plan (5 minutes)

```bash
/gsd:plan-phase 3
```

GSD spawns researcher + planner + plan-checker agents. After ~2 minutes, it produces:

```
.planning/phases/03-user-preferences/PLAN.md

Tasks:
  1. Add preferences column migration (+ preferences_version)
  2. Create Pydantic models (PreferencesSchema, PreferencesUpdate)
  3. Add GET /api/v1/users/me/preferences endpoint
  4. Add PATCH /api/v1/users/me/preferences endpoint
  5. Add DEFAULT_PREFERENCES constant
  6. Write 6 test cases (including unknown-key -> 400)

Dependencies: Task 1 before 2-6. Tasks 2-5 can parallelize after 1.
Verification: All tests pass, manual curl test of both endpoints, ambiguity score 0.
```

---

## Step 4: Review the Plan — `/sc:spec-panel` + `/gsd:review` (3 minutes)

```bash
/sc:spec-panel .planning/phases/03-user-preferences/PLAN.md --mode critique
```

Multi-expert panel (inside Claude):

> **Karl Wiegers:** "Task 5 should define what the defaults ARE — `theme: 'system'`, `notifications: true`, `language: 'en'`. Without explicit values, the implementation will guess."
>
> **Martin Fowler:** "Good call on `preferences_version`. Consider documenting the migration path for future version bumps in the PLAN."
>
> **Lisa Crispin:** "Task 6 covers unknown-key behavior. Add a test for malformed JSON too — different 400."

You update the plan: explicit defaults, version-migration note, malformed-JSON test.

**This phase is fairly low-stakes, so we skip `/gsd:review`.** For a security-sensitive or AI-integration phase, we'd run `/gsd:review` (cross-AI) in addition to `spec-panel`.

---

## Step 5: Execute (10 minutes)

```bash
# Clear context from planning — fresh start for execution
/gsd:pause-work
/clear
/gsd:resume-work

# Execute the plan
/gsd:execute-phase 3
```

The executor agent:

1. Creates the migration file using Serena to find the migration directory pattern.
2. Adds Pydantic models following the existing model patterns (found via Serena `find_symbol`).
3. Implements GET endpoint with `@require_auth` decorator.
4. Implements PATCH endpoint with merge logic for JSONB.
5. Defines `DEFAULT_PREFERENCES` constant with the three explicit values.
6. Writes 7 test cases (6 from plan + the malformed-JSON one from spec-panel review).

During execution, Context7 is consulted for SQLAlchemy JSONB merge syntax. Each task commits atomically.

---

## Step 6: Analyze (3 minutes)

```bash
/sc:analyze --focus security
```

Results:
- No SQL injection (parameterized queries used correctly).
- Auth decorator present on both endpoints.
- Input validation via Pydantic.
- One suggestion: "Add rate limiting to PATCH endpoint to prevent preference-spam."

You add rate limiting — 60 req/min per user. Commit.

---

## Step 7: Verify (3 minutes)

```bash
/sc:test                                   # Run tests
```

All 7 tests pass. Coverage: 94% on new code.

```bash
/gsd:verify-work 3                         # UAT
```

GSD extracts deliverables from `SPEC.md` and asks:

- "Can you GET preferences for a new user?" → Yes, returns defaults.
- "Can you PATCH a single preference without affecting others?" → Yes.
- "Does unknown key return 400?" → Yes.
- "Does malformed JSON return 400 with a different error?" → Yes.
- "Are preferences persisted across sessions?" → Yes.
- "Is rate limiting active on PATCH?" → Yes (60/min).

All verified. Phase marked complete.

---

## Step 8: Ship (2 minutes)

```bash
/gsd:ship
```

`ship` creates the PR, runs code review, prepares the commit chain for merge. Review passes. PR is ready.

---

## What If Something Goes Wrong?

| Problem | Recovery |
|---|---|
| **Ambiguity score stays high in `spec-phase`** | Re-state requirements until the score drops, or acknowledge explicit open questions in `SPEC.md` and move to `discuss-phase`. High ambiguity is a signal, not a failure. |
| **Execution fails mid-phase** | Fix the issue, then re-run `/gsd:execute-phase N` — it picks up where it left off via `.planning/` state. |
| **Tests fail after execution** | `/gsd:debug "test failure description"` for persistent debugging (survives `/clear`), or fix manually and re-run `/gsd:verify-work N`. |
| **Spec-panel or `/gsd:review` found major issues** | Update the plan: re-run `/gsd:plan-phase N` with feedback, then execute again. |
| **Workflow collapsed; need post-mortem** | `/gsd:forensics` analyzes git history + `.planning/` artifacts + state to diagnose. |
| **Autonomous follow-up quality work** | `/gsd:audit-fix` for an audit → classify → fix → test → commit cycle. |
| **Need to roll back the phase** | `/gsd:undo` — safe git revert using the phase manifest with dependency checks. |
| **Context got bloated** | `/gsd:pause-work` → `/clear` → `/gsd:resume-work` — resume with clean context. |
| **Pausing for the day** | `/gsd:pause-work` leaves a handoff; `/gsd:resume-work` picks up tomorrow. For a named parallel thread: `/gsd:thread`. |
| **Wrong approach entirely** | Re-run `/gsd:spec-phase N` with updated vision — starts over with a new SPEC; old artifacts archive. |

The workflow is **not a one-way conveyor belt**. You can loop back to any earlier phase at any time. `.planning/` tracks where you are.

---

## Why This Approach Scales Better

| Without the Stack | With the Stack |
|---|---|
| Jump straight to coding | Spec → discuss → plan → review → execute → verify → ship |
| Claude guesses at patterns | Serena finds actual codebase patterns |
| No plan review | `/sc:spec-panel` catches 3 issues before coding; `/gsd:review` for cross-AI on high-stakes |
| Context bloat from planning + coding | `/clear` between planning and execution |
| "Does it work?" — manual checking | `/gsd:verify-work` with structured UAT goal-backward from SPEC |
| No traceability | Full audit trail in `.planning/` |
| Knowledge lost between sessions | Serena memories + GSD state + `remember` plugin persist |

**Total time:** ~40 minutes for a well-specified, reviewed, properly-planned, verified, and shipped feature.

**Without the stack:** the same feature might take similar raw coding time, but you'd spend hours later fixing issues that spec-phase + spec-panel caught in 8 minutes.

---

## Key Takeaways

1. **Spec before discuss** — `spec-phase` locks WHAT; `discuss-phase` handles HOW. Mixing them smuggles implementation decisions into requirements.
2. **Ambiguity score is a signal** — high score ≠ failure; it's feedback that requirements aren't stable enough to plan yet.
3. **Review the plan** — `/sc:spec-panel` is one of the highest-ROI steps. For high-stakes phases, add `/gsd:review` for cross-AI review.
4. **Clear context between phases** — planning tokens degrade execution quality.
5. **Let Serena find patterns** — don't guess at codebase conventions, look them up.
6. **Use Context7 for library docs** — faster and more accurate than Claude's training data.
7. **`/gsd:ship` replaces ad-hoc PR creation** — the phase has a clean handoff built in.

---

**See also:**
- [02 Discipline Layer](02-discipline-layer.md) — the Superpowers commitments wrapping every step above
- [06 Workflow Phases](06-workflow-phases.md) — the full lifecycle with new phase types (ai-integration, ui, sketch, spike)
- [07 Quality Scaling](07-quality-scaling.md) — review tools including `/gsd:review` cross-AI peer review
