---
name: apply-learnings
description: Find and apply relevant learnings from the archive to current work
---

# Apply Learnings

Search the learnings archive for knowledge relevant to current work.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Understand Current Context

Determine what the user is working on:
- What is the current task or goal?
- What domain or area does it involve?
- What challenges are anticipated?

If unclear, ask for clarification about the current work.

## Step 2: Identify Search Terms

Based on the current context, identify keywords to search for:
- Domain terms (auth, database, API, testing, etc.)
- Action terms (refactor, migrate, debug, etc.)
- Problem terms (error, failure, timeout, etc.)

## Step 3: Search the Archive

Use Grep to search `learnings/` for relevant content:

```
Grep pattern: [search term]
Path: learnings/
```

Search across:
- File contents (detailed matching)
- File names (quick matching)

Collect potentially relevant files.

## Step 4: Read Relevant Learnings

For each potentially relevant file, use Read to examine:
- The context field (does it match current situation?)
- The summary (is this actually relevant?)
- The full content (if context matches)

Discard learnings where context doesn't apply.

## Step 5: Rank by Relevance

Order the relevant learnings by:
1. **Direct match**: Context closely matches current situation
2. **Partial match**: Some aspects apply
3. **Tangential**: Might be useful

## Step 6: Synthesize Application

For each relevant learning, determine how it applies:

### For Patterns:
- Can this pattern be used directly?
- What adaptations are needed?
- What steps should be followed?

### For Failures:
- Is the current approach at risk of this failure?
- What should be done differently?
- What warning signs to watch for?

### For Insights:
- How does this insight inform the current approach?
- What implications does it have?

## Step 7: Present Findings

Format the applicable learnings:

```markdown
## Relevant Learnings for [Current Task]

### Directly Applicable

**[Learning Title]** (pattern/failure/insight)
- *Context*: [why this applies]
- *Key point*: [most important takeaway]
- *Application*: [how to use this now]

[Link to full learning]

### Worth Considering

**[Learning Title]**
- *Relevance*: [how this might apply]
- *Caveat*: [why context might differ]

### Warnings

**[Failure Title]**
- *Risk*: [what could go wrong]
- *Prevention*: [how to avoid it]
```

## Step 8: Offer Guidance

Based on the learnings found, offer specific guidance:

- If patterns apply: Suggest following the pattern
- If failures are relevant: Warn about the risk
- If insights apply: Explain the implications

End with:
```
Based on past learnings, consider:
1. [Specific recommendation]
2. [Another recommendation]
3. [Watch out for X]
```
