# Teach Claude: Skill Discovery Pattern

This prompt teaches Claude Code how to implement the **Skill Discovery** pattern - a system where subagents discover their available skills at runtime rather than having them preloaded.

---

## Prompt

I want you to set up a **Skill Discovery** pattern in this project. This pattern reduces initial token overhead by having agents discover skills on-demand rather than pre-loading all skill content.

### What This Pattern Does

- Subagents start with only a `list-skills` skill preloaded
- At runtime, agents invoke `list-skills` to discover available capabilities
- Agents are restricted to ONLY the skills listed in the discovery output
- Reduces context token usage while keeping agents fully informed
- Skills can be added without modifying the agent definition

### Setup Instructions

#### 1. Add to CLAUDE.md

Add these instructions to the project's CLAUDE.md file:

```markdown
## Skill Discovery Pattern

This project uses the Skill Discovery pattern. The `[agent-name]` subagent discovers available skills at runtime.

### Invoking the Subagent
Use: `@"[agent-name] (agent)" [your request]`

### How Skill Discovery Works
- The agent starts with only `list-skills` preloaded
- First action: invoke `list-skills` to discover capabilities
- The agent can ONLY use skills returned by `list-skills`
- No improvisation - if a skill doesn't exist, the agent cannot help

### Adding New Skills
1. Create the skill in `.claude/skills/[skill-name]/SKILL.md`
2. Update `list-skills` to include the new skill
3. The agent will discover it on next invocation

### Skill Naming Convention
Skills use the prefix `[prefix]-` (e.g., `[prefix]-fetch-data`)
```

#### 2. Create Directory Structure

```
.claude/
├── agents/
│   └── [agent-name].md
├── skills/
│   ├── list-skills/
│   │   └── SKILL.md
│   ├── [prefix]-[skill-1]/
│   │   └── SKILL.md
│   ├── [prefix]-[skill-2]/
│   │   └── SKILL.md
│   └── ...
└── settings.local.json
```

#### 3. Create the Agent Definition

Create `.claude/agents/[agent-name].md`:

```yaml
---
name: [agent-name]
description: [Brief description of what the agent does]
tools:
  - Skill
  - Bash
  - Read
skills:
  - list-skills
color: blue
---
```

Note: ONLY `list-skills` is preloaded. All other skills are discovered at runtime.

The agent prompt should include:

- **Role description**: What the agent does
- **Operating Rules** (STRICT):
  1. MUST invoke `list-skills` before doing anything else
  2. Can ONLY use skills that appear in the `list-skills` output
  3. Never improvise or use tools outside of skill procedures
  4. If a skill fails, STOP and report the exact error
  5. Never perform research or actions not covered by skills
- **Operating Procedure**:
  1. Invoke `list-skills` to discover available skills
  2. Check for any required context (e.g., memory/config skills)
  3. Use appropriate skills to accomplish the user's request
  4. Interpret results - don't just dump raw data
  5. Report findings to the user

#### 4. Create the list-skills Skill

Create `.claude/skills/list-skills/SKILL.md`:

```yaml
---
name: list-skills
description: Discover all available skills for [agent-name]
---

# Available Skills

This is the complete list of skills available to [agent-name].

## [Category 1] Skills

| Skill | Description |
|-------|-------------|
| `[prefix]-[skill-1]` | [What this skill does] |
| `[prefix]-[skill-2]` | [What this skill does] |

## [Category 2] Skills

| Skill | Description |
|-------|-------------|
| `[prefix]-[skill-3]` | [What this skill does] |
| `[prefix]-[skill-4]` | [What this skill does] |

## Memory/State Skills (if applicable)

| Skill | Description |
|-------|-------------|
| `create-memory` | Initialize the memory file |
| `read-memory` | Read stored key-value pairs |
| `update-memory` | Add or update a key-value pair |

## Meta Skills

| Skill | Description |
|-------|-------------|
| `list-skills` | This skill - lists all available skills |

---

**Important:** The agent can ONLY use skills listed above. If a capability isn't listed here, the agent cannot perform it.
```

#### 5. Create Domain Skills

Create skills for the agent's domain. Each skill should:
- Have clear YAML frontmatter with name and description
- Define the procedure the agent should follow
- Reference other skills if needed (skills can invoke skills)

Example structure:
```yaml
---
name: [prefix]-[action]
description: [Clear, actionable description]
---

# [Skill Title]

## Purpose
[What this skill accomplishes]

## Procedure

1. [First step]
2. [Second step]
3. [Third step]

## Output
[What the skill should report back]
```

#### 6. Create Memory Skills (Optional)

If your agent needs to persist state between invocations, create memory skills:

**create-memory:**
```yaml
---
name: create-memory
description: Initialize the memory file for persistent storage
---

# Create Memory

Create `./memory.md` with this structure:

```markdown
# Memory

This file stores persistent key-value pairs.

## Entries

<!-- Memory entries below this line -->
```
```

**read-memory:**
```yaml
---
name: read-memory
description: Read all memory entries or look up a specific key
---

# Read Memory

## Procedure

1. Read `./memory.md`
2. If a specific key was requested, find and return its value
3. If no key specified, return all entries
4. If memory.md doesn't exist, report "No memory initialized"
```

**update-memory:**
```yaml
---
name: update-memory
description: Add or update a key-value pair in memory
---

# Update Memory

## Procedure

1. Read current `./memory.md`
2. If memory doesn't exist, invoke `create-memory` first
3. Check if key already exists
4. If exists: update the value
5. If new: add entry in format `- **key**: value`
6. Write updated memory.md
7. Report success
```

#### 7. Configure Permissions

Create `.claude/settings.local.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(curl:*)",
      "WebFetch(domain:[allowed-domain.com])",
      "WebSearch"
    ]
  }
}
```

Configure permissions based on what your skills need (API calls, web fetches, file operations, etc.).

### After Setup

Once complete, report to the user:

**Skill Discovery pattern is ready!**

You can now:
- Invoke the subagent: `@"[agent-name] (agent)" [request]`
- The agent will discover available skills on each invocation
- Add new skills without modifying the agent definition
- Just create the skill and update `list-skills`

Current skills:
- `list-skills` - Skill discovery (always invoked first)
- `[prefix]-[skill-1]` - [Description]
- `[prefix]-[skill-2]` - [Description]
- (Memory skills if applicable)

To add a new skill:
1. Create `.claude/skills/[new-skill]/SKILL.md`
2. Add it to the `list-skills` skill registry
3. The agent will discover it on next invocation

Benefits of this pattern:
- Lower initial token cost (only list-skills is preloaded)
- Easy skill expansion (no agent definition changes needed)
- Clear capability boundaries (agent only does what's listed)