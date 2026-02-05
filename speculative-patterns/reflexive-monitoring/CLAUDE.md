# Reflexive Monitoring Pattern

## Overview

This pattern demonstrates agents that monitor and evaluate their own behavior. Using hooks, the system can pause after actions to assess whether they were appropriate and inject course corrections.

## Key Files

- `.claude/agents/thoughtful-coder.md` - An agent that reflects on its actions
- `.claude/hooks/reflect-after-edit.sh` - Hook that triggers reflection after edits
- `.claude/settings.json` - Hook configuration

## How It Works

1. Agent performs an action (e.g., edits a file)
2. `PostToolUse` hook fires for matching operations
3. Hook evaluates the action and its context
4. Hook injects reflection as `additionalContext`
5. Agent receives feedback and can adjust course

## The Reflection Cycle

```
Action → Hook Fires → Evaluate → Inject Feedback → Continue (or Reconsider)
```

## Philosophy

Current agentic patterns assume forward momentum—each action leads to the next. Reflexive Monitoring introduces *self-doubt as a feature*. After significant actions, the agent pauses to ask:

- Did I do what I intended?
- Is this consistent with my constraints?
- Should I continue on this path?

This isn't approval-gating (blocking actions before they happen). It's post-action reflection that can surface course corrections.

## Usage

```bash
# The thoughtful-coder reflects after each edit
@"thoughtful-coder (agent)" Refactor the authentication module

# The agent will pause after edits to consider:
# - Was this edit consistent with my approach?
# - Did I introduce any issues?
# - Should I reconsider my direction?
```

## Available Skills

- **reflect-on-action** - Structured reflection on a recent action
- **skills-list** - List available skills

## Configuration

The reflection hook is configured in `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": { "tool_name": "Edit" },
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/reflect-after-edit.sh"
          }
        ]
      }
    ]
  }
}
```

## Tuning Reflection

The reflection hook can be tuned:
- **Frequency**: Reflect after every edit, or only after N edits
- **Depth**: Quick sanity check vs. deep analysis
- **Threshold**: Only reflect when changes exceed a certain size

## Further Reading

- [Hooks reference](https://code.claude.com/docs/en/hooks) - Official Claude Code hooks documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
