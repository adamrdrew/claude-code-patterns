---
name: notes-add
description: Add a new note or update an existing one. Creates the notes database if it doesn't exist.
---

# Add or Update a Note

This skill creates a new note or updates an existing one in the notes database.

## Instructions

### 1. Check Configuration Exists

Use the Read tool to try reading `notes-config.yaml`.

**If the file doesn't exist:**
1. Tell the user: "I need to set up your notes configuration first."
2. Ask where they'd like to store their notes (suggest `./notes` as default)
3. Read `notes-config.example.yaml` to get the template
4. Create `notes-config.yaml` with their chosen path using the Write tool
5. Continue to step 2

### 2. Read the Configuration

Read `notes-config.yaml` and extract the `notes_path` value.

Handle path resolution:
- If the path starts with `~`, expand it to the user's home directory
- If the path starts with `./`, it's relative to the config file location

### 3. Initialize Database if Needed

Use Bash to check if the notes directory exists:
```bash
ls <notes_path>
```

If the directory doesn't exist:
1. Create it: `mkdir -p <notes_path>`
2. Create the index file with initial content:

```markdown
# Notes Index

A catalog of all notes in the database.

## Notes

*No notes yet.*
```

Write this to `<notes_path>/index.md` using the Write tool.

### 4. Determine Note Topic and Content

From the user's input, determine:
- **Topic**: A short, lowercase, hyphenated identifier (e.g., "grocery-list", "project-ideas", "meeting-notes")
- **Content**: The information to store

If unclear, ask the user for clarification.

### 5. Check if Note Exists

Use the Read tool to read `<notes_path>/index.md`.

Look for an existing entry matching the topic. Note whether this is a new note or an update.

### 6. Write the Note

Create the note content:

```markdown
# [Topic Title]

[Content organized clearly]

---
*Last updated: [current date]*
```

**If new note:** Use Write tool to create `<notes_path>/<topic>.md`

**If updating:** Use Read tool to read existing note first, merge content appropriately, then Write the updated version.

### 7. Update the Index

**If new note:**
1. Read `<notes_path>/index.md`
2. If it contains "*No notes yet.*", remove that line
3. Add entry: `- [Topic Title](topic.md) - Brief description`
4. Write updated index

**If updating:**
- Update the description in the index if needed

### 8. Confirm to User

Report what was created or updated, and mention the topic name for future reference.
