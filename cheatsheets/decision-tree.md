# Decision Tree — Which Tool?

## By Task Type

```
NEW FEATURE
  |
  +-- Trivial? --> /gsd:quick or /sc:implement
  +-- Complex? --> Full phase workflow (discuss -> plan -> execute -> verify)
  +-- Need debate? --> Mysti Brainstorm, then GSD phases

ENHANCEMENT
  |
  +-- Well-understood? --> /gsd:discuss -> /gsd:plan -> /gsd:execute
  +-- Unfamiliar code? --> Serena find_symbol first, then plan

BUG FIX
  |
  +-- Simple? --> Just fix it
  +-- Complex? --> /gsd:debug (persistent, survives /clear)
  +-- Multi-system? --> Sequential Thinking + Serena

REFACTOR
  |
  +-- Small scope? --> /sc:improve or /sc:cleanup
  +-- Large scope? --> /gsd:map-codebase -> plan phases -> execute

TECH DEBT
  |
  +-- /sc:analyze --focus [security|performance|quality]
  +-- then /sc:improve for fixes

DOCUMENTATION
  |
  +-- Component? --> /sc:document "component"
  +-- Full project? --> /sc:index

RESEARCH
  |
  +-- Library-specific? --> Context7 query-docs
  +-- Domain/market? --> /sc:research
  +-- Need perspectives? --> Mysti Brainstorm (Perspectives)
```

## By Need

```
THINKING       --> SC (brainstorm, design, research, estimate, business-panel)
PLANNING       --> GSD (discuss-phase, plan-phase, list-phase-assumptions)
REVIEWING      --> SC (spec-panel, analyze) or code-review plugin
BUILDING       --> GSD (execute-phase) or SC (implement)
TESTING        --> SC (test) + GSD (add-tests, verify-work, validate-phase)
DEBUGGING      --> GSD (debug) or SC (troubleshoot)
NAVIGATING     --> Serena (find_symbol, find_referencing_symbols)
DOCUMENTING    --> Context7 (library docs) or SC (document, explain)
REASONING      --> Sequential Thinking
COLLABORATING  --> Mysti (multi-model brainstorm, @-mentions)
```

## By Rigor Level

```
SPIKE          --> /gsd:quick, budget profile, no review
STANDARD       --> Full phase loop, balanced profile, /sc:analyze
CRITICAL       --> Full loop + /sc:spec-panel + /code-review, quality profile
PRODUCTION     --> Full loop + spec-panel + Mysti debate + mutation testing
```
