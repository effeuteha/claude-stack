# Anti-Patterns to Avoid

28 mistakes to avoid and what to do instead.

| # | Anti-Pattern | Why It's Bad | Do This Instead |
|---|---|---|---|
| 1 | Skipping `/sc:spec-panel` after planning | Plans get executed with gaps, causing rework | Always review plans before execution |
| 2 | Never re-mapping codebase | Knowledge drifts from reality as code changes | Re-map every 2-3 phases or after refactors |
| 3 | Using `/sc:implement` for everything | Loses GSD state tracking and traceability | Use GSD phases for planned work, SC for ad-hoc |
| 4 | Forgetting Context7 during research | Reinventing patterns that libraries already solve | Always check Context7 for library-specific questions |
| 5 | Not writing Serena memories | Re-discovering the same insights every session | Write memories for non-obvious patterns and gotchas |
| 6 | Using `/gsd-quick` for complex work | Skips research, plan-checking, and verification | Use full phase flow for anything non-trivial |
| 7 | Skipping `/gsd-discuss-phase` | Planner makes wrong assumptions about your vision | Always discuss before planning |
| 8 | Not using `--think-hard` for architecture | Shallow analysis misses cross-cutting concerns | Use depth flags for important decisions |
| 9 | Running `/gsd-execute-phase` without `/clear` | Context bloat from planning reduces execution quality | Clear context between planning and execution |
| 10 | Not using `/gsd-pause-work` before `/clear` | Losing work-in-progress state | Always snapshot before clearing |
| 11 | Skipping verification-before-completion | Claiming "done" without evidence | Run verification commands, check output, then claim |
| 12 | Using Grep when Serena `find_symbol` works | Missing semantic relationships between symbols | Use Serena for code navigation, Grep for text search |
| 13 | Not using `/sc:index-repo` | Reading 58K tokens of codebase every session | Index once, read 3K tokens per session |
| 14 | Using `/gsd-autonomous` without reviewing plans | Hands-free execution with unchecked plans = risk | Always `/sc:spec-panel` the plan before going autonomous |
| 15 | Mysti for everything, terminal for nothing | Losing GSD state persistence and deep lifecycle management | Use Mysti for brainstorm/debate, terminal for lifecycle |
| 16 | Terminal for everything, Mysti for nothing | Missing multi-model insights that catch blind spots | Use Mysti for architecture debates and security red-teams |
| 17 | Waiting for auto-compact at 80% | Quality degrades before auto-compact triggers | Manually `/compact` at 50% |
| 18 | Never using CLAUDE.local.md | Personal preferences polluting team CLAUDE.md | Keep personal prefs in CLAUDE.local.md (gitignored) |
| 19 | Micromanaging Claude's approach | Less effective than clear specs + autonomy | Write detailed specs, then let Claude work |
| 20 | One massive CLAUDE.md file | Hard to maintain, exceeds effective line limits | Split into `.claude/rules/*.md` modules |
| 21 | Not committing permissions to settings.json | Every team member re-approves the same tools | Share permission wildcards via `.claude/settings.json` |
| 22 | Arguing with Claude in degraded context | Wasted tokens in a polluted context | `Esc Esc` or `/rewind`, then re-prompt cleanly |
| 23 | Skipping brainstorm-first on a new feature | Implementation decisions smuggle in before requirements are clear; spec is what's in your head, not on paper | Invoke `/superpowers:brainstorming` (or `/gsd-spec-phase`) before any creative work |
| 24 | Claiming done without verification | "Tests should pass" / "it should work"; PRs opened with undiscovered failures | Run the verification command, read the output, cite it — use Superpowers `verification-before-completion` |
| 25 | Single-model review on a high-stakes plan | `/sc:spec-panel` alone on critical phases — shared Claude blindspots survive | Pair with `/gsd-review` for cross-AI peer review on high-stakes work |
| 26 | Wrong phase type chosen | Generic `/gsd-plan-phase` for AI/LLM or frontend work — missing eval gates or design-contract shape | For AI features: `/gsd-ai-integration-phase`; frontend: `/gsd-ui-phase`; exploration: `/gsd-sketch` / `/gsd-spike` |
| 27 | No worktrees for parallel work | Two features sharing one checkout; `HEAD` swaps corrupt in-progress state | Use `git worktree add` per parallel feature; Superpowers `using-git-worktrees` has safety patterns |
| 28 | Skipped spec-phase on non-trivial phase | Ambiguous requirements turn into implementation decisions mid-execute — rework when reality diverges from unstated assumption | Run `/gsd-spec-phase` to produce `SPEC.md` with ambiguity score before `/gsd-discuss-phase` |

---

**Having one of these problems?** See [Troubleshooting](troubleshooting.md) for step-by-step fixes.

**Previous:** [Prompting Patterns](14-prompting-patterns.md)
