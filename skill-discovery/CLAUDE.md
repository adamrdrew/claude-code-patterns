# Skill Discovery Pattern

## Overview

This pattern demonstrates dynamic skill discovery for subagents. Skills are discovered on-demand rather than injected into context at invocation time, reducing token overhead.

## Key Files

- `.claude/skills/list-skills/SKILL.md` - Master list of all available skills
- `.claude/agents/weather-buddy.md` - Example subagent that uses skill discovery

## Skill Maintenance

**Important:** When adding new skills or observing new skills in the `.claude/skills/` directory, always update the `list-skills` skill (`.claude/skills/list-skills/SKILL.md`) to include the new skill's name and description. This keeps the skill discovery system current.

## Available Skills

See `.claude/skills/list-skills/SKILL.md` for the complete list of available skills.

## Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation with skill preloading info
- [Claude Code settings](https://code.claude.com/docs/en/settings) - Configuration reference
