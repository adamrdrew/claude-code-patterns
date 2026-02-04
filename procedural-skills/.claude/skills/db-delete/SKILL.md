---
name: db-delete
description: Remove a document from the database. Deletes the document file and removes its entry from the index. Use this when the user wants to delete stored information.
---

# Delete Document

Remove a document from the database and update the index.

Use the TodoWrite tool to create a Todo list and execute the following procedure:

## Todo 1: Verify Database

Use the Skill tool to invoke the `db-verify` skill.

If verification fails, STOP execution and relay the error message to the user.

## Todo 2: Identify Document to Delete

Analyze the user's request to determine which document they want to delete.

Use the Read tool to read `database/index.md`.

Search the index for a matching document entry.

If no matching document is found:
- Report to the user: "No document found matching '[query]'. Here's what's in the database:" followed by the list of available topics.
- STOP execution.

If multiple documents could match:
- List the matching options and ask the user to specify which one to delete.
- STOP execution until clarified.

## Todo 3: Confirm Deletion

Before proceeding, confirm with the user:

"Are you sure you want to delete the '[topic]' document? This cannot be undone."

Wait for user confirmation. If they decline, STOP execution.

## Todo 4: Read Document for Backup Display

Use the Read tool to read the document at `database/<topic>.md`.

Display a summary of what will be deleted so the user knows what they're losing.

## Todo 5: Delete Document File

Use the Bash tool to remove the document file:

```bash
rm database/<topic>.md
```

Verify the file was deleted by attempting to read it (should fail).

## Todo 6: Update Index

Use the Read tool to read `database/index.md`.

Use the Edit tool to remove the entry for the deleted document from the index.

If this was the last document, add back "*No documents yet.*" under the Documents section.

## Todo 7: Verify and Report

Use the Read tool to verify:
1. The document no longer exists
2. The index no longer contains an entry for it

Report to the user: "Deleted '[topic]' from the database."

