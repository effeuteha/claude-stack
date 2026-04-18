# Task Routing

Not every task needs the full phase lifecycle. Route tasks to the right workflow based on their nature.

## Route by Task Type

```
+-- What kind of work is this?
|
+-- NEW FEATURE (greenfield)
|   |
|   +-- Trivial (< 30 min)?
|   |   YES --> /gsd:quick or /sc:implement
|   |   NO  --> Full workflow (Phases 1-7)
|   |
|   +-- Need multi-model input?
|       YES --> Mysti Brainstorm first, then GSD phases
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
|   |   YES --> /gsd:quick or just fix it
|   |   NO  --> /gsd:debug (persistent, survives /clear)
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
|
+-- DOCUMENTATION
|   YES --> /sc:document (component) or /sc:index (full project)
|
+-- INVESTIGATION / RESEARCH
    YES --> /sc:research (web) + Context7 (library docs)
            or Mysti Brainstorm for multi-model perspectives
```

## Rigor Scaling

Scale your AI quality and review effort based on task criticality:

| Task Criticality | Planning | Execution | Review | Testing |
|-----------------|----------|-----------|--------|---------|
| **Spike / config / docs** | Skip or `/gsd:quick` | Direct implementation | None | None |
| **Standard feature** | `/gsd:discuss` + `/gsd:plan` | `/gsd:execute-phase` | `/sc:analyze` | `/sc:test` |
| **Critical feature** | Full discussion + `/sc:spec-panel` review | `/gsd:execute-phase` + careful review | `/code-review:code-review` | `/sc:test` + E2E |
| **Production core** | Full discussion + spec-panel + Mysti debate | `/gsd:execute-phase` with verification | Multi-reviewer + `/gsd:validate-phase` | Full suite + mutation testing |

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
| Build something small and quick | `/gsd:quick` or `/sc:implement` |
| Build a planned feature | `/gsd:execute-phase N` |
| Build everything hands-free | `/gsd:autonomous` |
| Fix a simple bug | Just fix it |
| Debug a complex bug | `/gsd:debug "description"` |
| Clean up code | `/sc:cleanup` or `/sc:improve` |
| Write docs | `/sc:document "component"` |
| Research a library | Context7 `query-docs` |
| Research a domain | `/sc:research "query"` |
| I don't know which command | `/gsd:do "description"` or `/sc:recommend` |

---

**Previous:** [Context Discipline](03-context-discipline.md) | **Next:** [Workflow Phases](05-workflow-phases.md)
