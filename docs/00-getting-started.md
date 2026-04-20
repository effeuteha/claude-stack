# Getting Started — Stack Profiles

Not everyone needs 150+ commands, skills, and MCP tools on day one. Pick a profile that matches your tier and grow from there. The profiles below map roughly to the tiers in the [Tool Inventory](../reference/tool-inventory.md) (Core / Workflow / On-Demand).

---

## Minimal Profile — partial Core tier

**4 tools. Get productive in 10 minutes.**

Best for: Solo developers, small projects, getting started with AI-assisted development.

| Tool | Purpose | Install |
|------|---------|---------|
| **Claude Code** | Core AI agent | `npm install -g @anthropic-ai/claude-code` |
| **Superpowers** | Discipline (TDD, brainstorm, verify) | [github.com/obra/superpowers](https://github.com/obra/superpowers) |
| **GSD** | Project lifecycle | [github.com/gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) |
| **Context7 MCP** | Library docs | Add to `.mcp.json` (see below) |

### Setup

```bash
# 1. Install Claude Code
npm install -g @anthropic-ai/claude-code

# 2. Install GSD (follow repo instructions)
# https://github.com/gsd-build/get-shit-done

# 3. Create MCP config
cat > .mcp.json << 'EOF'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
EOF

# 4. Create basic CLAUDE.md (customize for your project)
# See examples/claude-md/CLAUDE.md for a template
```

### What You Can Do

```bash
/gsd:new-project                    # Initialize project
/gsd:discuss-phase N                # Plan a phase
/gsd:plan-phase N                   # Create detailed plan
/gsd:execute-phase N                # Build it
/gsd:verify-work N                  # Verify it works
/gsd:quick                          # Quick one-off tasks
/gsd:debug "issue"                  # Debug with persistent state
```

### When to Upgrade

Upgrade to Standard when you find yourself:
- Wanting deeper code analysis (`/sc:analyze`)
- Needing to navigate unfamiliar code (Serena)
- Wanting plan reviews before execution (`/sc:spec-panel`)
- Running out of context window too fast

---

## Standard Profile — Core tier

**6 tools. The sweet spot for most developers.**

Everything in Minimal, plus:

| Tool | Purpose | Install |
|------|---------|---------|
| **SuperClaude** | Strategic thinking | [github.com/NomenAK/SuperClaude](https://github.com/NomenAK/SuperClaude) |
| **Serena MCP** | Code intelligence | [github.com/oraios/serena](https://github.com/oraios/serena) |

### Additional Setup

```bash
# 1. Install SuperClaude (follow repo instructions)
# https://github.com/NomenAK/SuperClaude

# 2. Install Superpowers (follow repo instructions)
# https://github.com/obra/superpowers

# 3. Configure Serena MCP (follow repo instructions)
# https://github.com/oraios/serena

# 4. Update .mcp.json
cat > .mcp.json << 'EOF'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@anthropic/sequential-thinking-mcp"]
    }
  }
}
EOF

# 5. Copy recommended settings
# See examples/settings.json
```

### What You Gain

```bash
# Strategic thinking
/sc:brainstorm                      # Explore ideas before building
/sc:design                          # Architecture design
/sc:spec-panel <plan>               # Expert panel reviews your plan
/sc:analyze                         # Code quality + security scan

# Code intelligence
Serena: find_symbol                 # Navigate code semantically
Serena: find_referencing_symbols    # Trace dependencies
Serena: write_memory                # Persist insights across sessions

# Complex reasoning
Sequential Thinking                 # Multi-step logic for hard problems

# Index your codebase
/sc:index-repo                      # 94% token reduction (58K -> 3K)
```

### When to Upgrade

Upgrade to Full when you find yourself:
- Wanting multi-model brainstorming (Mysti)
- Building UIs that need browser testing (Playwright)
- Wanting automated formatting hooks
- Working on a team that needs shared workflows

---

## Full Profile — Core + Workflow tier

**15+ tools. Maximum capability.**

Everything in Standard, plus the Workflow tier:

| Tool | Purpose | Install |
|------|---------|---------|
| **Mysti** (VSCode) | Multi-agent GUI | `ext install DeepMyst.mysti` |
| **Playwright MCP** | Browser testing | Add to `.mcp.json` |
| **Sequential Thinking MCP** | Complex reasoning | Add to `.mcp.json` |
| **feature-dev** plugin | Guided feature development | `/plugin marketplace add` |
| **frontend-design** plugin | UI component generation | `/plugin marketplace add` |
| **code-review** plugin | Fresh-context PR review | `/plugin marketplace add` |
| **claude-md-management** plugin | CLAUDE.md audits | `/plugin marketplace add` |
| **claude-code-setup** plugin | Automation recommender | `/plugin marketplace add` |
| **remember** plugin | Session continuity | `/plugin marketplace add` |

### What You Gain

```bash
# Multi-model brainstorming (Mysti)
@claude + @gemini in Debate mode    # Architecture decisions
@claude + @codex in Red-Team mode   # Security reviews

# Browser testing (Playwright)
Playwright: browser_navigate        # E2E test automation
Playwright: browser_snapshot         # Visual verification

# Workflow discipline (Superpowers)
TDD enforcement                     # Test-driven development
Verification before completion       # Evidence-based claims
Systematic debugging                 # Scientific method for bugs

# SDLC methodology (nWave, optional)
/nw:discover -> /nw:discuss -> /nw:design -> /nw:deliver
```

### Context Management Note

With 10+ tools, MCP tool definitions can consume significant context. Tips:
- Disable Playwright and HuggingFace when not actively using them
- Set `ENABLE_TOOL_SEARCH=auto:10` in settings to auto-defer idle tools
- Set `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80` for auto-compaction
- Manually `/compact` at 50% usage

---

## VSCode-First Profile

**Mysti-centric workflow with terminal as fallback.**

Best for: Developers who prefer GUI over CLI, teams using VSCode as primary IDE.

| Tool | Purpose | Install |
|------|---------|---------|
| **Mysti** | Primary interface | `ext install DeepMyst.mysti` |
| **Claude Code** | Backend (spawned by Mysti) | `npm install -g @anthropic-ai/claude-code` |
| **GSD** | Lifecycle (via Claude Code) | [github.com/gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) |
| **Context7 MCP** | Library docs | Add to `.mcp.json` |
| **Serena MCP** | Code intelligence | Configure in MCP settings |

### How It Works

```
VSCode -> Mysti UI -> Claude Code (subprocess) -> MCP servers
                   -> Other providers (@gemini, @codex) for brainstorm
```

Your CLAUDE.md, GSD state, and MCP servers are inherited automatically when Mysti spawns Claude Code. You get the full stack through a GUI.

### When to Drop to Terminal

- Complex multi-phase execution (`/gsd:autonomous`)
- Headless/SSH environments
- Sessions that need to persist across multiple days
- Heavy GSD lifecycle management

---

## Progression Path

```
Week 1: Minimal
  Learn Claude Code + GSD + Superpowers basics
  Get comfortable with spec -> discuss -> plan -> execute -> verify -> ship

Week 2: + SuperClaude
  Add brainstorm, design, analyze
  Start reviewing plans with /sc:spec-panel

Week 3: + Serena + Context7
  Navigate code semantically
  Look up library docs without leaving Claude

Week 4: + Workflow plugins (feature-dev, frontend-design, code-review)
  Specialized commands for specific task shapes

Week 5: + Mysti + /gsd:review (cross-AI)
  Multi-model brainstorming and cross-AI plan review
  Architecture debates across providers
```

---

## Quick Setup Script

Run the setup wizard to configure your profile automatically:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/effeuteha/claude-stack/main/setup.sh)
```

Or clone and run locally:

```bash
git clone https://github.com/effeuteha/claude-stack.git
cd claude-stack
bash setup.sh
```

---

## See Also

- [01 Architecture Overview](01-architecture.md) — the 4-layer model
- [02 Discipline Layer](02-discipline-layer.md) — Superpowers methodology
- [09 Memory Systems](09-memory-systems.md) — the six memory mechanisms
- [10 Parallel Work](10-parallel-work.md) — worktrees, workstreams, threads, subagents
- [Troubleshooting](troubleshooting.md) — common problems and how to fix them
- [Anti-Patterns](15-anti-patterns.md) — 28 mistakes to avoid
- [Walkthrough: API Feature](walkthrough-api-feature.md) — see the full workflow in action
