---
name: prune-memory
description: Remove obsolete entries from memory by archiving them
---

# Prune Memory

Remove obsolete entries by moving them to the archive.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify Targets

Determine which entries to prune:

Option A: Prune all entries marked obsolete (from review-relevance)
Option B: Prune specific entries by name
Option C: Prune entries matching criteria (age, pattern, etc.)

If no targets specified, run `review-relevance` first to identify obsolete entries.

## Step 2: Verify Each Target

For each entry to be pruned:

1. Use Read to load the entry
2. Confirm it meets pruning criteria:
   - Is it truly obsolete?
   - Is it NOT marked permanent?
   - Has it been superseded or invalidated?

If an entry shouldn't be pruned, remove it from the target list.

## Step 3: Prepare Archive Entries

For each verified target, create an archive version:

```markdown
# [Original Title] (Archived)
**Original Location:** memory/[filename]
**Archived:** [today's date]
**Reason:** [why this was pruned]

---

## Original Content

[Full original content preserved here]

---

## Archive Metadata
- Created: [original create date]
- Last Used: [original last-used date]
- Pruned By: curator
- Reason: [detailed reason for pruning]
```

## Step 4: Create Archive Files

Determine archive location:
- `archive/[year-month]/[filename]`

Use Write to create each archive file.

## Step 5: Update Archive Index

Use Read to load `archive/index.md`.

Add entries for newly archived items:

```markdown
## [Year-Month]

- [Entry Name](path) - Archived [date]: [reason]
```

Use Edit to update the index.

## Step 6: Log the Pruning

Append to `archive/forgotten.log`:

```
[date] [time] - PRUNED
Entry: [name]
Location: memory/[path]
Archived to: archive/[path]
Reason: [why]
---
```

## Step 7: Remove from Active Memory

For each pruned entry:

1. Use Bash to remove the file from `memory/`
2. Or use Write to clear it (safer option)

## Step 8: Update Memory Index

Use Read to load `memory/index.md`.

Remove entries for pruned items.

Use Edit to update the index.

## Step 9: Report Results

Confirm what was pruned:

```
Memory Pruning Complete

Pruned [N] entries:

| Entry | Reason | Archived To |
|-------|--------|-------------|
| [name] | [reason] | archive/[path] |

Memory status:
- Before: [N] entries
- Removed: [N] entries
- After: [N] entries

All pruned entries are preserved in archive/ and can be recovered if needed.
```
