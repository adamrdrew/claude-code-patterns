---
name: observe-composition
description: Log skill co-occurrence patterns for later analysis and synthesis
---

# Observe Composition

Log when multiple skills are used together to identify patterns for synthesis.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Gather Information

Identify from the user or context:
1. **Skills used**: What skills were invoked?
2. **Order**: In what sequence?
3. **Context**: What was the user trying to accomplish?

If any information is missing, ask the user.

## Step 2: Format Observation

Create an observation entry:

```markdown
## Observation: [date] [time]

**Skills invoked:**
1. [skill-1]
2. [skill-2]
3. [skill-3] (if applicable)

**Sequence:** [skill-1] → [skill-2] → [skill-3]

**Context:** [What the user was trying to do]

**Notes:** [Any relevant observations about why these were used together]

---
```

## Step 3: Check for Existing Pattern

Use Read to examine `observations/log.md` (if it exists).

Search for previous occurrences of this skill combination:
- Same skills (in any order)
- Same sequence (exact order)
- Similar context

Note the count of previous occurrences.

## Step 4: Update Pattern Count

If this pattern exists:
- Increment the count in `observations/patterns.md`
- Note this is observation #N for this pattern

If this is a new pattern:
- Add it to `observations/patterns.md`

Pattern format:
```markdown
## Pattern: [skill-1] → [skill-2] → [skill-3]
- **Count:** [N]
- **First seen:** [date]
- **Last seen:** [date]
- **Typical context:** [summary]
```

## Step 5: Write to Log

Use Read to get current `observations/log.md` content (or start fresh).

Use Edit (or Write if new) to append the observation.

Ensure observations are in reverse chronological order (newest first).

## Step 6: Check Synthesis Threshold

If this pattern has now been observed 3+ times:
- Flag it as a synthesis candidate
- Note it in `observations/candidates.md`

Candidate format:
```markdown
## Candidate: [pattern-name]
- **Pattern:** [skill-1] → [skill-2] → [skill-3]
- **Observations:** [N]
- **Proposed name:** [suggested-composite-name]
- **Status:** pending review
```

## Step 7: Report

Confirm the observation was logged:

```
Composition observed and logged.

Skills: [list]
Sequence: [A] → [B] → [C]
Context: [summary]

This pattern has been observed [N] times.
[If N >= 3: "This pattern is now a synthesis candidate."]
```
