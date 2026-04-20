# Quality Scaling

## The Reviewer Pattern

One of the highest-value patterns in AI-assisted development: **have a second AI review the first AI's output**. Multiple uncorrelated context windows consistently catch bugs that a single context misses.

### Structured Review Flow

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

### Ways to Implement

| Method | When to Use |
|--------|------------|
| `/code-review:code-review` | PR review with 5 parallel review agents |
| `/sc:spec-panel` | Multi-expert panel reviews plans/specs before execution |
| Mysti Brainstorm (Red-Team) | Adversarial review between two different AI models |
| `/sc:analyze --think-hard` | Deep self-review within same context |
| Second Claude Code session | Independent QA in separate terminal tab |
| Codex CLI / Gemini CLI | Cross-model verification (different model = different blind spots) |

## Git Hotspot Analysis

Find the files that change most frequently — they're where bugs cluster and where reviews matter most:

```bash
# Top 20 most-changed files in the last 3 months
git log --since="3 months ago" --name-only --pretty=format: | \
  sort | uniq -c | sort -rn | head -20
```

### What to Do With Hotspots

- Focus code review effort on these files
- Run `/sc:analyze --focus quality` on hotspot files
- Consider refactoring to reduce coupling (fewer reasons to change = fewer hotspot entries)
- Add stronger test coverage to high-churn files

## Mutation Testing (For Critical Code)

Standard test coverage tells you what code is **executed**, not what code is **tested**. Mutation testing verifies your tests actually catch bugs:

```bash
# Python (mutmut)
pip install mutmut && mutmut run

# JavaScript (Stryker)
npx stryker run

# Other languages: see https://mutation-testing.org
```

**Target:** >= 80% mutation kill rate for production-critical code.

**When to use:** Auth, payment processing, data integrity, security-critical paths, core business logic.

## Cross-Model QA Workflow

For maximum quality on critical features:

```
1. Plan with Claude Code Opus (plan mode)
2. Review plan with second model (Mysti @gemini, or Codex CLI)
3. Implement with Claude Code Opus (phase-by-phase)
4. Verify with second model (independent review against plan)
```

The key insight: "The more tokens you throw at a coding problem, the better the result. Using separate context windows makes results even better — this is why one agent can cause bugs and another (same model) can find them."

---

**See also:** [Anti-Patterns](15-anti-patterns.md) #1 (skipping spec-panel) and #14 (autonomous without review) — the two most common quality-related mistakes.

**Previous:** [Workflow Phases](06-workflow-phases.md) | **Next:** [Knowledge Management](08-knowledge-management.md)
