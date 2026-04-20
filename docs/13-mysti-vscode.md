# VSCode Workflow with Mysti

> **Install**: `ext install DeepMyst.mysti` or search "Mysti" in VSCode Extensions
> **Activate**: `Ctrl+Shift+M` or click the Mysti icon in the sidebar
> **Repo**: https://github.com/DeepMyst/Mysti

## What Mysti Does

Mysti is a **multi-agent orchestrator** for VSCode that wraps 12 AI coding CLIs (Claude Code is the default/primary) and lets them collaborate within VSCode's GUI. It does NOT replace your CLI workflow — it provides a visual alternative with unique multi-agent capabilities.

When Mysti spawns Claude Code, it inherits your full setup — CLAUDE.md, MCP servers, GSD state, SC skills. You lose nothing by switching to the GUI.

## Brainstorm Mode — 5 Strategies

| Strategy | Roles | Best For |
|----------|-------|----------|
| **Quick** | Independent parallel analysis | Simple tasks, fast answers |
| **Debate** | Critic vs. Defender | Architecture decisions |
| **Red-Team** | Proposer vs. Challenger | Security reviews, robustness |
| **Perspectives** | Risk Analyst vs. Innovator | New designs, long-term planning |
| **Delphi** | Facilitator vs. Refiner (iterative) | Complex problems needing convergence |

Example: Pair `@claude` (Defender) + `@gemini` (Critic) in Debate mode for architecture review.

## @-Mention Agent Routing

```
@claude fix the authentication bug         # Routes to Claude Code
@gemini review the API design              # Routes to Gemini
@codex optimize this function              # Routes to Codex
@filename                                  # References file for context injection
```

Agent chaining: later agents receive earlier agents' responses.

## 16 Developer Personas

| Persona | Focus |
|---------|-------|
| **Architect** | System design, patterns, scalability |
| **Debugger** | Root cause analysis, systematic debugging |
| **Security-Minded** | Vulnerabilities, threat modeling, secure coding |
| **Performance Tuner** | Bottlenecks, profiling, optimization |
| **Prototyper** | Rapid iteration, MVPs, proof of concepts |
| **Refactorer** | Code quality, design patterns, clean code |
| **Full-Stack** | End-to-end features across frontend and backend |
| **DevOps** | CI/CD, infrastructure, deployment, monitoring |
| **Mentor** | Teaching, code explanations, best practices |
| **Designer** | UI/UX, accessibility, visual design |
| **Data Engineer** | Pipelines, schemas, data modeling |
| **ML Engineer** | Models, training, evaluation, deployment |
| **Mobile Dev** | iOS/Android, responsive design, mobile patterns |
| **API Designer** | REST/GraphQL, contracts, versioning |
| **Test Engineer** | Test strategies, coverage, automation |
| **Tech Writer** | Documentation, READMEs, API docs |

Select a persona to focus Claude's approach. E.g., "Security-Minded" will prioritize vulnerability scanning and input validation over feature speed.

## 12 Toggleable Skills

| Skill | Effect When Enabled |
|-------|-------------------|
| **Concise** | Shorter responses, less explanation |
| **Test-Driven** | Write tests before implementation |
| **Auto-Commit** | Commit after each successful change |
| **First Principles** | Reason from fundamentals, question assumptions |
| **Scope Discipline** | Stay focused, resist scope creep |
| **Documentation** | Generate docs alongside code |
| **Accessibility** | Prioritize a11y in UI code |
| **Performance** | Optimize for speed and efficiency |
| **Security** | Security-first coding practices |
| **Error Handling** | Robust error handling and edge cases |
| **Code Review** | Self-review before presenting changes |
| **Incremental** | Small, reviewable changes instead of large rewrites |

Toggle skills on/off to shape Claude's behavior within Mysti. Multiple skills can be active simultaneously.

## Autonomous Mode — 3 Safety Levels

| Level | Auto-Approves | Blocks |
|-------|--------------|--------|
| **Conservative** | Read-only ops | Everything else |
| **Balanced** (default) | Common dev ops | Destructive actions |
| **Aggressive** | Almost everything | File deletion, force push, sudo |

## Context Compaction

Automatic at 75% token threshold. Uses Claude's native `/compact` or client-side summarization for other providers.

## Supported Providers (12)

Claude Code, Copilot CLI, Gemini, Codex, Cline, Cursor, OpenClaw, OpenCode, Qwen Code, Ollama, LocalAI, Manus.

## When to Use Mysti vs. Terminal

| Scenario | Use Mysti | Use Terminal |
|----------|-----------|-------------|
| Multi-model brainstorm / debate | Yes | No |
| Want GUI with file/code context | Yes | — |
| Deep GSD lifecycle management | — | Yes |
| Headless / SSH / CI | — | Yes |
| Quick ad-hoc with @-mentions | Yes | — |
| Complex multi-phase execution | — | Yes (GSD shines here) |
| Security red-teaming with two models | Yes | No |
| Session that must persist across /clear | — | Yes (GSD state) |

## Recommended Integration Patterns

### Brainstorming (Phase 1, Step 4.1)
```
1. Open Mysti (Ctrl+Shift+M)
2. Select Brainstorm -> Debate strategy
3. @claude + @gemini (or @codex)
4. Paste your phase context
5. Let agents debate, then feed consensus into /gsd:discuss-phase
```

### Security Reviews (Phase 6)
```
1. Mysti Brainstorm -> Red-Team
2. @claude (Proposer) + @gemini (Challenger)
3. Focus on API endpoints or auth flow
4. Feed findings into /sc:analyze --focus security
```

---

**Previous:** [Session Management](12-session-management.md) | **Next:** [Prompting Patterns](14-prompting-patterns.md)

### Architecture Decisions (Phase 3)
```
1. Mysti Brainstorm -> Perspectives
2. @claude (Risk Analyst) + @codex (Innovator)
3. Evaluate tradeoffs
4. Feed into /gsd:new-milestone scope
```

### Code Review (Phase 6)
```
1. Mysti Brainstorm -> Quick
2. @claude + @gemini
3. Both review the same diff independently
4. Merge insights into PR feedback
```
