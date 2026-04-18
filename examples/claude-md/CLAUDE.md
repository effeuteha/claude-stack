# CLAUDE.md

<!--
  This is an annotated template. Customize for your project.
  Target: under 200 lines. Split into .claude/rules/ if larger.
  Commit this file to git. Use CLAUDE.local.md for personal preferences.
-->

## Project Overview

<!-- What is this project? 2-3 sentences max. -->

**[Project Name]** — [One-line description of what it does].

| | |
|---|---|
| **Stack** | [e.g., Python 3.12 + FastAPI + PostgreSQL + React 19 + TypeScript] |
| **Status** | [e.g., Production, Beta, MVP] |

## Quick Commands

```bash
# Setup
[e.g., source venv/bin/activate]

# Run
[e.g., make run-api]

# Test
[e.g., make test]

# Build
[e.g., npm run build]
```

## Architecture

```
src/
├── [main module]/
│   ├── [submodule 1]/    # [Brief description]
│   └── [submodule 2]/    # [Brief description]
├── api/                  # [API layer]
└── [other]/              # [Description]
```

<!--
  Include the data flow if it's not obvious from the structure:
  Input -> Processing -> Storage -> API -> Frontend
-->

## Critical Conventions

<!--
  ONLY put rules here that Claude has violated or could easily get wrong.
  Don't document obvious things. Focus on surprises and gotchas.
-->

### [Convention 1: e.g., Database Queries]

```python
# CORRECT
[show the right pattern]

# WRONG (and why)
[show the wrong pattern]
```

### [Convention 2: e.g., Naming Patterns]

<!-- Use the same CORRECT/WRONG format for clarity -->

## Security

<!--
  Only if relevant. Common items:
  - How credentials are managed
  - SQL injection prevention patterns
  - Input validation rules
  - Access control patterns
-->

## Testing

```bash
[test command]              # All tests
[specific test command]     # Specific file
```

## Documentation Index

<!-- Point to detailed docs. Only include docs that exist. -->

| Doc | When to Read |
|-----|-------------|
| [docs/ARCHITECTURE.md] | When asked about architecture |
| [docs/API.md] | When working on API endpoints |
