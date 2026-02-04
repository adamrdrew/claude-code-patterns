---
name: notes-read
description: Read a specific note from the database. Use this to get fresh content after making changes.
---

# Read a Note

This skill reads a specific note from the notes database.

Note: When notes-buddy is first invoked, the entire database is injected into context via hooks. You typically only need this skill to re-read notes after making changes.

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

### 4. Find the Note

From the user's request, determine which note they want to read.

Check the index for a matching topic. Match by:
- Exact topic name
- Partial match
- Description keywords

If no match found, list available notes and ask the user to clarify.

### 5. Read and Present

Use the Read tool to read `<notes_path>/<topic>.md`.

Present the content to the user in a clear, readable format.
