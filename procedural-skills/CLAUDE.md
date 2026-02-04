# Procedural Skills Pattern

## Overview

This pattern demonstrates procedural skill execution using Task tools (`TaskCreate`, `TaskUpdate`, `TaskList`). Skills define numbered steps that the subagent executes in order, trading autonomy for determinism.

## Key Files

- `.claude/agents/data-buddy.md` - Example subagent that uses procedural skills
- `.claude/skills/skills-list/SKILL.md` - Master list of all available skills

## Skill Maintenance

**Important:** When adding new skills, always update the `skills-list` skill (`.claude/skills/skills-list/SKILL.md`) to include the new skill's name and description.

## Database Structure

The `database/` directory (gitignored) contains:
- `index.md` - Index of all documents with links and descriptions
- `<topic>.md` - Individual documents storing information by topic

## Available Skills

See `.claude/skills/skills-list/SKILL.md` for the complete list of available skills.

## Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
- [How Claude Code works](https://code.claude.com/docs/en/how-claude-code-works) - Understanding Claude Code architecture

