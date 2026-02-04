---
name: notes-delete
description: Delete a note from the database. Removes the note file and its index entry.
---

# Delete a Note

This skill removes a note from the notes database.

## Instructions

### 1. Check Configuration Exists

Use the Read tool to try reading `notes-config.yaml`.

**If the file doesn't exist:**
Report: "Notes aren't configured yet. There's nothing to delete. I can help you set up notes — just ask me to add a note."

Stop execution.

### 2. Read the Configuration

Read `notes-config.yaml` and extract the `notes_path` value.

Handle path resolution:
- If the path starts with `~`, expand it to the user's home directory
- If the path starts with `./`, it's relative to the config file location

### 3. Check Database Exists

Use the Read tool to try reading `<notes_path>/index.md`.

If it doesn't exist, report: "The notes database hasn't been initialized yet. There's nothing to delete."

### 4. Find the Note

From the user's request, determine which note they want to delete.

Check the index for a matching topic. If no exact match, list available notes and ask for clarification.

### 5. Confirm Deletion

Before deleting, confirm with the user:

"Are you sure you want to delete the note '[topic]'? This cannot be undone."

Only proceed if the user confirms.

### 6. Delete the Note File

Use Bash to remove the note file:
```bash
rm <notes_path>/<topic>.md
```

### 7. Update the Index

1. Use Read tool to read `<notes_path>/index.md`
2. Use Edit tool to remove the line containing the deleted note
3. If no notes remain, add "*No notes yet.*" to the Notes section

### 8. Confirm to User

Report that the note was deleted successfully.
