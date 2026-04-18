# Contributing to Claude Stack

Thanks for your interest in improving the guide. Here's how to contribute.

## What We're Looking For

- **New workflow patterns** you've discovered using the stack
- **Tool integrations** we haven't covered (new MCP servers, plugins, skills)
- **Example configs** for specific tech stacks (Python/Django, Node/React, Rust, Go, etc.)
- **Corrections** — if something is wrong or outdated, please fix it
- **Clarity improvements** — if something is confusing, help us explain it better

## How to Contribute

1. Fork the repository
2. Create a branch (`git checkout -b improve-context-discipline`)
3. Make your changes
4. Submit a PR with a clear description of what you changed and why

## Guidelines

- **Keep it practical** — every section should answer "what do I do?" not just "what does this mean?"
- **Show, don't tell** — include commands, examples, decision trees
- **Stay tool-agnostic where possible** — this guide should work for any project, not just one tech stack
- **ASCII diagrams** — use ASCII art for diagrams so they render everywhere (terminals, GitHub, IDEs)
- **No fluff** — if a sentence doesn't help the reader do something, cut it

## Structure

- `docs/` — Detailed guides (numbered for reading order)
- `reference/` — Lookup tables and matrices
- `examples/` — Copy-paste-ready config files
- `cheatsheets/` — Quick reference cards

## Updating Tool Counts

When tools are added/removed from the stack, update:
1. The relevant `docs/` page
2. `reference/tool-inventory.md`
3. `README.md` tool counts table
