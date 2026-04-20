# Contributing to Claude Stack

Thanks for your interest in improving the guide. Here's how to contribute.

## Important: this repo is a public manifesto

`claude-stack` is positioned as an opinionated guide — the curator's voice stays tight, tools earn their place. Before opening a PR:

- **No internal project references.** The `.gitignore` excludes local-only artifacts (`.planning/`, `docs/superpowers/`); please don't work around these or include client/employer project names in examples. Use your local `.git/info/exclude` for personal scratch directories.
- **No secrets or credentials.** API keys, tokens, `.env` files, private hostnames, internal IPs — none of this should ever appear in a PR.
- **No excluded tools.** `goodmem`, `claude-mem`, `obsidian-skills` are deliberately out of scope (credentials required, license concerns, or too narrow for a general audience). Don't add them back.

PRs that leak project-specific info or add excluded tools will be closed.

## What We're Looking For

- **New workflow patterns** you've discovered using the stack — especially ones that pair tools in non-obvious ways.
- **Tool integrations** we haven't covered (new MCP servers, plugins, skills) that earn a tier slot.
- **Example configs** for specific tech stacks (Python/Django, Node/React, Rust, Go, etc.).
- **Corrections** — if something is wrong or outdated, please fix it.
- **Clarity improvements** — if something is confusing, help us explain it better.

## Contributing a workflow pattern

Workflow patterns are the highest-value contributions. To submit one:

1. **Identify which chapter it belongs in.** Most patterns fit into `docs/06-workflow-phases.md` (golden path variants), `docs/11-cross-cutting-workflows.md` (cross-phase patterns), or `docs/08-knowledge-management.md` (codebase mapping patterns). If it doesn't fit any existing chapter, propose a location in the PR.
2. **Explain when to use it, not just how.** The reader needs a decision signal — "use this when X, otherwise use Y."
3. **Pair with an anti-pattern where relevant.** If the pattern exists because a common mistake exists, consider updating `docs/15-anti-patterns.md` too.
4. **Keep it tool-agnostic where possible.** Patterns that work only for one tech stack should live in an example, not a chapter.

## Contributing a tool integration

Before documenting a new tool:

1. **Check the tier criteria.** Core = load-bearing in the golden path. Workflow = meaningful to a specific phase. On-Demand = niche but sharp. Excluded = special credentials / license concerns / too narrow.
2. **Add to `reference/tool-inventory.md` first.** Follow the established entry shape: *what it is · one-line value · when to use · commands/trigger · what it pairs with*.
3. **Update counts if the tool adds commands.** See the "Updating tool counts" section below.

## How to Contribute

1. Fork the repository.
2. Create a branch (`git checkout -b improve-context-discipline`).
3. Make your changes.
4. Verify no accidental leaks: `grep -rniE "your-internal-project-name|your-email@" .` (substitute obvious identifiers for your own environment).
5. Submit a PR with a clear description of what you changed and why.

## Guidelines

- **Keep it practical** — every section should answer "what do I do?" not just "what does this mean?"
- **Show, don't tell** — include commands, examples, decision trees.
- **Stay tool-agnostic where possible** — this guide should work for any project, not just one tech stack.
- **ASCII diagrams** — use ASCII art for diagrams so they render everywhere (terminals, GitHub, IDEs). SVG is OK for hero images.
- **Voice:** manifesto — opinionated, terse, declarative. No "it's worth considering"; use "do this" or "don't do this."
- **No fluff** — if a sentence doesn't help the reader do something, cut it.

## Structure

- `docs/` — Detailed guides (numbered for reading order: 00-getting-started, 01-architecture, 02-discipline-layer, …, 15-anti-patterns).
- `reference/` — Lookup tables and matrices.
- `examples/` — Copy-paste-ready config files.
- `cheatsheets/` — Quick reference cards (including the canonical `golden-path.md`).
- `assets/` — Hero SVGs.

## The Golden Path appears in four places

If you modify the golden path, update all four surfaces to keep them identical:

- `README.md`
- `docs/06-workflow-phases.md`
- `reference/quick-reference.md`
- `cheatsheets/golden-path.md`

## Updating tool counts

When tools are added/removed from the stack, update:

1. The relevant `docs/` page (usually `docs/03-claude-code-internals.md`).
2. `reference/tool-inventory.md` — the "Count summary" table at the bottom.
3. `README.md` — the hero paragraph ("150+ commands, skills, and MCP tools").
4. `docs/00-getting-started.md` — the profile tool counts.
