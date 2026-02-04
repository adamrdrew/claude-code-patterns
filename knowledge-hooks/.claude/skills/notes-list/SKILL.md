---
name: notes-list
description: List all notes in the database with their topics and descriptions.
---

# List All Notes

This skill lists all notes currently stored in the database.

Note: When notes-buddy is first invoked, the entire database is injected into context via hooks. You typically only need this skill to get a fresh list after making changes.

## Instructions

### 1. Check Configuration Exists

Use the Read tool to try reading `notes-config.yaml`.

**If the file doesn't exist:**
Report: "Notes aren't configured yet. I can help you set that up — just ask me to add a note and I'll walk you through the setup."

Stop execution.

### 2. Read the Configuration

Read `notes-config.yaml` and extract the `notes_path` value.

Handle path resolution:
- If the path starts with `~`, expand it to the user's home directory
- If the path starts with `./`, it's relative to the config file location

### 3. Check Database Exists

Use the Read tool to try reading `<notes_path>/index.md`.

If it doesn't exist, report: "The notes database hasn't been initialized yet. Use notes-add to create your first note."

### 4. Parse and Present

Read the index and extract all note entries.

Present to the user as a formatted table:

```
## Your Notes

| Topic | Description |
|-------|-------------|
| grocery-list | Weekly shopping items |
| project-ideas | Ideas for new projects |

Total: 2 notes
```

If no notes exist, report: "Your notes database is empty. Use notes-add to create your first note."
