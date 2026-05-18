# 07 — Quality Scaling

Quality compounds. Every defect you catch in review is one you don't chase in production; every plan you cross-review with a second model catches blindspots you'd otherwise ship. This chapter maps the review mechanisms and when to reach for each.

## The Reviewer Pattern

One of the highest-value patterns in AI-assisted development: **have a second reviewer inspect the first producer's output.** Multiple uncorrelated contexts consistently catch bugs that a single context misses.

### Structured review flow

```
1. Agent A produces implementation
2. Agent B reviews with structured criteria:
   - Correctness: Does it do what was asked?
   - Completeness: Are edge cases handled?
   - Consistency: Does it match codebase patterns?
   - Security: Any vulnerabilities introduced?
3. Agent B returns verdict: APPROVED / NEEDS_REVISION / CONDITIONALLY_APPROVED
4. Maximum 2 revision cycles, then escalate to human
```

## Plan review — `/sc:spec-panel` vs `/gsd:review`

Two complementary mechanisms for reviewing a plan *before* execution. They are not redundant.

### `/sc:spec-panel` — multi-expert inside Claude

```
/sc:spec-panel .planning/phases/NN/PLAN.md --mode critique
```

Shifts persona within the same model — different expert priors reviewing the same plan. Catches over-engineering, missing edge cases, scope creep. Fast; no external tool required.

### `/gsd:review` — cross-AI peer review

```
/gsd:review .planning/phases/NN/PLAN.md
```

Dispatches the plan to **other AI CLIs** — Gemini CLI, Codex CLI, Copilot CLI, etc. — for a different-model second opinion. Catches shared Claude biases that `spec-panel` can't, because it's still Claude.

**Setup:** requires at least one other AI CLI installed on the path. See each CLI's docs for install; `/gsd:review` auto-detects installed peers.

### When to use which

| Scenario | Use |
|---|---|
| Low-stakes feature | `/sc:spec-panel` alone |
| Standard feature | `/sc:spec-panel` before `/gsd:execute-phase` |
| High-stakes phase (AI integration, security, data migration) | **Both** — `/sc:spec-panel` AND `/gsd:review` |
| Production-core refactor | Both, plus Mysti Red-Team for a third perspective |

The philosophy: *persona shifts inside one model ≠ prior shifts across models.* When the stakes justify the cost, do both.

### `/gsd:plan-review-convergence` — replan-until-clean loop

When a cross-AI review surfaces non-trivial concerns, the convergence command runs the loop for you:

```
/gsd:plan-review-convergence .planning/phases/NN/PLAN.md
```

It re-plans with the review feedback and re-reviews, until no HIGH-severity concerns remain (or the cycle limit is hit). Use for high-stakes phases where you want the plan to settle before execution rather than catching issues mid-execute. Costs more tokens than a single review — reach for it when the cost of a bad plan is high.

## Post-implementation code review

### `/code-review:code-review` plugin — standalone fresh-context review

Runs on any git diff or PR. Dispatches multiple review agents in parallel, each with a focus (correctness, security, consistency, performance). Produces a consolidated verdict. Use before merging any significant change.

### `/gsd:code-review` — phase-scoped review

Reviews source files changed during a GSD phase. Produces `REVIEW.md` under the phase directory with severity-classified findings. Use as part of Phase 5 (Analyze) in the workflow.

### `/gsd:code-review --fix` — auto-fix the findings

Same review pass, but the orchestrator also spawns a fixer subagent (`gsd-code-fixer`) that reads `REVIEW.md`, applies intelligent fixes, and commits each fix atomically. Use the `--fix` flag when the findings are mechanical (formatting, minor patterns, safe refactors) and you trust them to apply without human triage.

## `/gsd:audit-fix` — autonomous audit-to-fix

For follow-up quality work where you want an end-to-end cycle without per-step prompting:

```
/gsd:audit-fix
```

Runs: find issues → classify severity → apply fixes → run tests → commit per fix. Use on a feature branch, not main. Good for sweeping a mature codebase for consistency issues or grinding through low-severity tech debt.

## Retroactive phase audits — `/gsd:secure-phase`, `/gsd:eval-review`, `/gsd:audit-uat`, `/gsd:validate-phase`

When a phase is already implemented and you want to verify it actually met its non-functional contract, reach for the retroactive auditors instead of redoing the plan:

| Command | What it verifies | Output |
|---|---|---|
| `/gsd:secure-phase` | Threat mitigations from `PLAN.md` threat model are present in code | `SECURITY.md` |
| `/gsd:eval-review` | AI-integration eval coverage matches `AI-SPEC.md` rubrics | `EVAL-REVIEW.md` (COVERED / PARTIAL / MISSING per dim) |
| `/gsd:audit-uat` | UAT items outstanding across phases — cross-phase view | structured report |
| `/gsd:validate-phase` | Test coverage and validation gaps the plan didn't prescribe | generated tests + coverage report |

Use these *after* execute when you didn't pre-commit to the discipline in `PLAN.md`. They are intentionally retroactive — the audit reads what the plan promised and checks what the code delivered.

## Review targets — where to focus effort

### Git hotspot analysis

Find the files that change most frequently — they're where bugs cluster and where reviews matter most:

```bash
# Top 20 most-changed files in the last 3 months
git log --since="3 months ago" --name-only --pretty=format: | \
  sort | uniq -c | sort -rn | head -20
```

**What to do with hotspots:**

- Focus code review effort on these files.
- Run `/sc:analyze --focus quality` on hotspot files.
- Consider refactoring to reduce coupling (fewer reasons to change = fewer hotspot entries).
- Add stronger test coverage to high-churn files.

### Mutation testing (for critical code)

Standard test coverage tells you what code is *executed*, not what code is *tested*. Mutation testing verifies your tests actually catch bugs:

```bash
# Python (mutmut)
pip install mutmut && mutmut run

# JavaScript (Stryker)
npx stryker run
```

**Target:** ≥ 80% mutation kill rate for production-critical code.

**When to use:** auth, payment processing, data integrity, security-critical paths, core business logic.

## Cross-Model QA Workflow

For maximum quality on critical features:

```
1. Plan with Claude Code (plan mode)
2. Review plan with a second model:
   - /sc:spec-panel (multi-expert in Claude)
   - /gsd:review (cross-AI peer review)
   - Mysti @gemini Red-Team
3. Implement with Claude Code (phase-by-phase)
4. Verify with the reviewer pattern:
   - /code-review:code-review (standalone PR review)
   - /gsd:code-review (phase-scoped review)
   - Second Claude Code session for independent QA
```

The key insight: *the more uncorrelated review you throw at the problem, the more blindspots shrink.* One agent can introduce a bug and another (same model) can find it; *different* models find different classes of bug entirely.

## Ways to implement review — summary table

| Method | When to use |
|---|---|
| `/sc:spec-panel` | Plan review before execute — multi-expert in Claude |
| `/gsd:review` | Plan review before execute — cross-AI, different models |
| `/gsd:plan-review-convergence` | Replan-with-review loop until no HIGH concerns remain |
| `/code-review:code-review` | Post-implementation PR review — 5 parallel review agents |
| `/gsd:code-review` | Phase-scoped review of changed source files |
| `/gsd:code-review --fix` | Same review + auto-apply mechanical findings |
| `/gsd:audit-fix` | Autonomous audit-to-fix pipeline for follow-up work |
| `/gsd:secure-phase` | Retroactive threat-mitigation audit |
| `/gsd:eval-review` | Retroactive AI eval coverage audit |
| `/gsd:audit-uat` | Cross-phase UAT outstanding-items audit |
| `/gsd:validate-phase` | Retroactive test/coverage gap fill |
| Mysti Brainstorm (Red-Team) | Adversarial review between two models (GUI) |
| `/sc:analyze --think-hard` | Deep self-review within same context |
| Second Claude Code session | Independent QA in a separate terminal tab |
| Codex CLI / Gemini CLI | Cross-model verification — different training priors |

---

**See also:** [15 Anti-Patterns](15-anti-patterns.md) — especially the "single-model review on high-stakes plan" entry.

**Previous:** [Workflow Phases](06-workflow-phases.md) | **Next:** [Knowledge Management](08-knowledge-management.md)
