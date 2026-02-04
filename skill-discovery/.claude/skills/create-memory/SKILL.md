---
name: create-memory
description: Initialize the memory persistence system by creating memory.md if it doesn't exist. Safe to call multiple times - will not overwrite existing memory.
---

# Create Memory

Initialize the memory persistence system.

## Procedure

1. Check if `memory.md` exists in the current working directory using the Read tool

2. **If memory.md already exists:**
   - Inform the user that memory already exists
   - Show them a brief summary of current memory contents
   - Do NOT overwrite or modify the file

3. **If memory.md does not exist:**
   - Create `memory.md` with the following initial structure:

```markdown
# Memory

This file stores persistent key-value pairs.

## Entries

<!-- Memory entries below this line -->
```

4. Confirm to the user that memory has been initialized

## File Location

Memory is stored at: `./memory.md` (current working directory)

## Format

Memory entries are stored as markdown list items in key-value format:
```
- **key**: value
```
