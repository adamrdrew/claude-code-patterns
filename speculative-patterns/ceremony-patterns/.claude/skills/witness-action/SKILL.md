---
name: witness-action
description: Formally witness and record an action for audit purposes
---

# Witness Action

Formally witness and record a high-stakes action for audit purposes.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify the Action

Determine what is being witnessed:
- What action is being taken?
- Who is taking it?
- What is the target/subject?
- What are the consequences?

If unclear, ask for details.

## Step 2: Formal Witness Statement

Create a formal witness statement:

```markdown
## Witness Statement

**Date:** [current datetime]
**Witness:** executor agent
**Action:** [description of action]
**Actor:** [who is performing the action]

### I Witness The Following:

[Actor] intends to [action] affecting [target].

### Understood Consequences:
- [Consequence 1]
- [Consequence 2]
- [Consequence 3]

### Context Provided:
[Any context or reasoning provided]

### Witness Acknowledgment:

I, the executor agent, formally witness this intent.
This witnessing is recorded for audit purposes.
The actor proceeds with full knowledge of consequences.

**Witnessed at:** [timestamp]
```

Present to user for acknowledgment.

## Step 3: Record Witness

Write witness record to `ceremony-log/[date]-witness-[action].md`:

```markdown
# Witness Record

**Date:** [full datetime]
**Type:** Witness
**Action Witnessed:** [action]

## Participants
- **Actor:** [who performed]
- **Witness:** executor agent

## Action Details
- **What:** [description]
- **Target:** [what was affected]
- **Reason:** [why, if stated]

## Consequences Acknowledged
- [Consequence 1]
- [Consequence 2]

## Formal Witness
This action was formally witnessed and recorded.
The actor acknowledged understanding of consequences.

## Timestamp
- **Witnessed:** [time]
- **Recorded:** [time]

---
*Witness record by executor agent*
```

## Step 4: Update Ceremony Index

Append to `ceremony-log/index.md`:

```markdown
- [date] **WITNESS** [action] - [See record](date-witness-action.md)
```

## Step 5: Provide Witness Confirmation

Confirm witnessing to the user:

```markdown
## Witness Recorded

I have formally witnessed your intent to [action].

This witnessing:
- Creates an audit record
- Documents your understanding of consequences
- Provides accountability

Record: ceremony-log/[filename].md

You may now proceed with the action.
If you need full ceremony (including wait period and confirmation),
use the appropriate ceremony skill instead.
```

## When to Witness vs Full Ceremony

**Witness only** is appropriate when:
- The action is being done by another system
- You want a record but not the full ceremony
- The action has its own safeguards

**Full ceremony** is appropriate when:
- You are performing the action
- The action is irreversible
- Maximum deliberation is warranted
