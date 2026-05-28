# Tool Responsibility Matrix

Primary vs secondary tool for every need.

| Need | Primary Tool | Secondary Tool | When to Use Secondary |
|------|-------------|---------------|----------------------|
| **Idea exploration** | `/sc:brainstorm` or `/superpowers:brainstorming` | `/gsd-spec-phase` | When idea is already scoped to a phase; spec-phase locks WHAT |
| **Lock WHAT before HOW** | `/gsd-spec-phase` | — | Front door for non-trivial phases; produces SPEC.md with ambiguity score |
| **Market / tech research** | `/sc:research` | Context7 `query-docs` | When researching a specific library/API |
| **Business strategy** | `/sc:business-panel` | — | Pricing, positioning, competitive analysis |
| **Architecture design** | `/sc:design` | `/feature-dev:feature-dev` | When building within existing patterns |
| **Effort estimation** | `/sc:estimate` | — | Before committing to scope |
| **Spec review (multi-expert in Claude)** | `/sc:spec-panel` | — | Review any plan/spec/PRD before execution |
| **Spec review (cross-AI peer review)** | `/gsd-review` | Mysti Red-Team | Cross-model second opinion; high-stakes plans |
| **Project init** | `/gsd-new-project` | `/sc:index-repo` | Index after init for token efficiency |
| **Milestone definition** | `/gsd-new-milestone` | `/sc:business-panel` | Feed business analysis into milestone scope |
| **Phase discussion** | `/gsd-discuss-phase` | `/sc:brainstorm` | When phase needs deeper ideation |
| **Phase research** | `/gsd-plan-phase` (auto-spawned researcher) | Context7 + `/sc:research` | Research now happens automatically inside plan-phase; reach for Context7/sc:research for library-specific |
| **Phase planning** | `/gsd-plan-phase` | `/sc:spec-panel` | Review plan before execution |
| **MVP slice of a large phase** | `/gsd-mvp-phase` | `/gsd-plan-phase` | SPIDR-split the phase into vertical MVP + follow-ups |
| **Phase execution** | `/gsd-execute-phase` | `/sc:implement` | For ad-hoc features outside GSD |
| **Autonomous execution** | `/gsd-autonomous` | — | Run all remaining phases hands-free |
| **Ship the phase** | `/gsd-ship` | Bash `gh pr create` | PR + review + merge prep |
| **AI / LLM phase** | `/gsd-ai-integration-phase` | `/gsd-eval-review` | Eval audit post-implementation |
| **UI / frontend phase** | `/gsd-ui-phase` | `frontend-design` + `/gsd-ui-review` | Design contract, generation, audit |
| **Exploratory UI** | `/gsd-sketch` | — | Multi-variant HTML mockups; findings packaged automatically at session end |
| **Feasibility check (code)** | `/gsd-spike` | — | Throwaway code to validate approach; findings captured automatically |
| **Freeform routing** | `/gsd-progress "intent"` | `/sc:recommend` | Unified situational command — auto-routes freeform intent |
| **Codebase mapping** | `/gsd-map-codebase` | `/sc:index-repo` | Index for big token savings; map for deep 7-document analysis |
| **Codebase intel cluster** | `/gsd-ns-context` | — | Landing page: map / graphify / docs / learnings |
| **Knowledge graph** | `/gsd-graphify` | `/graphify` plugin | Project graph vs general-purpose input-to-graph |
| **Code analysis** | `/sc:analyze` | Serena `find_symbol` | When analyzing specific symbols |
| **Autonomous audit → fix** | `/gsd-audit-fix` | `/sc:cleanup` + `/sc:improve` | Full cycle: audit, classify, fix, test, commit |
| **Testing** | `/sc:test` | Playwright MCP | E2E / browser testing (enable on demand) |
| **Test generation** | `/gsd-add-tests` | `/sc:test` | Generate tests from phase UAT criteria |
| **Code review (PR)** | `/code-review:code-review` | `/sc:analyze` | code-review for PRs, analyze for general quality |
| **Code review (phase)** | `/gsd-code-review` | `/gsd-code-review --fix` | Phase-scoped review; add `--fix` to auto-apply mechanical findings |
| **Plan convergence loop** | `/gsd-plan-review-convergence` | `/gsd-review` | Replan-with-review until no HIGH concerns remain |
| **Threat-mitigation audit** | `/gsd-secure-phase` | — | Retroactive verification of `PLAN.md` threat model |
| **Cross-phase UAT audit** | `/gsd-audit-uat` | `/gsd-verify-work` | Pending UAT items across all phases |
| **Debugging** | `/gsd-debug` | Sequential Thinking | Complex multi-step debugging chains |
| **Post-mortem** | `/gsd-forensics` | — | Diagnose a failed workflow from git + artifacts |
| **Quick tasks** | `/gsd-quick` | `/sc:task` | SC for tasks outside project lifecycle |
| **Single-line fix** | `/gsd-fast` | Direct edit | Trivial mechanical change |
| **Documentation** | `/sc:document` | `/sc:index` or `/gsd-docs-update` | Index for full project docs; gsd:docs-update for code-verified updates |
| **UI generation** | `/frontend-design:frontend-design` | Playwright | Verify UI with browser automation (enable on demand) |
| **UI audit** | `/gsd-ui-review` | `/gsd-ui-phase` | ui-phase for design contract, ui-review for post-impl audit |
| **Git operations** | `/sc:git` | Bash `gh` | PR creation, issue management |
| **Session pause** | `/gsd-pause-work` | `remember` plugin | Lightweight save without named thread |
| **Session resume** | `/gsd-resume-work` | `/sc:load` | SC-only restore; resume-work also restores GSD state |
| **Session thread** | `/gsd-thread` | `remember` plugin | Named parallel context threads |
| **Milestone summary** | `/gsd-milestone-summary` | `/gsd-stats` | Comprehensive summary for team onboarding/review |
| **Phase learnings** | `/gsd-extract-learnings` | — | Decisions, lessons, surprises from completed phases |
| **Cleanup** | `/sc:cleanup` | `/sc:improve` | Cleanup for dead code, improve for quality |
| **Reflection** | `/sc:reflect` | — | Mid-task course correction |
| **Library docs** | Context7 `query-docs` | `/sc:research --c7` | SC research with Context7 flag |
| **Symbol navigation** | Serena `find_symbol` | Grep/Glob | Serena for semantic, Grep for text patterns |
| **Project stats** | `/gsd-stats` | `/gsd-progress` | Stats for metrics, progress for next-action routing |
| **Planning health** | `/gsd-health` | — | Diagnose and repair `.planning/` issues |
| **Inbox triage** | `/gsd-inbox` | — | Review GitHub issues/PRs against project templates |
| **Idea capture** | `/gsd-capture` | `/gsd-explore` | Unified capture (notes, todos, seeds, backlog routed automatically); `explore` for Socratic unpacking |
| **Backlog management** | `/gsd-review-backlog` | `/gsd-capture` | Capture adds; review-backlog promotes to active milestone |
| **Phase validation** | `/gsd-validate-phase` | `/gsd-add-tests` | Retroactive validation for completed phases |
| **Orchestration** | `/sc:pm` | `/sc:spawn` | PM for default coordination, spawn for sub-agents |
| **Subagent execution** | `superpowers:subagent-driven-development` | `superpowers:executing-plans` | Same-session fresh-per-task vs parallel-session batch |
| **Parallel work** | `superpowers:dispatching-parallel-agents` | Git worktrees + `/gsd-workstreams` | In-turn lookups vs filesystem + planning isolation |
| **Command discovery** | `/sc:recommend` | `/gsd-progress "intent"` | When unsure which tool to use |
| **Multi-phase command center** | `/gsd-manager` | — | Interactive UI for managing several phases from one terminal |
| **Import external plans** | `/gsd-import` | — | Ingest external ADRs/PRDs/SPECs with conflict detection |
| **PR-clean branch** | `/gsd-pr-branch` | `/gsd-ship` | Filter `.planning/` commits out of a PR branch |
| **Automation setup** | `claude-code-setup:claude-automation-recommender` | `/update-config` | Recommend automations; configure hooks directly |
| **Permissions audit** | `/fewer-permission-prompts` | — | Build allowlist from transcript history |
| **CLAUDE.md maintenance** | `claude-md-management:claude-md-improver` | `claude-md-management:revise-claude-md` | Improver for audit; revise for session learnings |
| **Multi-agent brainstorm** | Mysti Brainstorm | `/sc:brainstorm` | Mysti for two AI models debating in a GUI |
| **Cross-AI plan review** | `/gsd-review` | Mysti Red-Team | CLI-native vs GUI |
| **ML / AI research** | Hugging Face MCP | `/sc:research --c7` | HF for models/datasets; sc:research for concepts |
| **Scheduled tasks** | `/schedule` | `/loop` | schedule = cron; loop = recurring prompt |
