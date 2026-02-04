# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a collection of AI-augmented engineering design patterns for Claude Code. Each directory contains a standalone pattern with its own `.claude` configuration.

**Important:** Run Claude Code from within a pattern directory to explore it, not from this parent directory.

## The Four Design Patterns

1. **Agent Skill Creation** (`agent-skill-creation/`) - Agents that augment their own abilities by creating skills as they discover effective approaches. Self-reinforcing system that improves over time.

2. **Knowledge Hooks** (`knowledge-hooks/`) - Front-load agents with knowledge via hooks on invocation. More token-efficient and deterministic than dynamic knowledge fetching.

3. **Procedural Skills** (`procedural-skills/`) - Trade autonomy for determinism. Skills execute in structured, procedural ways using Task tools (TaskCreate, TaskUpdate) for step-by-step execution.

4. **Skill Discovery** (`skill-discovery/`) - Dynamic skill discovery for subagents, since Claude Code subagents don't inherit parent skill manifests.

## Architecture

### Agent Definitions (`.claude/agents/*.md`)
- YAML frontmatter: `name`, `description`, `skills`, `tools`, `color`
- Markdown body contains the agent prompt
- `skills` array lists which skills the agent can invoke (these are injected at invocation)
- `tools` specifies available Claude Code tools (Skill, Read, Bash, TaskCreate, TaskUpdate, Edit)

### Skills (`.claude/skills/<skill-name>/SKILL.md`)
- YAML frontmatter: `name`, `description`
- Markdown body contains procedural instructions
- Skills can invoke other skills via the Skill tool

### Procedural Skill Pattern
Skills use Task tools with numbered steps for deterministic execution:
```markdown
## Step 1: First Step
Instructions for step 1

## Step 2: Second Step
Instructions for step 2
```
The agent uses TaskCreate to create tasks for each step, then executes them in order using TaskUpdate to track progress.

### Permission Model (`.claude/settings.local.json`)
- Root level has restricted permissions (only `echo`, `find`)
- Pattern directories have their own permission scopes tailored to their needs
- Pattern: principle of least privilege per context

## Key Conventions

- **Skill naming**: Pattern-specific prefix (e.g., `buddy-` for System Buddy agent)
- **Skill list maintenance**: Each pattern has a meta-skill for listing available skills (`skills-list` or `list-skills`) that must be updated when adding new skills
- **Generated skills**: Dynamically created skills may be gitignored (e.g., `skill-discovery/memory.md`)
- **Meta-skills**: `skill-create` and `skills-list`/`list-skills` are infrastructure skills for self-improvement and discovery
- **Pattern-specific CLAUDE.md**: Individual patterns may have their own CLAUDE.md with pattern-specific instructions
