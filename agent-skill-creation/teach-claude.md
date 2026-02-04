# Teach Claude: Subagent Skill Creation Pattern

This prompt teaches Claude Code how to implement the **Subagent Skill Creation** pattern - a self-improving system where subagents create their own skills as they discover effective approaches.

---

## Prompt

I want you to set up a **Subagent Skill Creation** pattern in this project. This pattern allows a subagent to learn over time by codifying successful procedures into reusable skills.

### What This Pattern Does

- Creates a subagent that can invoke skills to accomplish tasks
- When the subagent discovers a novel approach, it creates a new skill
- Skills are stored as markdown files and added to a skills registry
- The system becomes more capable over time as the skill library grows

### Setup Instructions

#### 1. Add to CLAUDE.md

Add these instructions to the project's CLAUDE.md file:

```markdown
## Subagent Skill Creation Pattern

This project uses the Subagent Skill Creation pattern. The `[agent-name]` subagent can create new skills when it discovers effective approaches.

### Invoking the Subagent
Use: `@"[agent-name] (agent)" [your request]`

### How Skills Work
- Skills are stored in `.claude/skills/[skill-name]/SKILL.md`
- The `skills-list` skill contains a registry of all available skills
- The `skill-create` meta-skill guides creation of new skills
- When a new skill is created, `skills-list` MUST be updated

### Skill Naming Convention
All skills for this subagent use the prefix `[prefix]-` (e.g., `[prefix]-check-status`)
```

#### 2. Create Directory Structure

```
.claude/
├── agents/
│   └── [agent-name].md
├── skills/
│   ├── skill-create/
│   │   └── SKILL.md
│   └── skills-list/
│       └── SKILL.md
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
  - Read
  - Bash
  - TodoWrite
skills:
  - skills-list
color: green
---
```

Then add the agent prompt in markdown below the frontmatter. The prompt should include:

- **Role description**: What the agent does
- **Operating Rules**: Safety constraints (never delete data, never compromise stability, etc.)
- **Operating Procedure**:
  1. List current skills using `skills-list`
  2. If a skill exists for the task, use it
  3. If no skill exists, figure out how to accomplish the task
  4. If successful, create a new skill using `skill-create`
- **Critical Rule**: Always create a skill when discovering a novel approach

#### 4. Create the skill-create Meta-Skill

Create `.claude/skills/skill-create/SKILL.md`:

```yaml
---
name: skill-create
description: Create a new skill and add it to the skills registry
---
```

The skill body should guide the agent through:
1. Choose a skill name with the correct prefix
2. Write a clear name and description
3. Create the skill file at `.claude/skills/[skill-name]/SKILL.md`
4. Define the skill procedure using numbered steps or TodoWrite
5. **UPDATE skills-list** - Add the new skill to the registry

#### 5. Create the skills-list Skill

Create `.claude/skills/skills-list/SKILL.md`:

```yaml
---
name: skills-list
description: Lists all available skills for [agent-name]
---
```

The body should list all available skills with their names and one-line descriptions. This file must be manually updated whenever a new skill is created.

#### 6. Configure Permissions

Create `.claude/settings.local.json` with minimal permissions:

```json
{
  "permissions": {
    "allow": [
      "Bash(echo:*)",
      "Bash([specific-commands-for-your-domain]:*)"
    ]
  }
}
```

Only allow the specific bash commands your agent needs.

### After Setup

Once complete, report to the user:

**Subagent Skill Creation pattern is ready!**

You can now:
- Invoke the subagent: `@"[agent-name] (agent)" [request]`
- The agent will use existing skills when available
- For novel tasks, the agent will figure out a solution and create a new skill
- Skills accumulate over time, making the agent more capable

Current skills:
- `skill-create` - Meta-skill for creating new skills
- `skills-list` - Registry of all available skills

The agent will create domain-specific skills as you use it.