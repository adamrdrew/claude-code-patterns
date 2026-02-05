---
name: skill-compete
description: Run two competing skill versions on the same input and capture their outputs for comparison
---

# Skill Competition

Run two skill versions on identical input to compare their outputs.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify Competitors

Determine:
1. **Skill A**: First version to test (e.g., `format-v1`)
2. **Skill B**: Second version to test (e.g., `format-v2`)
3. **Test input**: The input both versions will receive

If any are unclear, ask for clarification.

## Step 2: Verify Competitors Exist

Use Glob to check both skill versions exist in `arena/competitors/`:

```
arena/competitors/<skill-a>/SKILL.md
arena/competitors/<skill-b>/SKILL.md
```

If either is missing, report the issue.

## Step 3: Read Skill Definitions

Use Read to examine both skill files:
- Understand what each version does
- Note the documented differences between them

## Step 4: Run Skill A

Execute the first skill version:
- Read its SKILL.md for instructions
- Apply those instructions to the test input
- Capture the complete output

Store as `Output A`.

## Step 5: Run Skill B

Execute the second skill version:
- Read its SKILL.md for instructions
- Apply those instructions to the same test input
- Capture the complete output

Store as `Output B`.

## Step 6: Document Competition

Create a competition record at `arena/results/<skill>-<date>.md`:

```markdown
# Competition: [skill-name]
**Date:** [today's date]
**Competitors:** [skill-a] vs [skill-b]

## Test Input
[The input used]

## Output A ([skill-a])
[Complete output from skill A]

## Output B ([skill-b])
[Complete output from skill B]

## Differences Noted
- [Key difference 1]
- [Key difference 2]

## Ready for Evaluation
Use the `fitness-eval` skill to evaluate these outputs.
```

## Step 7: Report Results

Present the competition results:
- Show both outputs (or summaries if long)
- Highlight observable differences
- Indicate readiness for fitness evaluation
