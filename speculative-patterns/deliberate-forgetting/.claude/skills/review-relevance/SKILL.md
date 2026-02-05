---
name: review-relevance
description: Assess memory entries for current usefulness and classify as active, stale, or obsolete
---

# Review Relevance

Assess all memory entries to determine their current relevance.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Memory Index

Use Read to load `memory/index.md`.

Get the list of all active memory entries.

## Step 2: Load Each Entry

For each entry in the index, use Read to load its content.

Extract metadata:
- Created date
- Last used date
- Context
- Expires setting

## Step 3: Assess Each Entry

For each entry, evaluate:

### Time-Based Assessment
- When was it created?
- When was it last used?
- Days since last use?
- Has it expired?

### Context Assessment
- What situation does this apply to?
- Is that situation still active?
- Has the project/task completed?

### Accuracy Assessment
- Is the information still true?
- Has it been superseded by newer info?
- Does it contradict current state?

## Step 4: Classify Entries

Assign each entry a status:

**ACTIVE** — Keep in memory
- Used within last 30 days, OR
- Context is still active, OR
- Marked as permanent

**STALE** — Candidate for archiving
- Not used in 30+ days, AND
- Context may have changed, BUT
- Information might still be useful

**OBSOLETE** — Should be archived
- Information is no longer accurate, OR
- Has been superseded, OR
- Context no longer exists

**PERMANENT** — Never forget
- Marked with `Expires: never`
- Keep regardless of usage

## Step 5: Check for Supersession

Look for entries that cover similar topics.

If a newer entry exists on the same topic:
- Mark older entry as OBSOLETE
- Note which entry supersedes it

## Step 6: Generate Report

Create a review report:

```markdown
# Memory Relevance Review
**Date:** [today]

## Summary
- Total entries: [N]
- Active: [N]
- Stale: [N]
- Obsolete: [N]
- Permanent: [N]

## Active Entries (keep)
| Entry | Last Used | Context |
|-------|-----------|---------|
| [name] | [date] | [context] |

## Stale Entries (consider archiving)
| Entry | Last Used | Days Stale | Reason |
|-------|-----------|------------|--------|
| [name] | [date] | [N] | [why stale] |

## Obsolete Entries (should archive)
| Entry | Reason |
|-------|--------|
| [name] | [why obsolete] |

## Recommendations
- Archive [N] obsolete entries immediately
- Review [N] stale entries for archival
- [Any other recommendations]
```

## Step 7: Present Findings

Report to user:

```
Memory Review Complete

Reviewed [N] entries:
- [N] ACTIVE (current and relevant)
- [N] STALE (not recently used)
- [N] OBSOLETE (should be archived)
- [N] PERMANENT (never expire)

Top candidates for archival:
1. [entry] - [reason]
2. [entry] - [reason]

Would you like me to:
1. Archive all obsolete entries?
2. Review stale entries for archival?
3. Show detailed report?
```
