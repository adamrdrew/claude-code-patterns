---
name: update-memory
description: Add or update a key-value pair in the memory persistence system. Performs upsert - updates existing keys or adds new ones. Requires memory.md to exist.
---

# Update Memory

Add or update entries in the memory persistence system (upsert behavior).

## Procedure

1. Attempt to read `memory.md` from the current working directory using the Read tool

2. **If memory.md does not exist:**
   - Stop execution
   - Inform the user: "Memory has not been initialized. Use the `create-memory` skill first to set up the memory system."
   - Do NOT attempt to create the file

3. **If memory.md exists:**
   - Parse existing entries to find all current key-value pairs
   - Determine the key and value the user wants to store

4. **Upsert logic:**
   - Search for an existing entry with the same key (case-sensitive match on `- **key**:`)
   - **If key exists:** Use the Edit tool to replace the old value with the new value
   - **If key does not exist:** Use the Edit tool to append a new entry after the last existing entry, or after the `<!-- Memory entries below this line -->` comment if no entries exist

5. Confirm the operation to the user:
   - For updates: "Updated **key** from 'old_value' to 'new_value'"
   - For new entries: "Added **key**: value"

## Entry Format

Each memory entry follows this format:
```
- **key**: value
```

## Example Operations

**Adding a new entry:**
```
User: "Remember that my favorite color is blue"
Action: Add `- **favorite_color**: blue`
```

**Updating an existing entry:**
```
User: "Actually, change my favorite color to green"
Action: Replace `- **favorite_color**: blue` with `- **favorite_color**: green`
```

## Notes

- Keys should be snake_case for consistency
- Values can contain any text (single line)
- Keys are case-sensitive
- The skill infers appropriate key names from user requests
