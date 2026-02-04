---
name: db-list
description: List all documents currently stored in the database. Reads the index and presents a summary of all available documents with their topics and descriptions.
---

# List Database Documents

Display all documents stored in the database.

Use the TodoWrite tool to create a Todo list and execute the following procedure:

## Todo 1: Verify Database

Use the Skill tool to invoke the `db-verify` skill.

If verification fails, STOP execution and relay the error message to the user.

## Todo 2: Read Index

Use the Read tool to read `database/index.md`.

## Todo 3: Parse Document List

Extract all document entries from the index. Each entry follows the format:
```
- [Topic](filename.md) - Description
```

If the index shows "*No documents yet.*" or has no document entries:
- Report to the user: "The database is empty. No documents have been stored yet."
- STOP execution.

## Todo 4: Present Document List

Format and present the list of documents to the user:

```
## Stored Documents

| Topic | Description |
|-------|-------------|
| Pets | Information about user's pets |
| Recipes | Favorite recipes and cooking notes |
...
```

Include a count of total documents at the end.

