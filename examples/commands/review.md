---
description: "Review current changes against the plan"
argument-hint: "[plan-file-path]"
---

Review the current git diff against the plan at `$ARGUMENTS`.

Steps:
1. Read the plan file.
2. Run `git diff` to see all current changes.
3. For each task in the plan, check if the implementation matches the spec.
4. Report:
   - Tasks completed correctly
   - Tasks with issues (explain what's wrong)
   - Tasks not yet started
5. Suggest next steps.
