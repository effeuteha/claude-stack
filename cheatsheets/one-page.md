# Claude Stack — One-Page Cheat Sheet

## Session Lifecycle

```
START:  /gsd:progress  or  /sc:load + /gsd:resume-work
SAVE:   /gsd:pause-work + /sc:save
CLEAR:  /gsd:pause-work -> /clear -> /gsd:resume-work
END:    /sc:save + /sc:git + /claude-md-management:revise-claude-md
```

## The Golden Path (per phase)

```
/gsd:discuss-phase N       # Share vision
/gsd:plan-phase N          # Create plan
/sc:spec-panel <plan>      # Review plan (DON'T SKIP)
/gsd:execute-phase N       # Build it
/sc:analyze                # Quality check
/gsd:verify-work N         # UAT
```

## Which Tool?

| I need to... | Use |
|-------------|-----|
| Think / brainstorm | `/sc:brainstorm` or Mysti Brainstorm |
| Plan a feature | `/gsd:discuss-phase` + `/gsd:plan-phase` |
| Review a plan | `/sc:spec-panel <file>` |
| Build it | `/gsd:execute-phase` |
| Build hands-free | `/gsd:autonomous` |
| Quick task | `/gsd:quick` or `/sc:implement` |
| Fix a bug | `/gsd:debug` |
| Analyze code | `/sc:analyze [--focus security\|performance]` |
| Run tests | `/sc:test` |
| Review a PR | `/code-review:code-review` |
| Look up library docs | Context7 `query-docs` |
| Understand code | Serena `find_symbol` |
| Don't know | `/gsd:do "description"` |

## Context Management

```
/context     # Check usage
/compact     # Compact at ~50% (don't wait for 80%)
/clear       # Reset (save first!)
/rewind      # Undo last turn
Esc Esc      # Cancel current
/cost        # Token spend
```

## Quality Scaling

```
Spike:    /gsd:quick                              (budget profile)
Standard: discuss -> plan -> execute -> verify    (balanced profile)
Critical: + spec-panel + code-review              (quality profile)
Core:     + Mysti debate + mutation testing        (quality profile)
```

## SC Flags

```
--think-hard   Deep analysis     --c7        Context7 docs
--ultrathink   Maximum depth     --serena    Serena code ops
--delegate     Parallel agents   --focus X   security|performance|quality
```
