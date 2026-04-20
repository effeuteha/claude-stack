# Golden Path — One-Page Card

> **The recommended lifecycle, at a glance.** `spec-phase` is the front door for non-trivial phases; `/gsd:quick` and `/gsd:fast` route around for trivial.

## The path

```
/gsd:progress                 Where am I?
/gsd:spec-phase N             Lock WHAT (falsifiable reqs, ambiguity score)
/gsd:discuss-phase N          Gray-area decisions before implementation choices
/gsd:plan-phase N             Task breakdown with goal-backward verification
  |
  +-- /sc:spec-panel …        Multi-expert review inside Claude
  +-- /gsd:review …           Cross-AI peer review (Gemini / Codex / etc.)
  |
/gsd:execute-phase N          Build it (wave-based parallelization)
/sc:analyze                   Quality scan
/gsd:verify-work N            UAT
/gsd:ship                     PR + review + prep for merge
```

See `../assets/golden-path.svg` for the visual.

## When to skip

| Scenario | Use |
|---|---|
| Single-line fix | `/gsd:fast` or direct edit |
| "Just do it" task | `/gsd:quick` |
| AI / LLM phase | `/gsd:ai-integration-phase` |
| Frontend phase | `/gsd:ui-phase` |
| Explore feasibility (code) | `/gsd:spike` |
| Explore UI variants | `/gsd:sketch` |
| Urgent insert into live roadmap | `/gsd:insert-phase` (decimal phase N.1) |

## Review branch logic

- **`/sc:spec-panel`** — multi-expert within Claude; same model, different persona prior.
- **`/gsd:review`** — cross-AI peer review; different model provider entirely (Gemini, Codex, etc.).
- **High-stakes work:** run both.

## Is `spec-phase` mandatory?

No. It's **recommended good practice**. For truly trivial work (one-liners, config tweaks), skip straight to `/gsd:fast` or `/gsd:quick`. For anything where requirements are non-obvious, start with `spec-phase` — it will catch ambiguity before it turns into rework.

## The four discipline commitments wrapping every phase

1. **Brainstorm-first** before any creative work.
2. **Test-driven** — failing test before implementation.
3. **Verify-before-complete** — evidence before claims.
4. **Systematic debugging** — scientific method, not vibes.

See [02 Discipline Layer](../docs/02-discipline-layer.md).

## See also

- [06 Workflow Phases](../docs/06-workflow-phases.md) — full narrative
- [Tool Inventory](../reference/tool-inventory.md) — every tool, tiered
- [Quick Reference](../reference/quick-reference.md) — top commands + decision tree

---

**Golden path appears identically in:** `README.md` · `docs/06-workflow-phases.md` · `reference/quick-reference.md` · `cheatsheets/golden-path.md` *(this file)*. If you modify the path, update all four.
