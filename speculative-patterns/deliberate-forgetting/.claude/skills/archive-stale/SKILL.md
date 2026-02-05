---
name: archive-stale
description: Move stale (not recently used) entries to archive
---

# Archive Stale Entries

Move entries that haven't been used recently to the archive.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Define Staleness Threshold

Determine what counts as "stale":
- Default: Not used in 30 days
- Or user-specified threshold

## Step 2: Scan Memory

Use Glob to find all entries in `memory/`:
```
memory/*.md
```

Exclude `index.md`.

## Step 3: Assess Each Entry

For each entry:

1. Use Read to load content
2. Extract `Last Used` date from metadata
3. Calculate days since last use
4. Check for `Expires: never` (skip if present)

Create list of stale entries:
```
| Entry | Last Used | Days Stale |
|-------|-----------|------------|
| [name] | [date] | [N] |
```

## Step 4: Confirm Archival Candidates

For entries that exceed the threshold:

1. Verify they're not marked permanent
2. Check if they're referenced by other entries
3. Confirm no active context

Create final list of entries to archive.

## Step 5: Create Archive Entries

For each entry to archive:

```markdown
# [Original Title] (Archived)
**Original Location:** memory/[filename]
**Archived:** [today's date]
**Reason:** Stale - not used in [N] days

---

## Original Content

[Full original content]

---

## Archive Metadata
- Created: [original date]
- Last Used: [last used date]
- Days Stale: [N]
- Threshold: [threshold used]
```

## Step 6: Write Archive Files

Determine archive path:
- `archive/[year-month]/[filename]`

Create the directory if needed.

Use Write to create each archive file.

## Step 7: Update Archive Index

Use Read to get current `archive/index.md`.

Add new entries:

```markdown
## [Year-Month]

- [Entry Name](path) - Stale [N] days, archived [date]
```

Use Edit to update.

## Step 8: Log Archival

Append to `archive/forgotten.log`:

```
[date] [time] - ARCHIVED (stale)
Entry: [name]
Last Used: [date]
Days Stale: [N]
Threshold: [threshold]
Archived to: archive/[path]
---
```

## Step 9: Remove from Active Memory

For each archived entry:
- Remove the file from `memory/`
- Update `memory/index.md`

## Step 10: Report Results

Summarize the archival:

```
Stale Entry Archival Complete

Threshold: [N] days of inactivity

Archived [N] entries:

| Entry | Days Stale | Archived To |
|-------|------------|-------------|
| [name] | [N] | archive/[path] |

Memory status:
- Before: [N] active entries
- Archived: [N] stale entries
- After: [N] active entries

Archived entries are preserved in archive/ and can be recovered.
To restore an entry, copy it from archive/ back to memory/.
```
