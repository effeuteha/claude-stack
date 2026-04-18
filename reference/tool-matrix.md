# Tool Responsibility Matrix

Primary vs secondary tool for every need.

| Need | Primary Tool | Secondary Tool | When to Use Secondary |
|------|-------------|---------------|----------------------|
| **Idea exploration** | `/sc:brainstorm` | `/gsd:discuss-phase` | When idea is already scoped to a phase |
| **Market/tech research** | `/sc:research` | Context7 `query-docs` | When researching a specific library/API |
| **Business strategy** | `/sc:business-panel` | — | Pricing, positioning, competitive analysis |
| **Architecture design** | `/sc:design` | `/feature-dev:feature-dev` | When building within existing patterns |
| **Effort estimation** | `/sc:estimate` | — | Before committing to scope |
| **Spec review** | `/sc:spec-panel` | — | Review any plan/spec/PRD before execution |
| **Project init** | `/gsd:new-project` | `/sc:index-repo` | Index after init for token efficiency |
| **Milestone definition** | `/gsd:new-milestone` | `/sc:business-panel` | Feed business analysis into milestone scope |
| **Phase discussion** | `/gsd:discuss-phase` | `/sc:brainstorm` | When phase needs deeper ideation |
| **Phase research** | `/gsd:research-phase` | Context7 + `/sc:research` | Domain-specific + library-specific |
| **Phase planning** | `/gsd:plan-phase` | `/sc:spec-panel` | Review plan before execution |
| **Phase execution** | `/gsd:execute-phase` | `/sc:implement` | For ad-hoc features outside GSD |
| **Autonomous execution** | `/gsd:autonomous` | — | Run all remaining phases hands-free |
| **Freeform routing** | `/gsd:do` | `/sc:recommend` | SC recommends best command for intent |
| **Codebase mapping** | `/gsd:map-codebase` | `/sc:index-repo` | Index for token savings, map for deep understanding |
| **Code analysis** | `/sc:analyze` | Serena `find_symbol` | When analyzing specific symbols |
| **Testing** | `/sc:test` | Playwright MCP | E2E / browser testing (enable on demand) |
| **Test generation** | `/gsd:add-tests` | `/sc:test` | Generate tests from phase UAT criteria |
| **Code review** | `/code-review:code-review` | `/sc:analyze` | Code-review for PRs, analyze for general quality |
| **Debugging** | `/gsd:debug` | Sequential Thinking | Complex multi-step debugging chains |
| **Quick tasks** | `/gsd:quick` | `/sc:task` | SC for tasks outside project lifecycle |
| **Documentation** | `/sc:document` | `/sc:index` | Index for full project docs |
| **UI/Frontend** | `/frontend-design:frontend-design` | Playwright | Verify UI with browser automation (enable on demand) |
| **UI audit** | `/gsd:ui-review` | `/gsd:ui-phase` | ui-phase for design spec, ui-review for retroactive audit |
| **Git operations** | `/sc:git` | Bash `gh` | PR creation, issue management |
| **Session persist** | `/sc:save` + `/gsd:pause-work` | Serena `write_memory` | Long-term project knowledge |
| **Session restore** | `/sc:load` + `/gsd:resume-work` | Serena `read_memory` | Cross-session context |
| **Cleanup** | `/sc:cleanup` | `/sc:improve` | Cleanup for dead code, improve for quality |
| **Reflection** | `/sc:reflect` | — | Mid-task course correction |
| **Library docs** | Context7 `query-docs` | `/sc:research --c7` | SC research with Context7 flag |
| **Symbol navigation** | Serena `find_symbol` | Grep/Glob | Serena for semantic, Grep for text patterns |
| **Project stats** | `/gsd:stats` | `/gsd:progress` | Stats for metrics, progress for next-action routing |
| **Planning health** | `/gsd:health` | — | Diagnose and repair `.planning/` issues |
| **Idea capture** | `/gsd:note` | `/gsd:add-todo` | Notes for raw ideas, todos for actionable items |
| **Phase validation** | `/gsd:validate-phase` | `/gsd:add-tests` | Retroactive validation for completed phases |
| **Orchestration** | `/sc:pm` | `/sc:spawn` | PM for default coordination, spawn for sub-agents |
| **Command discovery** | `/sc:recommend` | `/gsd:do` | When unsure which tool to use |
| **Automation setup** | `claude-code-setup` | `update-config` | Recommend automations / configure hooks |
| **CLAUDE.md maintenance** | `claude-md-improver` | `revise-claude-md` | Improver for audit, revise for session learnings |
| **Multi-agent brainstorm** | Mysti Brainstorm | `/sc:brainstorm` | Mysti for two AI models debating |
| **ML/AI ops** | `huggingface-skills:*` | — | Enable on demand |
