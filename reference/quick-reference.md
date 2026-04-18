# Quick Reference

## The Golden Path

```bash
/gsd:progress                             # Where am I?
/gsd:discuss-phase N                      # Share vision
/gsd:plan-phase N                         # Create plan
/sc:spec-panel .planning/phases/...       # Review plan
/gsd:execute-phase N                      # Build it
/sc:analyze                               # Code quality scan
/gsd:verify-work N                        # UAT
/gsd:map-codebase                         # Refresh knowledge (every 2-3 phases)
```

## The Autonomous Path

```bash
/gsd:discuss-phase N --auto               # Auto-answer context questions
/gsd:plan-phase N                         # Create plan
/sc:spec-panel .planning/phases/...       # Review plan (still do this!)
/gsd:autonomous                           # Execute all remaining phases
```

## The "I Don't Know Which Command" Path

```bash
/gsd:do "natural language description"    # GSD auto-routes
/sc:recommend "what I want to do"         # SC recommends
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

```
/gsd:set-profile budget      # Sonnet + Haiku (spikes, config)
/gsd:set-profile balanced    # Opus + Sonnet (standard work)
/gsd:set-profile quality     # Opus everywhere (critical)
/gsd:set-profile inherit     # Use parent model
```

## Decision Tree

```
Don't know which tool?                 -> /gsd:do or /sc:recommend
Need to think about WHAT to build?     -> SC (brainstorm, business-panel, research)
Need two AI models to debate it?       -> Mysti Brainstorm (Debate/Red-Team)
Need to PLAN how to build it?          -> GSD (discuss, plan-phase)
Need to REVIEW a plan or spec?         -> SC (spec-panel)
Need to BUILD it?                      -> GSD (execute-phase) or SC (implement)
Need to BUILD it all hands-free?       -> GSD (autonomous)
Need to CHECK code quality?            -> SC (analyze, test)
Need to VERIFY it works?              -> GSD (verify-work) + Playwright
Need to AUDIT frontend code?          -> GSD (ui-review)
Need to UNDERSTAND existing code?      -> Serena (find_symbol, get_symbols_overview)
Need to LOOK UP library docs?          -> Context7 (resolve-library-id, query-docs)
Need to REASON through complexity?     -> Sequential Thinking
Need to FIX a bug?                     -> GSD (debug) or SC (troubleshoot)
Need a QUICK one-off task?             -> GSD (quick) or SC (task)
Need to REVIEW a PR?                   -> code-review:code-review
Need to BUILD UI?                      -> frontend-design:frontend-design
Need to CAPTURE an idea?               -> GSD (note) or GSD (add-todo)
Need PROJECT STATS?                    -> GSD (stats) or GSD (progress)
Need to SET UP automations?            -> claude-code-setup
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
