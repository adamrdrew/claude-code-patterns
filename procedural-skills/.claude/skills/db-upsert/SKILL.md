---
name: db-upsert
description: Create a new document or update an existing one. If the topic already exists, updates the document. If it's new, creates the document and adds it to the index. Use this when the user wants to store or update information.
---

# Upsert Document

Create a new document or update an existing one in the database.

Use the TodoWrite tool to create a Todo list and execute the following procedure:

## Todo 1: Verify Database

Use the Skill tool to invoke the `db-verify` skill.

If verification fails:
- Use the Skill tool to invoke `db-init` to initialize the database
- Then proceed to the next step

## Todo 2: Determine Topic and Content

Analyze the user's input to determine:

1. **Topic**: A short, lowercase, hyphenated name for the document (e.g., "pets", "favorite-movies", "work-contacts")
2. **Content**: The information to store

If the topic or content is unclear, ask the user for clarification before proceeding.

## Todo 3: Check If Document Exists

Use the Read tool to read `database/index.md`.

Search the index for an existing entry matching the topic.

Note whether this is an INSERT (new document) or UPDATE (existing document).

## Todo 4: Write Document

Construct the document content as markdown:

```markdown
# [Topic Title]

[Content organized in a clear, readable format]

---
*Last updated: [current date]*
```

**If INSERT (new document):**
Use the Write tool to create `database/<topic>.md` with the content.

**If UPDATE (existing document):**
Use the Read tool to read the existing document first.
Merge the new information with existing content appropriately.
Use the Write tool to update `database/<topic>.md` with the merged content.

## Todo 5: Update Index

**If INSERT (new document):**

Use the Read tool to read `database/index.md`.

Use the Edit tool to update the index:
1. If the index contains "*No documents yet.*", remove that line
2. Add a new entry in the Documents section: `- [Topic](topic.md) - Brief description`

**If UPDATE:**
The index entry already exists. Check if the description needs updating.
If so, use the Edit tool to update the description.

## Todo 6: Verify and Report

Use the Read tool to verify:
1. The document exists at `database/<topic>.md`
2. The index contains an entry for the document

Report to the user:
- What was created/updated
- The topic name for future reference

Example: "Stored your pet information in 'pets'. You can ask me about your pets anytime."

