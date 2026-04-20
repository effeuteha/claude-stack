# Cross-Cutting Workflows

Workflows that apply regardless of which phase you're in.

## Debugging

```
/gsd:debug "issue description"            # Persistent debug session
                                           # Survives /clear -- run /gsd:debug to resume
```

For complex bugs, combine with:
```
Sequential Thinking: sequentialthinking    # Multi-step hypothesis testing
Serena: find_referencing_symbols           # Trace call chains
/sc:troubleshoot                           # Diagnose builds, deployments, systems
```

## Idea Capture

```
/gsd:note "raw idea or thought"           # Zero-friction capture (append/list/promote)
/gsd:add-todo "actionable task"           # Directly to todo list
/gsd:check-todos                          # Review when ready
```

## Urgent Mid-Milestone Work

```
/gsd:insert-phase 5 "Critical fix"       # Creates phase 5.1
/gsd:plan-phase 5.1
/gsd:execute-phase 5.1
```

## Frontend / UI Development

```
/frontend-design:frontend-design          # High-quality UI generation
/gsd:ui-phase N                           # Generate UI-SPEC.md design contract
/gsd:ui-review                            # Retroactive 6-pillar visual audit
```

With Playwright (enable on demand):
```
Playwright: browser_navigate              # Navigate to dev server
Playwright: browser_snapshot              # Capture accessibility tree
Playwright: browser_take_screenshot       # Visual verification
```

## Code Improvement (Non-Feature Work)

```
/sc:cleanup                               # Dead code removal, structure optimization
/sc:improve                               # Quality, performance, maintainability
/sc:analyze --focus performance           # Find performance bottlenecks
/sc:analyze --focus security              # Security audit
/simplify                                 # Review changed code for reuse and quality
```

## Documentation

```
/sc:document "component or feature"       # Focused component docs
/sc:index                                 # Full project knowledge base
/sc:explain "concept or code"             # Educational explanations
```

## ML / HuggingFace Operations (Enable on Demand)

```
/huggingface-skills:hugging-face-cli            # Model/dataset download, upload
/huggingface-skills:hugging-face-model-trainer   # Fine-tuning
/huggingface-skills:hugging-face-datasets        # Dataset management
/huggingface-skills:hugging-face-evaluation      # Model evaluation
```

## Multi-Agent Parallelization

When facing 2+ independent tasks:
```
superpowers:dispatching-parallel-agents    # Auto-triggered for parallel work
superpowers:subagent-driven-development    # For executing plans with parallel tasks
```

## Automation & Configuration

```
/claude-code-setup:claude-automation-recommender  # Analyze codebase, recommend automations
/update-config                            # Configure hooks, permissions, env vars
/keybindings-help                         # Customize keyboard shortcuts
```

## Recurring Tasks

```
/loop 5m /gsd:progress                    # Poll progress every 5 minutes
/loop 10m "check deploy status"           # Monitor periodically
```

## Planning Health

```
/gsd:health                               # Diagnose .planning/ directory issues
/gsd:stats                                # Project statistics (phases, git metrics, timeline)
```

---

**Previous:** [Parallel Work](10-parallel-work.md) | **Next:** [Session Management](12-session-management.md)
