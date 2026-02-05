---
name: ceremony-delete
description: Perform a deletion with full ceremony - witness, wait, confirm, execute, record
---

# Ceremonial Deletion

Perform a deletion with full deliberation and audit trail.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Witness the Intent

Acknowledge the deletion request formally:

```markdown
## Ceremony: Deletion Request

**Timestamp:** [current datetime]
**Requested By:** user
**Witnessed By:** executor

### Action Requested
Delete: [what is being deleted]

### Consequences
- [Consequence 1: e.g., "Data will be permanently removed"]
- [Consequence 2: e.g., "No recovery possible"]
- [Consequence 3: e.g., "X records affected"]

### Witness Statement
I have witnessed and recorded this deletion request.
A ceremony is now required to proceed.
```

Present this to the user.

## Step 2: Begin Wait Period

Enforce a 60-second wait:

```markdown
## Wait Period

A mandatory 60-second reflection period is now in effect.

This time is for you to consider:
- Is this deletion truly necessary?
- Have you backed up anything needed?
- Are you prepared for permanent data loss?
- Is there an alternative approach?

You cannot proceed until this period completes.

**Wait began:** [time]
**Wait ends:** [time + 60s]
```

The wait is symbolic in the skill—in practice, ask the user to acknowledge they've waited and reflected.

## Step 3: Request Confirmation

After the wait, require explicit confirmation:

```markdown
## Confirmation Required

The wait period has completed.

To proceed with deletion, you must type exactly:

**"I confirm permanent deletion of [target]"**

This confirms you understand:
- The deletion is permanent
- Data cannot be recovered
- You accept responsibility for this action

To cancel, type: **"cancel"**
```

Wait for user response. If they don't confirm exactly, do not proceed.

## Step 4: Verify Confirmation

Check the confirmation:
- Did they use the exact phrase?
- Did they include the target name?
- Was it affirmative (not "I don't confirm...")?

If confirmation is invalid:
```
Confirmation not recognized. The exact phrase is required.
Please type: "I confirm permanent deletion of [target]"
Or say "cancel" to abort.
```

## Step 5: Execute Deletion

Only after valid confirmation:

```markdown
## Executing Deletion

**Confirmation received:** [timestamp]
**Executing as:** executor

Deleting [target]...
```

Perform the actual deletion using appropriate tools.

```markdown
## Execution Complete

**Deleted:** [target]
**Timestamp:** [completion time]
**Status:** Complete
```

## Step 6: Create Ceremony Record

Write a full record to `ceremony-log/[date]-delete-[target].md`:

```markdown
# Ceremony Record: Deletion

**Date:** [full datetime]
**Type:** Deletion
**Target:** [what was deleted]

## Request
- **Requested By:** user
- **Witnessed By:** executor
- **Request Time:** [timestamp]

## Intent
[What the user wanted to delete and why, if stated]

## Consequences Acknowledged
- [Consequence 1]
- [Consequence 2]

## Wait Period
- **Duration:** 60 seconds
- **Started:** [time]
- **Completed:** [time]
- **Cancelled:** No

## Confirmation
- **Phrase Required:** "I confirm permanent deletion of [target]"
- **Phrase Received:** "[exact user input]"
- **Confirmation Time:** [timestamp]
- **Valid:** Yes

## Execution
- **Action:** Delete [target]
- **Method:** [how it was deleted]
- **Completed:** [timestamp]
- **Result:** Success

## Audit
This deletion was performed with full ceremony.
All steps were completed in order.
This record serves as permanent documentation.

---
*Ceremony conducted by executor agent*
```

## Step 7: Update Ceremony Index

Append to `ceremony-log/index.md`:

```markdown
- [date] **DELETE** [target] - [See record](date-delete-target.md)
```

## Step 8: Report Completion

Confirm to the user:

```markdown
## Ceremony Complete

**Action:** Deletion of [target]
**Status:** Complete
**Record:** ceremony-log/[filename].md

This action has been permanently documented.
The deletion cannot be undone.
```
