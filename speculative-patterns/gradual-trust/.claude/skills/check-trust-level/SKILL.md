---
name: check-trust-level
description: Query current trust level, permissions, and progress toward next level
---

# Check Trust Level

Query the current trust state to understand capabilities and progress.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Trust State

Use Read to load `trust-state/level.json`.

If the file doesn't exist, assume Level 0 (initial state):
```json
{
  "level": 0,
  "name": "Observer",
  "successes_at_level": 0,
  "total_successes": 0,
  "failures": 0,
  "last_escalation": null
}
```

## Step 2: Determine Permissions

Based on current level, identify available permissions:

**Level 0 - Observer:**
- Read, Glob, Grep
- Cannot modify files or run commands

**Level 1 - Contributor:**
- Read, Glob, Grep, Write, Edit
- Can create and modify files

**Level 2 - Builder:**
- Above + Bash (echo, cat, ls, mkdir, cp, mv)
- Can run safe shell commands

**Level 3 - Operator:**
- Above + Bash (npm, git, make, python)
- Can run development tools

**Level 4 - Trusted:**
- All tools available
- Full system access

## Step 3: Calculate Progress

Determine progress toward next level:

| Current | Required for Next | Requirement |
|---------|-------------------|-------------|
| 0 | 5 successes | Read-only operations |
| 1 | 10 successes | File edits |
| 2 | 20 successes | Safe command runs |
| 3 | 50 successes + review | Operator tasks |
| 4 | Max level | N/A |

Calculate:
- Successes at current level
- Required for next level
- Progress percentage
- Eligibility for escalation

## Step 4: Check for Blocks

Check if anything blocks escalation:
- Recent failures (trust-state/failures.log)
- Outstanding violations
- Pending escalation requests

## Step 5: Report Status

Present trust status clearly:

```markdown
## Trust Level Status

**Current Level:** [X] - [Name]

### Permissions
- [Tool 1]: Allowed
- [Tool 2]: Allowed
- [Tool 3]: Not yet

### Progress to Level [X+1] ([NextName])
- Successes at this level: [N] / [Required]
- Progress: [percentage]%
- Eligibility: [Eligible / Not yet / Blocked]

### Statistics
- Total successful operations: [N]
- Failures: [N]
- Last escalation: [date or "Never"]

[If eligible for escalation:]
You are eligible to request escalation to Level [X+1].
Use the `request-escalation` skill to proceed.

[If blocked:]
Escalation is currently blocked due to: [reason]
```
