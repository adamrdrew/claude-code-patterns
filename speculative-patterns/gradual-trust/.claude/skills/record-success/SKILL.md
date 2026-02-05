---
name: record-success
description: Log a successful operation to build trust score
---

# Record Success

Log a successful operation to increment trust score.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Gather Operation Details

Identify what was accomplished:
1. **Operation type**: What kind of task? (read, edit, build, etc.)
2. **Tools used**: What tools were invoked?
3. **Outcome**: What was the result?
4. **Quality indicators**: Any evidence of success?

## Step 2: Load Current State

Use Read to load `trust-state/level.json`.

If it doesn't exist, initialize with Level 0 defaults.

## Step 3: Validate the Success

Confirm this should count as a success:
- The operation completed without errors
- The outcome matches the goal
- No violations occurred

If the operation failed or had issues, do NOT record as success.

## Step 4: Update Trust State

Increment the relevant counters:
```json
{
  "level": [current],
  "name": "[name]",
  "successes_at_level": [N + 1],
  "total_successes": [total + 1],
  "failures": [unchanged],
  "last_operation": "[today's date]"
}
```

Use Write to save updated `trust-state/level.json`.

## Step 5: Log the Success

Append to `trust-state/successes.log`:

```
[date] [time]
Level: [X]
Operation: [description]
Tools: [tools used]
Outcome: [result summary]
Success #[N] at level [X]
---
```

Use Read to get current log, then Edit to append (or Write if new).

## Step 6: Check Escalation Eligibility

After updating, check if now eligible for escalation:

| Level | Required Successes |
|-------|-------------------|
| 0 → 1 | 5 |
| 1 → 2 | 10 |
| 2 → 3 | 20 |
| 3 → 4 | 50 |

If newly eligible, note this in the report.

## Step 7: Report

Confirm the success was recorded:

```
Success recorded.

Operation: [description]
Tools used: [list]

Trust Statistics:
- Current level: [X] ([Name])
- Successes at this level: [N] / [required]
- Progress to next level: [percentage]%

[If newly eligible:]
You are now eligible for escalation to Level [X+1]!
Use the `request-escalation` skill to proceed.

[If not eligible:]
[Required - N] more successful operations needed for Level [X+1].
```
