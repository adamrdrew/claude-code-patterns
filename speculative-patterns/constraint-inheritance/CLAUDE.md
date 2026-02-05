# Constraint Inheritance Pattern

## Overview

This pattern demonstrates hierarchical constraints that flow from parent agents to child agents. Constraints are defined once at a governance level and automatically apply to all descendant agents, creating organizational policy without repetition.

## Key Files

- `.claude/agents/guardian.md` - Top-level agent defining organizational constraints
- `.claude/agents/worker.md` - Child agent that inherits guardian constraints
- `.claude/constraints/` - Constraint definition files
- `.claude/skills/check-constraints/SKILL.md` - Verify constraint compliance

## How It Works

1. Define constraints in `.claude/constraints/<name>.md`
2. Guardian agent loads and enforces all constraints
3. Worker agents declare they inherit from guardian
4. Before any action, workers check against inherited constraints
5. Violations are blocked or flagged

## Constraint Hierarchy

```
Organization Constraints (constraints/*.md)
         ↓
   Guardian Agent (loads all constraints)
         ↓
   Worker Agent (inherits guardian's constraints)
         ↓
   Action (checked against constraints)
```

## Philosophy

Current patterns define constraints per-agent. This leads to:
- Repetition across agents
- Inconsistency when constraints are updated
- No clear governance structure

Constraint Inheritance centralizes policy:
- Define once, apply everywhere
- Update in one place, effect everywhere
- Clear hierarchy of authority

## Constraint Definition

Constraints are defined in `.claude/constraints/`:

```markdown
# constraint: no-delete-without-backup
severity: block
applies_to: all

## Description
Never delete files or data without first creating a backup.

## Check
Before any delete operation:
1. Verify a backup exists, OR
2. Create a backup first

## Violation Response
Block the operation and report the violation.
```

## Usage

```bash
# Guardian enforces all constraints
@"guardian (agent)" Review this file deletion request

# Worker inherits guardian's constraints
@"worker (agent)" Delete the old log files
# Worker checks constraints before acting
```

## Constraint Types

### Block Constraints
Prevent actions entirely if violated.

### Warn Constraints
Allow actions but log/report the violation.

### Audit Constraints
Allow actions, record for later review.

## Available Skills

- **check-constraints** - Verify an action complies with inherited constraints
- **skills-list** - List available skills

## Extending the Hierarchy

Create deeper hierarchies by having agents inherit from other agents:

```
guardian (org-wide constraints)
    ├── data-guardian (data-specific constraints)
    │   └── data-worker (inherits both)
    └── code-guardian (code-specific constraints)
        └── code-worker (inherits both)
```

## Further Reading

- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Official Claude Code subagents documentation
- [Hooks reference](https://code.claude.com/docs/en/hooks) - Hooks can also enforce constraints
