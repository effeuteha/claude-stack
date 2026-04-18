# Workflow Phases (0-7)

The complete phase lifecycle from session bootstrap to milestone completion.

## Phase 0: Session Bootstrap

**Goal**: Restore full context in minimal tokens.

### New Session on Existing Project
```
1. /sc:load                         # Restore SC session context via Serena
2. /gsd:resume-work                 # Restore GSD state from STATE.md
3. Serena: list_memories            # Check for relevant project memories
4. Serena: read_memory (if relevant)# Load domain-specific knowledge
5. /gsd:progress                    # See where you are, route to next action
```

### Brand New Session (First Time)
```
1. /gsd:map-codebase                # If brownfield (existing code)
2. /sc:index-repo                   # Create PROJECT_INDEX.md for token efficiency
3. Proceed to Phase 1               # Strategic thinking
```

### Context Pressure Mid-Session
```
1. /gsd:pause-work                  # Snapshot state to .continue-here
2. /sc:save                         # Persist SC session via Serena
3. Serena: write_memory             # Save critical insights
4. /clear                           # Free context
5. /gsd:resume-work                 # Restore in fresh context
```

---

## Phase 1: Strategic Thinking

**Goal**: Understand WHAT to build and WHY before touching GSD.

### Step 1.1: Brainstorm the Idea
```
/sc:brainstorm
```
- Socratic dialogue exploring intent, constraints, success criteria
- Produces a design doc at `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Automatically invokes `writing-plans` skill when done
- **HARD GATE**: No implementation until design approved
- **VSCode alternative**: Use Mysti Brainstorm with Debate or Perspectives strategy

### Step 1.2: Business Analysis (if applicable)
```
/sc:business-panel .planning/PROJECT.md
```

### Step 1.3: Technical & Market Research
```
/sc:research "your research query here"
/sc:research --c7 "query needing library docs"    # With Context7
```

### Step 1.4: Effort Estimation
```
/sc:estimate "feature description"
```
Run BEFORE committing scope to a milestone.

### Step 1.5: Architecture Design (if needed)
```
/sc:design "system architecture for X"
/sc:design --think-hard "complex architecture"     # Deep analysis
```

---

## Phase 2: Project Initialization

**Goal**: Set up GSD's `.planning/` infrastructure.

### Brownfield (Existing Codebase)
```
1. /gsd:map-codebase                # Creates .planning/codebase/ (7 documents)
2. /gsd:new-project                 # Questioning -> research -> requirements -> roadmap
3. /sc:index-repo                   # Creates PROJECT_INDEX.md (3KB vs 58KB)
```

### Greenfield (New Project)
```
1. /gsd:new-project                 # Full flow
2. /sc:index-repo                   # After initial scaffolding
```

---

## Phase 3: Milestone Definition

**Goal**: Define the scope boundary for a set of phases.

```
1. /sc:business-panel .planning/PROJECT.md    # Strategic input (optional)
2. /sc:research "relevant market/tech query"  # Market context (optional)
3. /gsd:new-milestone "Milestone Name"        # Deep questioning -> requirements -> roadmap
4. /sc:workflow                               # Structured workflow from PRD (optional)
```

---

## Phase 4: Phase Planning Loop

**Goal**: For each phase, gather context, research, plan, and review before executing.

### Step 4.1: Discuss the Phase
```
/gsd:discuss-phase N
/gsd:discuss-phase N --auto                   # Skip interactive questions
```
Creates `CONTEXT.md` for the planner. Skip only if the phase is completely mechanical.

### Step 4.2: Surface Assumptions
```
/gsd:list-phase-assumptions N
```
Course-correct misunderstandings BEFORE planning. No files created — conversational only.

### Step 4.3: Research (if domain is specialized)
```
/gsd:research-phase N                         # Ecosystem-level research
Context7: resolve-library-id -> query-docs    # Library-specific
/sc:research --c7 "specific technical query"  # Combined web + docs
```

### Step 4.4: Plan the Phase
```
/gsd:plan-phase N
```
Creates `.planning/phases/XX-name/XX-01-PLAN.md` with task breakdown and verification criteria.

### Step 4.5: Review the Plan (CRITICAL — do not skip)
```
/sc:spec-panel .planning/phases/XX-name/XX-01-PLAN.md --mode critique
```
Multi-expert review catches gaps, over-engineering, missing edge cases.

### Step 4.6: Iterate if Needed
```
/gsd:plan-phase N    # Re-generates with updated context
```

---

## Phase 5: Execution Loop

**Goal**: Build the phase with quality and traceability.

### Step 5.1: Execute
```
/gsd:execute-phase N
```
Groups plans by wave, executes waves sequentially, plans within each wave run in parallel.

### Step 5.1a: Autonomous Alternative
```
/gsd:autonomous
```
Runs all remaining phases hands-free: discuss -> plan -> execute per phase.

### Step 5.2: During Execution — Tool Usage

| Tool | When | Example |
|------|------|---------|
| **Serena `find_symbol`** | Understand existing code | Finding a class's methods |
| **Serena `replace_symbol_body`** | Replace entire functions | Rewriting a handler |
| **Serena `find_referencing_symbols`** | Check dependencies | Before modifying a public API |
| **Serena `search_for_pattern`** | Find patterns across codebase | All files using a deprecated function |
| **Context7 `query-docs`** | Need API docs while coding | Middleware error handling patterns |
| **Sequential Thinking** | Complex multi-step logic | Designing a state machine |

### Step 5.3: Ad-Hoc Implementation
```
/sc:implement "feature description"
/feature-dev:feature-dev "feature description"
/gsd:quick
/gsd:do "natural language description"
```

---

## Phase 6: Quality & Verification

**Goal**: Verify the phase delivers what was promised.

### Step 6.1: Code Analysis
```
/sc:analyze                               # Quality + security + performance
/sc:analyze --focus security              # Security-specific
/sc:analyze --focus performance           # Performance-specific
```

### Step 6.2: Testing
```
/sc:test                                  # Run tests with coverage analysis
/gsd:add-tests N                          # Generate tests from phase UAT criteria
```

### Step 6.3: User Acceptance Testing
```
/gsd:verify-work N
```
Interactive yes/no verification with auto-diagnosis of failures.

### Step 6.4: Retroactive Validation
```
/gsd:validate-phase N
```
Fills validation gaps, generates tests, verifies coverage.

### Step 6.5: Code Review
```
/code-review:code-review                  # Full PR review
/sc:analyze --think-hard                  # Self-review
/sc:reflect                               # Am I done? On track?
```

### Step 6.6: UI Audit (frontend phases)
```
/gsd:ui-review                            # 6-pillar visual audit
```

### Step 6.7: Cross-Model Review (optional)
Use a second model to review the first model's work:
- Mysti: `@gemini` reviews while `@claude` explains
- Terminal: open a second Claude Code session for independent QA

### Step 6.8: Verification Gate
Before claiming completion, the `verification-before-completion` skill enforces:
```
1. IDENTIFY what command proves the claim
2. RUN the full command (fresh)
3. READ full output, check exit code
4. VERIFY output confirms the claim
5. ONLY THEN make the claim
```

---

## Phase 7: Milestone Completion

**Goal**: Close the milestone cleanly and prepare for next.

### Step 7.1: Audit
```
/gsd:audit-milestone
```

### Step 7.2: Close Gaps
```
/gsd:plan-milestone-gaps
/gsd:plan-phase N.1
/gsd:execute-phase N.1
```

### Step 7.3: Complete
```
/gsd:complete-milestone 1.0.0
/sc:git
/claude-md-management:revise-claude-md
/gsd:cleanup
```

### Step 7.4: Knowledge Persistence
```
Serena: write_memory
/sc:save
```

---

**Avoid common mistakes:** See [Anti-Patterns](12-anti-patterns.md) — especially #1 (skipping spec-panel), #9 (executing without /clear), and #14 (autonomous without review).

**Previous:** [Task Routing](04-task-routing.md) | **Next:** [Quality Scaling](06-quality-scaling.md)
