# Walkthrough: Building an API Feature End-to-End

This walkthrough shows the complete lifecycle of building a real feature using the stack. We'll add a "user preferences" API endpoint to an existing project.

**Profile used:** Standard (Claude Code + GSD + SuperClaude + Serena + Context7)

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

## Step 1: Discuss the Phase (5 minutes)

```bash
/gsd:discuss-phase 3
```

GSD asks questions about what you want. You answer:

> **Q: What's the core deliverable?**
> A: REST endpoint for CRUD operations on user preferences (theme, notifications, language).
>
> **Q: Any constraints?**
> A: Must use existing auth middleware. Preferences stored in the users table, not a separate table. No breaking changes to existing API.
>
> **Q: What's out of scope?**
> A: No UI for preferences (frontend team handles that later). No preference syncing across devices.

GSD creates `CONTEXT.md` capturing your vision.

---

## Step 2: Surface Assumptions (2 minutes)

```bash
/gsd:list-phase-assumptions 3
```

Claude reveals what it assumes:
- "I'll add a `preferences` JSONB column to the users table"
- "I'll create GET/PUT endpoints at `/api/v1/users/me/preferences`"
- "I'll validate preference values against a schema"
- "I'll use the existing test patterns"

You correct: "Use PATCH not PUT for partial updates. And preferences should have defaults so new users don't need to set anything."

---

## Step 3: Research (3 minutes)

```bash
# Check how the existing API handles similar endpoints
# Serena navigates code semantically
```

Serena's `find_symbol` reveals the existing pattern:
- Routes in `src/api/routes/users.py`
- Auth via `@require_auth` decorator
- Response format: `{"data": {...}, "meta": {...}}`
- Validation with Pydantic models

```bash
# Check library docs for JSONB operations
# Context7 provides up-to-date docs
```

Context7 returns SQLAlchemy JSONB column examples and merge strategies.

---

## Step 4: Plan (5 minutes)

```bash
/gsd:plan-phase 3
```

GSD spawns researcher + planner + plan-checker agents. After ~2 minutes, it produces:

```
.planning/phases/03-user-preferences/03-01-PLAN.md

Tasks:
1. Add preferences column migration
2. Create Pydantic models (PreferencesSchema, PreferencesUpdate)
3. Add GET /api/v1/users/me/preferences endpoint
4. Add PATCH /api/v1/users/me/preferences endpoint
5. Add default preferences constant
6. Write tests (5 test cases)

Dependencies: Task 1 before 2-6. Tasks 2-5 can parallelize after 1.
Verification: All tests pass, manual curl test of both endpoints.
```

---

## Step 5: Review the Plan (3 minutes)

```bash
/sc:spec-panel .planning/phases/03-user-preferences/03-01-PLAN.md --mode critique
```

The expert panel reviews:

> **Karl Wiegers:** "Task 5 (default preferences) should define what the defaults ARE — theme: 'system', notifications: true, language: 'en'. Without this, the implementation will guess."
>
> **Martin Fowler:** "Consider adding a preferences version field for future schema evolution. When you add new preference keys later, you'll need to know which version a user's preferences were last updated under."
>
> **Lisa Crispin:** "Missing test case: what happens when a user sends an unknown preference key? Should it be silently ignored or return 400?"

You update the plan: add explicit defaults, add a `preferences_version` field, add an unknown-key test case.

---

## Step 6: Execute (10 minutes)

```bash
# Clear context from planning — fresh start for execution
/gsd:pause-work
/clear
/gsd:resume-work

# Execute the plan
/gsd:execute-phase 3
```

The executor agent:
1. Creates the migration file using Serena to find the migration directory pattern
2. Adds Pydantic models following the existing model patterns (found via Serena)
3. Implements GET endpoint with `@require_auth` decorator
4. Implements PATCH endpoint with merge logic for JSONB
5. Defines `DEFAULT_PREFERENCES` constant
6. Writes 6 test cases following existing test patterns

During execution, Context7 is consulted for SQLAlchemy JSONB merge syntax.

---

## Step 7: Quality Check (5 minutes)

```bash
# Code analysis
/sc:analyze --focus security
```

Results:
- No SQL injection (parameterized queries used correctly)
- Auth decorator present on both endpoints
- Input validation via Pydantic
- One suggestion: "Add rate limiting to PATCH endpoint to prevent preference-spam"

```bash
# Run tests
/sc:test
```

All 6 tests pass. Coverage: 94% on new code.

```bash
# User acceptance testing
/gsd:verify-work 3
```

GSD extracts deliverables from the plan and asks:
- "Can you GET preferences for a new user?" → Yes, returns defaults
- "Can you PATCH a single preference without affecting others?" → Yes
- "Does unknown key return 400?" → Yes
- "Are preferences persisted across sessions?" → Yes

All verified. Phase marked complete.

---

## Step 8: Commit and Move On

```bash
/sc:git
```

Clean commit with descriptive message. On to Phase 4.

---

## What Made This Better Than "Just Asking Claude"

| Without the Stack | With the Stack |
|-------------------|---------------|
| Jump straight to coding | Discuss → assumptions → research → plan → review → execute |
| Claude guesses at patterns | Serena finds actual codebase patterns |
| No plan review | Spec-panel catches 3 issues before coding starts |
| Context bloat from planning + coding | `/clear` between planning and execution |
| "Does it work?" — manual checking | GSD verify-work with structured UAT |
| No traceability | Full audit trail in `.planning/` |
| Knowledge lost between sessions | Serena memories + GSD state persist |

**Total time:** ~35 minutes for a well-tested, reviewed, properly planned feature.

**Without the stack:** Same feature might take similar time to code, but you'd spend hours later fixing the issues that spec-panel caught in 3 minutes.

---

## Key Takeaways

1. **Discuss before planning** — 5 minutes of context saves hours of rework
2. **Surface assumptions** — Claude's assumptions are often 80% right and 20% wrong. Catch the 20% early.
3. **Review plans before executing** — `/sc:spec-panel` is the highest-ROI step in the entire workflow
4. **Clear context between phases** — planning tokens degrade execution quality
5. **Let Serena find patterns** — don't guess at codebase conventions, look them up
6. **Use Context7 for library docs** — faster and more accurate than Claude's training data
