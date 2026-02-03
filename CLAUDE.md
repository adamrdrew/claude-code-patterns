# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a collection of AI-augmented engineering design patterns for Claude Code. Each directory contains a standalone pattern with its own `.claude` configuration. Run Claude Code from within a pattern directory to explore it, not from this parent directory.

## The Four Design Patterns

1. **Agent Skill Creation** (`agent-skill-creation/`) - Agents that augment their own abilities by creating skills as they discover effective approaches. Self-reinforcing system that improves over time.

2. **Knowledge Hooks** (`knowledge-hooks/`) - Front-load agents with knowledge via hooks on invocation. More token-efficient and deterministic than dynamic knowledge fetching.

3. **Procedural Skills** (`procedural-skills/`) - Trade autonomy for determinism. Skills execute in structured, procedural ways using TodoWrite for step-by-step execution.

4. **Skill Discovery** (`skill-discovery/`) - Dynamic skill discovery for subagents, since Claude Code subagents don't inherit parent skill manifests.

## Architecture

### Agent Definitions (`.claude/agents/*.md`)
- YAML frontmatter: `name`, `description`, `skills`, `tools`, `color`
- Markdown body contains the agent prompt
- `skills` array lists which skills the agent can invoke
- `tools` specifies available Claude Code tools (Skill, Read, Bash, TodoWrite, Edit)

### Skills (`.claude/skills/<skill-name>/SKILL.md`)
- YAML frontmatter: `name`, `description`
- Markdown body contains procedural instructions
- Use TodoWrite format for deterministic step-by-step execution
- Skills can invoke other skills via the Skill tool

### Permission Model (`.claude/settings.local.json`)
- Root level has restricted permissions
- Pattern directories have their own permission scopes tailored to their needs
- Pattern: principle of least privilege per context

## Key Conventions

- **Skill naming**: Pattern-specific prefix (e.g., `buddy-` for System Buddy agent)
- **Skill registration**: New skills must be added to `skills-list/SKILL.md`
- **Generated skills**: Dynamically created skills are gitignored (e.g., `.claude/skills/buddy*`)
- **Meta-skills**: `skill-create` and `skills-list` are infrastructure skills for self-improvement
