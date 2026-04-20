# 05 — Task Routing

Not every task needs the full phase lifecycle. Route tasks to the right workflow based on their shape.

## Route by task shape

```
+-- What kind of work is this?
|
+-- NEW FEATURE (greenfield)
|   |
|   +-- Trivial (< 30 min)?
|   |   YES --> /gsd:quick or /sc:implement
|   |   NO  --> /gsd:spec-phase (recommended) --> full lifecycle (Ch 06)
|   |
|   +-- AI/LLM feature (depends on model behavior)?
|   |   YES --> /gsd:ai-integration-phase (adds AI-SPEC.md with eval gates)
|   |
|   +-- Frontend feature (UI component / page)?
|   |   YES --> /gsd:ui-phase (adds UI-SPEC.md design contract)
|   |           then /frontend-design:frontend-design for generation
|   |           then /gsd:ui-review for 6-pillar audit
|   |
|   +-- Need multi-model input?
|       YES --> Mysti Brainstorm OR /gsd:review (cross-AI peer review)
|
+-- ENHANCEMENT (brownfield, extending existing code)
|   |
|   +-- Well-understood change?
|   |   YES --> /gsd:discuss-phase --> /gsd:plan-phase --> /gsd:execute-phase
|   |   NO  --> /gsd:map-codebase first, then plan
|   |
|   +-- Touches unfamiliar code?
|       YES --> Serena find_symbol + get_symbols_overview to understand first
|
+-- BUG FIX
|   |
|   +-- Simple & obvious?
|   |   YES --> /gsd:fast or just fix it
|   |   NO  --> /gsd:debug (persistent state, survives /clear)
|   |
|   +-- Complex / multi-system?
|       YES --> Sequential Thinking + Serena find_referencing_symbols
|
+-- REFACTOR
|   |
|   +-- Small scope (single file/module)?
|   |   YES --> /sc:improve or /sc:cleanup
|   |
|   +-- Large scope (cross-cutting)?
|       YES --> /gsd:map-codebase --> plan phases --> execute
|       Consider: git hotspot analysis to prioritize high-churn files
|
+-- TECH DEBT / CODE QUALITY
|   YES --> /sc:analyze --focus [security|performance|quality]
|           then /sc:improve for fixes
|           for autonomous cycle: /gsd:audit-fix (audit -> classify -> fix -> test -> commit)
|
+-- DOCUMENTATION
|   YES --> /sc:document (component) or /sc:index (full project)
|
+-- INVESTIGATION / RESEARCH
|   YES --> /sc:research (web) + Context7 (library docs)
|           or Mysti Brainstorm for multi-model perspectives
|
+-- EXPLORATORY / FEASIBILITY
|   |
|   +-- Validate a code approach before committing?
|   |   YES --> /gsd:spike (throwaway code, wrap up with /gsd:spike-wrap-up)
|   |
|   +-- Explore UI variants before ui-phase?
|       YES --> /gsd:sketch (throwaway HTML mockups, wrap up with /gsd:sketch-wrap-up)
|
+-- PARALLEL WORK (2+ features in flight)
|   YES --> git worktree + /gsd:workstreams (see Ch 10 Parallel Work)
|           For cross-session context: /gsd:thread
|
+-- LOCK REQUIREMENTS BEFORE IMPLEMENTATION
    YES --> /gsd:spec-phase N (produces SPEC.md with falsifiable reqs + ambiguity score)
```

## Plan review — single-model vs cross-AI

When reviewing a plan before execute:

```
Low-stakes phase                -> /sc:spec-panel (multi-expert in Claude)
High-stakes / AI / security     -> /sc:spec-panel AND /gsd:review (cross-AI peer review)
```

`/sc:spec-panel` shifts persona inside Claude. `/gsd:review` dispatches to external AI CLIs (Gemini, Codex, etc.) — different model provider, different training priors. The two are complementary, not redundant, on high-stakes work.

## Rigor Scaling

Scale your AI quality and review effort based on task criticality:

| Task Criticality | Planning | Execution | Review | Testing |
|-----------------|----------|-----------|--------|---------|
| **Spike / config / docs** | Skip or `/gsd:quick` | Direct implementation | None | None |
| **Standard feature** | `/gsd:spec` + `/gsd:discuss` + `/gsd:plan` | `/gsd:execute-phase` | `/sc:spec-panel` | `/sc:test` |
| **Critical feature** | Spec + discuss + plan + `/sc:spec-panel` | `/gsd:execute-phase` + careful review | `/code-review:code-review` | `/sc:test` + E2E |
| **Production core** | Spec + discuss + plan + `/sc:spec-panel` + `/gsd:review` (cross-AI) | `/gsd:execute-phase` with verification | Multi-reviewer + `/gsd:validate-phase` | Full suite + mutation testing |

### GSD Model Profiles

Match AI quality to task criticality:

```
/gsd:set-profile budget      # Sonnet writing, Haiku research (spikes, config)
/gsd:set-profile balanced    # Opus planning, Sonnet execution (standard work)
/gsd:set-profile quality     # Opus everywhere (critical features)
/gsd:set-profile inherit     # Use parent model (max consistency)
```

## Quick Decision: Which Command?

| I need to... | Use this |
|-------------|----------|
| Lock WHAT before HOW | `/gsd:spec-phase N` |
| Build something small and quick | `/gsd:quick` or `/sc:implement` |
| Build a single-line fix | `/gsd:fast` |
| Build a planned feature | `/gsd:execute-phase N` |
| Build an AI/LLM feature | `/gsd:ai-integration-phase N` |
| Build a frontend feature | `/gsd:ui-phase N` + `frontend-design` plugin |
| Build everything hands-free | `/gsd:autonomous` |
| Explore feasibility before committing | `/gsd:spike` |
| Explore UI variants | `/gsd:sketch` |
| Fix a simple bug | `/gsd:fast` or just fix it |
| Debug a complex bug | `/gsd:debug "description"` |
| Post-mortem a failed workflow | `/gsd:forensics` |
| Clean up code | `/sc:cleanup` or `/sc:improve` |
| Autonomous audit-to-fix | `/gsd:audit-fix` |
| Write docs | `/sc:document "component"` |
| Research a library | Context7 `query-docs` |
| Research a domain | `/sc:research "query"` |
| Review a plan (in-Claude) | `/sc:spec-panel .planning/…` |
| Review a plan (cross-AI) | `/gsd:review .planning/…` |
| Ship the phase | `/gsd:ship` |
| I don't know which command | `/gsd:do "description"` or `/sc:recommend` |

---

**Previous:** [Context Discipline](04-context-discipline.md) | **Next:** [Workflow Phases](06-workflow-phases.md)
