# Prompting Patterns

Effective prompting patterns gathered from Claude Code's creator and power users.

## Brainstorm First, Build Second

The single highest-leverage pattern: before any creative work, invoke the brainstorming skill so Claude interrogates the requirements with you instead of assuming them. This is the first commitment of the [Discipline Layer](02-discipline-layer.md) and it compounds with every other pattern below.

```
/superpowers:brainstorming
# or, for a phase:
/gsd-spec-phase N
```

Implementation questions hide requirement ambiguity — brainstorm-first surfaces the ambiguity before it turns into rework.

## Challenge Claude (Don't Accept Mediocrity)

```
"Grill me on these changes and don't make a PR until I pass your test."
"Prove to me this works."
"Knowing everything you know now, scrap this and implement the elegant solution."
```

## Reduce Ambiguity Before Handoff

```
# Instead of: "add authentication"
# Do: Write a detailed spec, then:
"Implement this spec exactly. Ask me if anything is unclear before starting."
```

## Let Claude Interview You

```
"I want to build X. Interview me about the requirements -- ask me everything
you need to know before writing a single line of code."
```

## Use Depth Keywords

```
"think"        -> Standard reasoning (~4K tokens)
"think hard"   -> Deep analysis (~10K tokens)
"ultrathink"   -> Maximum depth (~32K tokens)
```

## Paste-and-Fix

For bugs, paste the error/screenshot and say "fix" — don't micromanage the approach.

## Second Opinion

Spin up a second Claude (new terminal tab, or Mysti with `@gemini`) to review the first Claude's work. Multiple uncorrelated context windows > one large context.

## Plan-First, Execute-Second

```
# Enter plan mode: Shift+Tab twice
# Pour energy into the plan -- Claude can 1-shot a good plan
# /clear between planning and execution
# Execute from the plan in a clean context
```

## Write Rules for Itself

After correcting Claude:
```
"Update your CLAUDE.md so you don't make that mistake again."
```
Claude is "eerily good at writing rules for itself."

## Use Subagents

```
"Use subagents to handle the research and implementation in parallel."
```
Offloads work to isolated contexts, keeping your main context clean.

## Share Screenshots

When debugging UI issues or errors, share screenshots directly. Claude is multimodal and can read them.

---

**Previous:** [Mysti + VSCode](13-mysti-vscode.md) | **Next:** [Anti-Patterns](15-anti-patterns.md)
