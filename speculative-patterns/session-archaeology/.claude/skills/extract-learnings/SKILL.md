---
name: extract-learnings
description: Analyze recent work and distill key learnings into the archive. Use after completing significant work.
---

# Extract Learnings

Analyze recent work to identify and archive valuable learnings.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Review Recent Work

Examine what was accomplished in recent work:
- What was the goal?
- What approach was taken?
- What obstacles were encountered?
- How were they resolved?
- What was the outcome?

If context is insufficient, ask the user for a summary.

## Step 2: Identify Learnings

Look for three types of learnings:

### Patterns (successes to repeat)
- What approaches worked well?
- What would you do the same way again?
- What shortcuts or efficiencies were discovered?

### Failures (mistakes to avoid)
- What didn't work?
- What took longer than expected?
- What assumptions proved wrong?

### Insights (understanding gained)
- What do you now understand that you didn't before?
- What surprised you?
- What general principles emerged?

## Step 3: Evaluate Significance

For each potential learning, ask:
- Is this actionable for future work?
- Is this general enough to apply again?
- Is this specific enough to be useful?
- Does this already exist in the archive?

Discard learnings that are:
- Too trivial
- Too specific to reuse
- Already known

## Step 4: Format Learnings

For each significant learning, create a structured document:

### For Patterns:
```markdown
# Pattern: [Descriptive Name]
**Type:** pattern
**Context:** [When this applies]
**Date:** [Today's date]

## Summary
[One paragraph summary]

## The Pattern
[Detailed description of what to do]

## Why It Works
[Explanation of why this is effective]

## Example
[Concrete example from this session]
```

### For Failures:
```markdown
# Failure: [Descriptive Name]
**Type:** failure
**Context:** [Situation where this happened]
**Date:** [Today's date]

## Summary
[One paragraph summary]

## What Happened
[Description of the failure]

## Root Cause
[Why it failed]

## How to Avoid
[What to do instead next time]
```

### For Insights:
```markdown
# Insight: [Descriptive Name]
**Type:** insight
**Context:** [When this insight applies]
**Date:** [Today's date]

## Summary
[One paragraph summary]

## The Insight
[What was learned]

## Implications
[How this affects future work]
```

## Step 5: Check for Existing Learnings

Use Glob to search `learnings/` for similar existing learnings:
- If a similar learning exists, UPDATE it rather than creating duplicate
- Add new examples or refine the description

## Step 6: Write to Archive

For each new learning:
1. Determine category: `patterns/`, `failures/`, or `insights/`
2. Create filename: kebab-case of the title
3. Write to `learnings/<category>/<filename>.md`

Ensure the `learnings/` directory structure exists.

## Step 7: Update Index

Read `learnings/index.md` (or create if missing).

Add entries for new learnings:

```markdown
## Patterns
- [Pattern Name](patterns/pattern-name.md) - Brief description

## Failures
- [Failure Name](failures/failure-name.md) - Brief description

## Insights
- [Insight Name](insights/insight-name.md) - Brief description
```

## Step 8: Report Summary

Present the extracted learnings:

```
Learnings Extracted:

Patterns:
- [Name]: [one-line summary]

Failures:
- [Name]: [one-line summary]

Insights:
- [Name]: [one-line summary]

Total: X new learnings archived.
Location: learnings/
```
