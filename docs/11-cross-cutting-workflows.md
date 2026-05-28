# 11 — Cross-Cutting Workflows

Workflows that apply regardless of which phase you're in.

## Debugging

```
/gsd-debug "issue description"            # Persistent debug session; survives /clear
                                          # Re-run /gsd-debug to resume the same investigation
```

`/gsd-debug` runs a scientific-method investigation with persistent state across context resets — each cycle has a hypothesis, predicted observation, and experiment. See Superpowers' `systematic-debugging` skill ([Ch 02](02-discipline-layer.md)) for the discipline this is built on.

For complex bugs, combine with:
```
Sequential Thinking: sequentialthinking   # Multi-step hypothesis testing
Serena: find_referencing_symbols          # Trace call chains
/sc:troubleshoot                          # Diagnose builds, deployments, systems
```

## Post-mortem: `/gsd-forensics`

When a GSD workflow fails or produces bad output — a phase that shipped a regression, a milestone that missed its goal, a plan that collapsed during execute — use `/gsd-forensics` to diagnose what went wrong:

```
/gsd-forensics
```

Analyzes git history, `.planning/` artifacts, and state to diagnose the root cause. Produces a post-mortem report. Use this instead of poking at files manually — the forensics agent has the full phase manifest and can trace causality.

## Autonomous audit → fix: `/gsd-audit-fix`

For follow-up quality work where you want an end-to-end cycle without per-step prompting:

```
/gsd-audit-fix
```

Runs: find issues → classify severity → apply fixes → run tests → commit per fix. Use on a feature branch, not main. Good for sweeping a mature codebase for consistency issues or grinding through low-severity tech debt. See [07 Quality Scaling](07-quality-scaling.md) for placement.

## AI-integration phase walkthrough

For any phase that builds AI/LLM functionality, the generic `/gsd-plan-phase` is wrong — it doesn't know to ask about evaluation strategy. Use the specialized flow:

```
1. /gsd-ai-integration-phase N            # Produces AI-SPEC.md
                                          #   - Framework selection
                                          #   - Evaluation strategy (rubrics, eval sets)
                                          #   - Domain-expert failure modes
                                          #   - Guardrails
2. /gsd-plan-phase N                      # Normal plan, now informed by AI-SPEC
3. /gsd-execute-phase N                   # Build it
4. /gsd-eval-review                       # Retroactive coverage audit against AI-SPEC
```

`/gsd-eval-review` scores each eval dimension as COVERED / PARTIAL / MISSING and produces an `EVAL-REVIEW.md` with remediation guidance.

## UI phase walkthrough

For frontend phases, pair the UI-specific spec with the generation plugin and the visual audit:

```
1. /gsd-ui-phase N                        # Produces UI-SPEC.md design contract
2. /frontend-design:frontend-design       # Generate components matching the spec
3. /gsd-ui-review                         # 6-pillar post-implementation audit
```

For exploratory UI work before committing to a spec:

```
/gsd-sketch                               # Multi-variant HTML mockups (throwaway)
                                          # Findings packaged automatically at session end
```

With Playwright for automated visual checks:

```
Playwright: browser_navigate              # Navigate to dev server
Playwright: browser_snapshot              # Capture accessibility tree
Playwright: browser_take_screenshot       # Visual verification
```

## Idea capture

The narrow capture verbs (`/gsd-note`, `/gsd-add-todo`, `/gsd-plant-seed`, `/gsd-add-backlog`) consolidated into a single unified command:

```
/gsd-capture "raw idea, todo, seed, or backlog item"
                                          # Routes to the right destination automatically
/gsd-explore                              # Socratic ideation when an idea needs to be unpacked
/gsd-review-backlog                       # Promote backlog items to the active milestone
/gsd-progress                             # Check what's outstanding (replaces check-todos)
```

## Urgent mid-milestone work

```
/gsd-phase insert 5 "Critical fix"        # Creates phase 5.1 (consolidated CRUD)
/gsd-plan-phase 5.1
/gsd-execute-phase 5.1
```

## Code improvement (non-feature work)

```
/sc:cleanup                               # Dead-code removal, structure optimization
/sc:improve                               # Quality, performance, maintainability
/sc:analyze --focus performance           # Find performance bottlenecks
/sc:analyze --focus security              # Security audit
/simplify                                 # Review changed code for reuse and quality
```

## Documentation

```
/sc:document "component or feature"       # Focused component docs
/sc:index                                 # Full project knowledge base
/sc:explain "concept or code"             # Educational explanations
/gsd-docs-update                          # Generate/update project docs verified against code
```

## Parallel work

See [10 Parallel Work](10-parallel-work.md) for the full catalog: worktrees, workstreams, threads, subagent-driven-development, dispatching-parallel-agents. That chapter has the decision tree for which mechanism fits which shape of parallelism.

## Automation & configuration

```
/claude-code-setup:claude-automation-recommender  # Analyze codebase, recommend automations
/update-config                            # Configure hooks, permissions, env vars
/keybindings-help                         # Customize keyboard shortcuts
/fewer-permission-prompts                 # Scan transcripts, build an allowlist
```

## Recurring tasks

```
/loop 5m /gsd-progress                    # Poll progress every 5 minutes
/loop 10m "check deploy status"           # Monitor periodically
/schedule                                 # Cron-scheduled remote agents
```

## Planning health

```
/gsd-health                               # Diagnose .planning/ directory issues
/gsd-stats                                # Project statistics (phases, git metrics, timeline)
/gsd-inbox                                # Triage GitHub issues / PRs against templates
```

---

**Previous:** [Parallel Work](10-parallel-work.md) | **Next:** [Session Management](12-session-management.md)
