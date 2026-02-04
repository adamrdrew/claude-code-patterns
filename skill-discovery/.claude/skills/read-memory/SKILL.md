---
name: read-memory
description: Read all entries from the memory persistence system, or look up a specific key. Requires memory.md to exist.
---

# Read Memory

Read entries from the memory persistence system.

## Procedure

1. Attempt to read `memory.md` from the current working directory using the Read tool

2. **If memory.md does not exist:**
   - Stop execution
   - Inform the user: "Memory has not been initialized. Use the `create-memory` skill first to set up the memory system."
   - Do NOT attempt to create the file

3. **If memory.md exists:**
   - Parse the file for memory entries (lines matching `- **key**: value` format)
   - If the user asked for a specific key, find and return that value
   - If the user asked for all memory, list all key-value pairs
   - If no entries exist, inform the user that memory is empty

## Output Format

When displaying memory entries:

```
## Current Memory

- **key1**: value1
- **key2**: value2
```

Or for a specific key lookup:

```
**key**: value
```

If key not found:

```
Key "requested_key" not found in memory.
```
