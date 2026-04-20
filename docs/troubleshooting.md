# Troubleshooting

Common problems and how to fix them.

---

## Claude Ignores My CLAUDE.md Rules

**Symptom:** You wrote "ALWAYS do X" in CLAUDE.md but Claude doesn't follow it.

**Causes & Fixes:**

1. **File not loaded** — Check loading mechanics:
   - Root CLAUDE.md loads immediately
   - Subdirectory CLAUDE.md loads lazily (only when files in that dir are touched)
   - Sibling directories never load each other's CLAUDE.md
   - Run `/context` to see what's loaded

2. **File too long** — CLAUDE.md over 200 lines loses effectiveness. Split into `.claude/rules/*.md` modules.

3. **Rule too vague** — "Write good code" is unenforceable. Show CORRECT/WRONG patterns with code examples.

4. **Context pressure** — When context is 70%+ full, earlier instructions get deprioritized. Run `/compact`.

5. **Conflicting instructions** — Check for contradictions between root CLAUDE.md, component CLAUDE.md, and `.claude/rules/` files.

**Pro tip:** After correcting Claude, say: *"Update your CLAUDE.md so you don't make that mistake again."* Claude writes effective rules for itself.

---

## Context Runs Out Too Fast

**Symptom:** Claude gets confused, forgets instructions, or produces lower quality output mid-session.

**Fixes:**

1. **Compact early** — Run `/compact` at 50%, don't wait for auto-compact at 80%
2. **Clear between tasks** — `/gsd:pause-work` → `/clear` → `/gsd:resume-work`
3. **Disable idle MCP servers** — Each server's tool definitions consume context even when not used
4. **Use `/sc:index-repo`** — 3K tokens vs 58K to understand your codebase
5. **Use subagents** — Say "use subagents" to offload research to isolated contexts
6. **Use Serena instead of reading files** — `find_symbol` is cheaper than reading entire files
7. **Set auto-compact:**
   ```json
   { "env": { "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "80" } }
   ```
8. **Set tool search deferral:**
   ```json
   { "env": { "ENABLE_TOOL_SEARCH": "auto:10" } }
   ```

---

## GSD Agents Fail or Produce Poor Output

**Symptom:** `/gsd:execute-phase` produces incomplete or incorrect code.

**Fixes:**

1. **Wrong model profile** — Check with `/gsd:settings`. Use `quality` for critical work:
   ```
   /gsd:set-profile quality     # Opus everywhere
   /gsd:set-profile balanced    # Opus planning, Sonnet execution (default)
   ```

2. **Missing context** — Did you skip `/gsd:discuss-phase`? The planner needs your vision.

3. **Plan wasn't reviewed** — Run `/sc:spec-panel` on the plan BEFORE executing. Bad plans produce bad code.

4. **Context bloat** — Run `/clear` between planning and execution. Planning tokens degrade execution quality.

5. **Stale codebase knowledge** — Run `/gsd:map-codebase` to refresh. Architecture may have shifted since last map.

---

## Serena Can't Find Symbols

**Symptom:** `find_symbol` returns no results or wrong results.

**Fixes:**

1. **Project not activated** — Serena needs to be activated for your project. Check Serena's project configuration.

2. **Wrong language support** — Serena supports specific languages. Check if your language is supported.

3. **Symbol name mismatch** — Use `search_for_pattern` first to find the exact symbol name, then use `find_symbol`.

4. **File not indexed** — Try `get_symbols_overview` on the specific file first.

5. **Fall back to Grep** — If Serena can't find it, use Grep for text-pattern search. Serena is semantic, Grep is textual — sometimes textual is what you need.

---

## MCP Server Won't Connect

**Symptom:** MCP tools are unavailable, errors about server connection.

**Fixes:**

1. **Check `.mcp.json` syntax** — JSON must be valid. Common mistake: trailing commas.

2. **npx not found** — Ensure Node.js and npm are installed: `node --version && npx --version`

3. **Package not available** — Run the npx command manually to see errors:
   ```bash
   npx -y @upstash/context7-mcp
   ```

4. **Permission denied** — Check that Claude Code has permission to run the MCP server command. Add to settings:
   ```json
   { "permissions": { "allow": ["Bash(npx *)"] } }
   ```

5. **Port conflict** — Some MCP servers use specific ports. Check if another process is using it.

6. **Restart Claude Code** — MCP servers are initialized at startup. Changes to `.mcp.json` require a restart.

---

## Mysti Doesn't See My MCP Servers

**Symptom:** Mysti spawns Claude Code but MCP tools are missing.

**Fix:** Mysti spawns Claude Code as a subprocess, which inherits MCP config from `.mcp.json` in the project root. Make sure:

1. `.mcp.json` is in the root of the directory you opened in VSCode
2. The MCP server commands work from that directory
3. Restart Mysti after changing `.mcp.json` (Ctrl+Shift+M to close/reopen)

---

## SuperClaude Flags Don't Work

**Symptom:** `--think-hard`, `--c7`, `--serena` flags seem to be ignored.

**Fixes:**

1. **SuperClaude not installed** — Flags only work if SuperClaude skills are installed. Check `~/.claude/skills/` for SC files.

2. **Skill not loaded** — Skills are loaded based on description matching. If the description doesn't match, the skill won't activate. Run `/context` to check loaded skills.

3. **Wrong syntax** — Flags go after the command, not before:
   ```
   CORRECT: /sc:implement --think-hard "feature"
   WRONG:   --think-hard /sc:implement "feature"
   ```

---

## Permission Prompts Are Annoying

**Symptom:** Claude asks for permission on every git/npm/pytest command.

**Fix:** Add permission wildcards to `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(make *)",
      "Bash(pytest *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Read(*)",
      "Glob(*)",
      "Grep(*)"
    ]
  }
}
```

Commit this file so your whole team benefits. Use `settings.local.json` for personal additions.

---

## GSD State Is Corrupted

**Symptom:** `/gsd:progress` shows wrong state, or GSD commands error out.

**Fixes:**

1. **Run health check:**
   ```
   /gsd:health
   ```
   This diagnoses `.planning/` directory issues and can auto-repair.

2. **Manual inspection** — Check `.planning/STATE.md` for inconsistencies. It's a markdown file you can edit.

3. **Re-map if needed:**
   ```
   /gsd:map-codebase
   ```
   Rebuilds codebase analysis from scratch.

---

## "I Installed Everything But It's Overwhelming"

**Symptom:** 100+ commands, no idea where to start.

**Fix:** Start with just the Golden Path:

```bash
/gsd:progress                    # Where am I?
/gsd:discuss-phase N             # Talk about what to build
/gsd:plan-phase N                # Make a plan
/gsd:execute-phase N             # Build it
/gsd:verify-work N               # Check it works
```

That's 5 commands. Everything else is optional enhancement. See the [Stack Profiles](00-getting-started.md) for a gradual adoption path.

Or use the routing commands:
```bash
/gsd:do "what you want to do"    # GSD picks the right command
/sc:recommend "what you want"     # SC recommends the best approach
```

---

## Still Stuck?

1. Check the [Anti-Patterns](15-anti-patterns.md) — you might be hitting a known mistake
2. Check the [Task Routing](05-task-routing.md) — find the right tool for your task
3. Open a [GitHub Issue](https://github.com/effeuteha/claude-stack/issues) — ask the community
