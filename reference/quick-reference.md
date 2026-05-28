# Quick Reference

## The Golden Path

```bash
/gsd-progress                             # Where am I?
/gsd-spec-phase N                         # Lock WHAT (recommended, not mandatory)
/gsd-discuss-phase N                      # Gray-area decisions
/gsd-plan-phase N                         # Create plan
/sc:spec-panel .planning/phases/...       # Multi-expert plan review (in Claude)
/gsd-review .planning/phases/...          # Cross-AI peer review (for high-stakes)
/gsd-execute-phase N                      # Build it
/sc:analyze                               # Quality scan
/gsd-verify-work N                        # UAT
/gsd-ship                                 # PR + review + merge prep
/gsd-map-codebase                         # Refresh knowledge (every 2-3 phases)
```

## The Autonomous Path

```bash
/gsd-spec-phase N                         # Still worth locking WHAT
/gsd-discuss-phase N --auto               # Claude picks recommended defaults
/gsd-plan-phase N
/sc:spec-panel .planning/phases/...       # Still review the plan!
/gsd-autonomous                           # Execute remaining phases
```

## The "I Don't Know Which Command" Path

```bash
/gsd-progress "natural language description"   # GSD auto-routes freeform intent
/sc:recommend "what I want to do"               # SC recommends
```

## Specialized Phase Types

```bash
/gsd-ai-integration-phase N               # AI/LLM features: AI-SPEC.md + eval gates
/gsd-ui-phase N                           # Frontend: UI-SPEC.md design contract
/gsd-sketch                               # Throwaway UI variants (multi-HTML)
/gsd-spike                                # Throwaway code experiments
/gsd-phase insert N "urgent"              # Decimal phase N.1 for mid-milestone inserts
/gsd-mvp-phase N                          # Plan as MVP vertical slice (SPIDR splitting)
```

## SC Flags

```
--c7 / --context7     -> Enable Context7 docs lookup
--serena              -> Enable Serena semantic code ops
--seq / --sequential  -> Enable Sequential Thinking
--play / --playwright -> Enable Playwright browser testing
--all-mcp             -> Enable everything
--think               -> Standard analysis (~4K tokens)
--think-hard          -> Deep analysis (~10K tokens)
--ultrathink          -> Maximum depth (~32K tokens)
--delegate auto       -> Parallel sub-agents
--safe-mode           -> Maximum validation
--loop                -> Iterative improvement cycles
--focus [domain]      -> Target: performance|security|quality|architecture
```

## GSD Model Profiles

Model profiles (budget / balanced / quality / inherit) are configured interactively:

```
/gsd-config           # Workflow toggles, integrations, model profile
/gsd-settings         # Workflow toggles + model profile (narrower)
/gsd-surface          # Skill cluster profile (which skills are surfaced)
```

Profile semantics:
- **budget** — Sonnet writing, Haiku research (spikes, config)
- **balanced** — Opus planning, Sonnet execution (standard work, default)
- **quality** — Opus everywhere (critical features)
- **inherit** — Use parent model (max consistency)

## Decision Tree

```
Don't know which tool?                  -> /gsd-progress "intent" or /sc:recommend
Need to think about WHAT to build?      -> SC (brainstorm, business-panel, research)
  or, lock the WHAT:                    -> /gsd-spec-phase
Need two AI models to debate it?        -> Mysti Brainstorm (Debate/Red-Team)
                                           or /gsd-review (cross-AI peer review, CLI)
Need to PLAN how to build it?           -> GSD (discuss, plan-phase)
Need to REVIEW a plan or spec?          -> /sc:spec-panel (in-Claude)
High-stakes plan review?                -> /sc:spec-panel AND /gsd-review
Need to BUILD it?                       -> GSD (execute-phase) or SC (implement)
Need to BUILD an AI/LLM feature?        -> /gsd-ai-integration-phase
Need to BUILD a frontend feature?       -> /gsd-ui-phase + frontend-design plugin
Need to EXPLORE before building?        -> /gsd-spike (code) or /gsd-sketch (UI)
Need to BUILD it all hands-free?        -> GSD (autonomous)
Need to CHECK code quality?             -> SC (analyze, test)
Autonomous audit -> fix cycle?          -> /gsd-audit-fix
Need to VERIFY it works?                -> GSD (verify-work) + Playwright
Need to AUDIT frontend code?            -> GSD (ui-review)
Need to SHIP the phase?                 -> /gsd-ship
Need to UNDERSTAND existing code?       -> Serena (find_symbol, get_symbols_overview)
Need to LOOK UP library docs?           -> Context7 (resolve-library-id, query-docs)
Need to REASON through complexity?      -> Sequential Thinking
Need to FIX a bug?                      -> GSD (debug) or SC (troubleshoot)
Need to POST-MORTEM a failed workflow?  -> /gsd-forensics
Need a QUICK one-off task?              -> GSD (quick) or SC (task)
Single-line fix?                        -> /gsd-fast
Need to REVIEW a PR?                    -> /code-review:code-review
Need phase-scoped code review?          -> /gsd-code-review (add --fix to auto-apply)
Need to BUILD UI?                       -> frontend-design:frontend-design + /gsd-ui-phase
Need to CAPTURE an idea?                -> /gsd-capture (notes, todos, seeds, backlog — unified)
Need to PAUSE and resume later?         -> /gsd-pause-work ... /gsd-resume-work
Need named cross-session threads?       -> /gsd-thread
Need lightweight session continuity?    -> /remember
Need PROJECT STATS?                     -> GSD (stats) or GSD (progress)
Need to SET UP automations?             -> claude-code-setup:claude-automation-recommender
Need PARALLEL work in flight?           -> git worktrees + /gsd-workstreams
```

## Context Management Quick Ref

```
/context          # Check usage
/cost             # Check token spend
/compact          # Compact at ~50% (don't wait for 80%)
/clear            # Reset (save state first!)
/rename "name"    # Name session for later
/resume           # Resume named session
/rewind           # Undo last turn
Esc Esc           # Cancel/undo current action
```

## Golden Path Consistency

This path appears identically in:
- `README.md`
- `docs/06-workflow-phases.md`
- `reference/quick-reference.md` *(this file)*
- `cheatsheets/golden-path.md`

Modify one, modify all four.
