# Agent Skill Creation Pattern

## Overview

This pattern demonstrates agents that create their own skills as they learn. The agent starts with a small skill library and grows it over time by codifying new procedures into reusable skills.

## Key Files

- `.claude/agents/system-buddy.md` - The self-improving agent
- `.claude/skills/skill-create/SKILL.md` - Meta-skill for creating new skills
- `.claude/skills/skills-list/SKILL.md` - Meta-skill listing available skills (must be updated when skills are added)

## How It Works

1. User invokes `@"system-buddy (agent)"` with a request
2. Agent checks `skills-list` to see what skills exist
3. Agent uses existing skills where applicable
4. For novel tasks, agent figures out how to accomplish them
5. Agent creates a new skill codifying what it learned
6. Future invocations can use the new skill directly

## Important Considerations

- **Review created skills** — Always check what your agent creates in `.claude/skills/`
- **Skill naming** — Skills use `buddy-` prefix for consistency
- **Skills-list maintenance** — The `skills-list` skill must be updated when new skills are created

## Available Skills

See `skills-list` for the current inventory. New skills are added dynamically.

## Note on TodoWrite

This pattern currently uses `TodoWrite` for task tracking. The newer approach uses `TaskCreate`/`TaskUpdate`/`TaskList`. Both work; Task tools are the current standard.
