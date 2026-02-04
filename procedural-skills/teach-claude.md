# Teach Claude: Procedural Skills Pattern

This prompt teaches Claude Code how to implement the **Procedural Skills** pattern - a system that trades autonomy for determinism through structured, step-by-step skill execution.

---

## Prompt

I want you to set up a **Procedural Skills** pattern in this project. This pattern enforces deterministic execution by having skills define numbered steps that the agent executes using Task tools.

### What This Pattern Does

- Skills define numbered procedural steps that must be followed in order
- Agents use `TaskCreate` to create tasks for each step
- Agents use `TaskUpdate` to mark steps as in-progress and completed
- Creates a transparent audit trail of what the agent did
- Prevents improvisation - if a step fails, the agent stops and reports

### Setup Instructions

#### 1. Add to CLAUDE.md

Add these instructions to the project's CLAUDE.md file:

```markdown
## Procedural Skills Pattern

This project uses the Procedural Skills pattern. The `[agent-name]` subagent executes skills through deterministic, numbered steps.

### Invoking the Subagent
Use: `@"[agent-name] (agent)" [your request]`

### How Procedural Skills Work
- Each skill defines numbered steps (Step 1, Step 2, etc.)
- The agent creates tasks for each step using `TaskCreate`
- Steps are executed in strict order
- If a step fails, the agent STOPS and reports the error
- No improvisation allowed - the agent only does what skills define

### Skill Registry
The `skills-list` skill contains all available skills.
Skills use the prefix `[prefix]-` (e.g., `[prefix]-create`, `[prefix]-read`)
```

#### 2. Create Directory Structure

```
.claude/
├── agents/
│   └── [agent-name].md
├── skills/
│   ├── skills-list/
│   │   └── SKILL.md
│   ├── [prefix]-verify/
│   │   └── SKILL.md
│   ├── [prefix]-init/
│   │   └── SKILL.md
│   ├── [prefix]-create/
│   │   └── SKILL.md
│   ├── [prefix]-read/
│   │   └── SKILL.md
│   ├── [prefix]-list/
│   │   └── SKILL.md
│   └── [prefix]-delete/
│       └── SKILL.md
└── settings.local.json
```

#### 3. Create the Agent Definition

Create `.claude/agents/[agent-name].md`:

```yaml
---
name: [agent-name]
description: [Brief description of what the agent does using procedural skills]
tools:
  - Skill
  - Read
  - Write
  - Edit
  - Bash
  - TaskCreate
  - TaskUpdate
  - TaskList
skills:
  - skills-list
color: purple
---
```

The agent prompt should include strict rules:

- **Role description**: What the agent does
- **Operating Rules** (STRICT):
  1. MUST use skills for all operations - never perform direct file operations
  2. Every skill invocation creates Task steps - execute them IN ORDER
  3. If a skill step fails, STOP immediately and report the error
  4. Never improvise or work around errors
  5. Never explore the filesystem - the index is the source of truth
- **Operating Procedure**:
  1. Invoke `skills-list` to discover available skills
  2. Determine which skill matches the user's request
  3. Invoke the skill - it will guide you through TaskCreate/TaskUpdate
  4. Report the results to the user

#### 4. Create the skills-list Skill

Create `.claude/skills/skills-list/SKILL.md`:

```yaml
---
name: skills-list
description: Lists all available skills for [agent-name]
---

# Available Skills

## [Category] Skills

| Skill | Description |
|-------|-------------|
| `[prefix]-verify` | Verify [resource] exists and is initialized |
| `[prefix]-init` | Initialize the [resource] |
| `[prefix]-create` | Create a new [item] |
| `[prefix]-read` | Read [items] matching a query |
| `[prefix]-list` | List all [items] |
| `[prefix]-delete` | Delete an [item] |

## Meta Skills

| Skill | Description |
|-------|-------------|
| `skills-list` | This skill - lists all available skills |
```

#### 5. Create Procedural Skills

Each skill follows this structure:

```yaml
---
name: [prefix]-[action]
description: [What this skill does]
---

# [Skill Title]

## Step 1: [First Step Name]

[Instructions for step 1]

## Step 2: [Second Step Name]

[Instructions for step 2]

## Step 3: [Third Step Name]

[Instructions for step 3]

...continue with numbered steps...
```

Example procedural skill (`[prefix]-create`):

```yaml
---
name: [prefix]-create
description: Create a new [item] in the [resource]
---

# Create [Item]

## Step 1: Verify [Resource]

Invoke the `[prefix]-verify` skill to ensure [resource] exists.
If it doesn't exist, invoke `[prefix]-init` to initialize it.

## Step 2: Determine [Item] Details

Extract from user input:
- [Item] name/identifier
- [Item] content/data

If unclear, ask the user for clarification.

## Step 3: Check If [Item] Exists

Read the index file at `[resource]/index.md`.
Determine if this is a new [item] or an update to an existing one.

## Step 4: Write [Item] File

Create/update the file at `[resource]/[item-name].md` with:
- Metadata header
- Content from user

## Step 5: Update Index

Add or update the [item] entry in `[resource]/index.md`.

## Step 6: Verify and Report

Confirm the [item] was created/updated successfully.
Report to the user:
- What was done (created/updated)
- The [item] name/path
```

#### 6. Create Verify and Init Skills

These foundational skills are used by other skills:

**[prefix]-verify:**
```yaml
---
name: [prefix]-verify
description: Verify the [resource] exists and is properly initialized
---

# Verify [Resource]

## Step 1: Check [Resource] Directory

Use `ls` to check if `[resource]/` directory exists.

## Step 2: Check Index File

If directory exists, check for `[resource]/index.md`.

## Step 3: Report Status

Report whether [resource] is:
- Fully initialized (directory + index exist)
- Partially initialized (directory exists, no index)
- Not initialized (nothing exists)
```

**[prefix]-init:**
```yaml
---
name: [prefix]-init
description: Initialize the [resource]
---

# Initialize [Resource]

## Step 1: Create Directory

Create the `[resource]/` directory if it doesn't exist.

## Step 2: Create Index

Create `[resource]/index.md` with header:
```markdown
# [Resource] Index

| Name | Description |
|------|-------------|
```

## Step 3: Verify

Use `[prefix]-verify` to confirm initialization succeeded.
```

#### 7. Configure Permissions

Create `.claude/settings.local.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(mkdir:*)",
      "Bash(echo:*)",
      "Bash(rm:*)",
      "Bash([:*)"
    ]
  }
}
```

### After Setup

Once complete, report to the user:

**Procedural Skills pattern is ready!**

You can now:
- Invoke the subagent: `@"[agent-name] (agent)" [request]`
- Watch as the agent creates tasks for each step
- See transparent execution via TaskCreate/TaskUpdate
- Trust that steps execute in defined order with no improvisation

Available skills:
- `skills-list` - Lists all available skills
- `[prefix]-verify` - Verify [resource] is initialized
- `[prefix]-init` - Initialize the [resource]
- `[prefix]-create` - Create a new [item]
- `[prefix]-read` - Read [items] by query
- `[prefix]-list` - List all [items]
- `[prefix]-delete` - Delete an [item]

The agent executes each skill's numbered steps deterministically, creating a full audit trail of actions taken.