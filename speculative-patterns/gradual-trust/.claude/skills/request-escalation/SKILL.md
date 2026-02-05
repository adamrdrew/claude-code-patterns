---
name: request-escalation
description: Request elevated permissions after meeting trust requirements
---

# Request Escalation

Formally request elevation to the next trust level.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Current State

Use Read to load `trust-state/level.json`.

Verify:
- Current level
- Successes at current level
- Any blocking factors

## Step 2: Verify Eligibility

Check that escalation requirements are met:

| Current Level | Required for Escalation |
|---------------|------------------------|
| 0 → 1 | 5 successes |
| 1 → 2 | 10 successes |
| 2 → 3 | 20 successes |
| 3 → 4 | 50 successes + human review |

If not eligible:
- Report current progress
- Explain what's still needed
- Do not proceed with escalation

## Step 3: Check for Blocks

Review `trust-state/failures.log` for recent issues:
- Failures in last 5 operations
- Any constraint violations
- Pending concerns

If blocks exist:
- Report the blocking issue
- Explain what needs resolution
- Do not proceed with escalation

## Step 4: Prepare Escalation Request

Create an escalation request document:

```markdown
# Escalation Request

**Date:** [today]
**Current Level:** [X] ([Name])
**Requested Level:** [X+1] ([NextName])

## Qualifications

- Successful operations at Level [X]: [N]
- Required: [M]
- Excess: [N - M]

## Track Record

### Recent Successes
[List last 5 successes from log]

### Failures
[List any failures, or "None"]

## New Capabilities Requested

Level [X+1] would grant:
- [New permission 1]
- [New permission 2]

## Use Case

These capabilities are needed for:
[Why the agent needs these permissions]
```

## Step 5: Save Escalation Request

Write the request to `trust-state/pending-escalation.md`.

## Step 6: Request Human Approval

Present the escalation request to the user:

```markdown
## Escalation Request

I am requesting elevation from Level [X] ([Name]) to Level [X+1] ([NextName]).

### My Qualifications
- [N] successful operations at current level (required: [M])
- [Total] total successful operations
- [Failures] failures

### What I'm Requesting
Level [X+1] would allow me to:
- [New capability 1]
- [New capability 2]

### Recent Track Record
[List 3-5 recent successes]

---

**Do you approve this escalation?**

To approve: Confirm and I will update my trust level.
To deny: Let me know and I'll continue at current level.
```

## Step 7: Handle Response

### If Approved:
1. Update `trust-state/level.json`:
   - Increment level
   - Update name
   - Reset successes_at_level to 0
   - Set last_escalation to today

2. Log to `trust-state/escalations.md`:
   ```
   ## [Date] - Level [X] → [X+1]
   - Approved by: user
   - Successes at previous level: [N]
   - New capabilities: [list]
   ```

3. Acknowledge:
   ```
   Escalation approved! I am now at Level [X+1] ([Name]).

   New capabilities:
   - [Capability 1]
   - [Capability 2]

   Thank you for your trust. I will continue to earn it.
   ```

### If Denied:
1. Log the denial in `trust-state/escalations.md`:
   ```
   ## [Date] - Escalation denied
   - Requested: Level [X] → [X+1]
   - Reason: [if provided]
   ```

2. Acknowledge:
   ```
   Understood. I will continue at Level [X] ([Name]).

   I'll keep working to demonstrate trustworthiness.
   Current progress: [N] / [required for next attempt]
   ```

3. Remove `trust-state/pending-escalation.md`
