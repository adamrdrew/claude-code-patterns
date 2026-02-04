---
name: db-init
description: Initialize the database by creating the database/ directory and an empty index.md file. Safe to call if database already exists - will not overwrite existing data.
---

# Initialize Database

Create the database directory structure and initialize an empty index.

Use the TodoWrite tool to create a Todo list and execute the following procedure:

## Todo 1: Check If Already Initialized

Use the Bash tool to check if the database directory exists:

```bash
[ -d "database" ] && echo "EXISTS" || echo "MISSING"
```

If the output is "EXISTS":
- Use the Read tool to check if `database/index.md` exists
- If index exists, report: "Database already initialized. No action needed."
- STOP execution. Do not proceed to further steps.

## Todo 2: Create Database Directory

Use the Bash tool to create the database directory:

```bash
mkdir -p database
```

## Todo 3: Create Index File

Use the Write tool to create `database/index.md` with the following content:

```markdown
# Database Index

This file tracks all documents stored in the database.

## Documents

<!-- Documents will be listed here as: - [Topic](filename.md) - Description -->

*No documents yet.*
```

## Todo 4: Verify Initialization

Use the Read tool to read `database/index.md` and verify it was created correctly.

## Todo 5: Report Success

Report to the caller: "Database initialized successfully. The database is ready to store documents."

