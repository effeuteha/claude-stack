# Anti-Patterns to Avoid

22 mistakes to avoid and what to do instead.

| # | Anti-Pattern | Why It's Bad | Do This Instead |
|---|---|---|---|
| 1 | Skipping `/sc:spec-panel` after planning | Plans get executed with gaps, causing rework | Always review plans before execution |
| 2 | Never re-mapping codebase | Knowledge drifts from reality as code changes | Re-map every 2-3 phases or after refactors |
| 3 | Using `/sc:implement` for everything | Loses GSD state tracking and traceability | Use GSD phases for planned work, SC for ad-hoc |
| 4 | Forgetting Context7 during research | Reinventing patterns that libraries already solve | Always check Context7 for library-specific questions |
| 5 | Not writing Serena memories | Re-discovering the same insights every session | Write memories for non-obvious patterns and gotchas |
| 6 | Using `/gsd:quick` for complex work | Skips research, plan-checking, and verification | Use full phase flow for anything non-trivial |
| 7 | Skipping `/gsd:discuss-phase` | Planner makes wrong assumptions about your vision | Always discuss before planning |
| 8 | Not using `--think-hard` for architecture | Shallow analysis misses cross-cutting concerns | Use depth flags for important decisions |
| 9 | Running `/gsd:execute-phase` without `/clear` | Context bloat from planning reduces execution quality | Clear context between planning and execution |
| 10 | Not using `/gsd:pause-work` before `/clear` | Losing work-in-progress state | Always snapshot before clearing |
| 11 | Skipping verification-before-completion | Claiming "done" without evidence | Run verification commands, check output, then claim |
| 12 | Using Grep when Serena `find_symbol` works | Missing semantic relationships between symbols | Use Serena for code navigation, Grep for text search |
| 13 | Not using `/sc:index-repo` | Reading 58K tokens of codebase every session | Index once, read 3K tokens per session |
| 14 | Using `/gsd:autonomous` without reviewing plans | Hands-free execution with unchecked plans = risk | Always `/sc:spec-panel` the plan before going autonomous |
| 15 | Mysti for everything, terminal for nothing | Losing GSD state persistence and deep lifecycle management | Use Mysti for brainstorm/debate, terminal for lifecycle |
| 16 | Terminal for everything, Mysti for nothing | Missing multi-model insights that catch blind spots | Use Mysti for architecture debates and security red-teams |
| 17 | Waiting for auto-compact at 80% | Quality degrades before auto-compact triggers | Manually `/compact` at 50% |
| 18 | Never using CLAUDE.local.md | Personal preferences polluting team CLAUDE.md | Keep personal prefs in CLAUDE.local.md (gitignored) |
| 19 | Micromanaging Claude's approach | Less effective than clear specs + autonomy | Write detailed specs, then let Claude work |
| 20 | One massive CLAUDE.md file | Hard to maintain, exceeds effective line limits | Split into `.claude/rules/*.md` modules |
| 21 | Not committing permissions to settings.json | Every team member re-approves the same tools | Share permission wildcards via `.claude/settings.json` |
| 22 | Arguing with Claude in degraded context | Wasted tokens in a polluted context | `Esc Esc` or `/rewind`, then re-prompt cleanly |
