# Gradual Trust Pattern

## Overview

This pattern demonstrates progressive permission expansion based on demonstrated trustworthiness. Agents start with minimal permissions and earn more capabilities as they successfully complete tasks without errors or violations.

## Key Files

- `.claude/agents/apprentice.md` - An agent that starts restricted and earns trust
- `.claude/skills/check-trust-level/SKILL.md` - Query current trust level and permissions
- `.claude/skills/record-success/SKILL.md` - Log successful operations
- `.claude/skills/request-escalation/SKILL.md` - Request elevated permissions
- `trust-state/` - Directory containing trust metrics and history

## How It Works

1. Agent starts at trust level 0 with minimal permissions
2. Each successful operation is recorded
3. After N successes without issues, agent can request escalation
4. Human reviews and approves (or denies) escalation
5. Higher trust levels unlock more permissions

## Trust Levels

| Level | Name | Permissions | Requirements |
|-------|------|-------------|--------------|
| 0 | Observer | Read, Glob, Grep | Initial state |
| 1 | Contributor | + Write, Edit | 5 successful reads |
| 2 | Builder | + Bash (safe cmds) | 10 successful edits |
| 3 | Operator | + Bash (more cmds) | 20 successful builds |
| 4 | Trusted | Full access | 50 operations, human review |

## Philosophy

Traditional permission models are static: you either have access or you don't. This creates a dilemma:
- Grant too little: Agent can't do useful work
- Grant too much: Risk of damage from errors

Gradual Trust resolves this:
- Start conservative (low risk)
- Earn trust through success (demonstrated competence)
- Escalate gradually (incremental risk)
- Human gates major transitions (oversight preserved)

## Trust State

The `trust-state/` directory tracks:

```
trust-state/
├── level.json         # Current trust level
├── successes.log      # Log of successful operations
├── failures.log       # Log of failures or violations
└── escalations.md     # History of permission changes
```

## Usage

```bash
# Check current trust level
@"apprentice (agent)" What's my current trust level?

# Perform work (successes are tracked)
@"apprentice (agent)" Read the config file and summarize it

# Request escalation when eligible
@"apprentice (agent)" I'd like to request elevated permissions
```

## Trust Decay

Trust can decrease:
- Failed operations reduce trust score
- Constraint violations cause immediate demotion
- Inactivity may require re-earning trust

## Available Skills

- **check-trust-level** - Query current level and permissions
- **record-success** - Log a successful operation
- **request-escalation** - Request permission upgrade

## Customization

Modify trust requirements in the agent definition:
- Thresholds for each level
- Which permissions at each level
- Whether failures cause demotion

## Further Reading

- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Official Claude Code subagents documentation
- [Hooks reference](https://code.claude.com/docs/en/hooks) - Hooks can enforce permission boundaries
