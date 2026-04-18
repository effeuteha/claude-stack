# SuperClaude Flags Quick Reference

## MCP Integration

| Flag | Enables | Example |
|------|---------|---------|
| `--c7` / `--context7` | Context7 docs lookup | `/sc:research --c7 "React Query patterns"` |
| `--serena` | Serena semantic code ops | `/sc:implement --serena "add auth middleware"` |
| `--seq` / `--sequential` | Sequential Thinking | `/sc:design --seq "state machine for orders"` |
| `--play` / `--playwright` | Playwright browser testing | `/sc:test --play "verify login flow"` |
| `--all-mcp` | Enable all MCP servers | `/sc:analyze --all-mcp` |

## Depth Control

| Flag | Token Budget | Best For |
|------|-------------|----------|
| `--think` | ~4K tokens | Standard analysis |
| `--think-hard` | ~10K tokens | Architecture decisions, complex bugs |
| `--ultrathink` | ~32K tokens | Critical system design, deep analysis |

## Execution Mode

| Flag | Effect | Example |
|------|--------|---------|
| `--delegate auto` | Parallel sub-agents | `/sc:implement --delegate auto "large feature"` |
| `--safe-mode` | Maximum validation | `/sc:implement --safe-mode "payment processing"` |
| `--loop` | Iterative improvement | `/sc:improve --loop "optimize hot path"` |
| `--validate` | Extra verification | `/sc:implement --validate "auth flow"` |

## Focus Areas

| Flag | Targets |
|------|---------|
| `--focus security` | Vulnerabilities, auth, input validation |
| `--focus performance` | Bottlenecks, memory, latency |
| `--focus quality` | Code smells, complexity, maintainability |
| `--focus architecture` | Coupling, cohesion, patterns |

## Combining Flags

```bash
# Deep architecture review with all MCP servers
/sc:analyze --think-hard --all-mcp --focus architecture

# Safe implementation with Context7 docs
/sc:implement --safe-mode --c7 --validate "payment integration"

# Maximum depth design with Serena
/sc:design --ultrathink --serena "microservice decomposition"
```
