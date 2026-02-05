# Ceremony Patterns

## Overview

This pattern demonstrates deliberate friction for high-stakes operations. Rather than making everything fast and easy, certain operations are wrapped in ceremony—rituals that slow down, require confirmation, and create audit trails. The weight of the action is felt.

## Key Files

- `.claude/agents/executor.md` - Agent that performs ceremonial operations
- `.claude/skills/ceremony-delete/SKILL.md` - Ritualized deletion process
- `.claude/skills/ceremony-deploy/SKILL.md` - Ritualized deployment process
- `.claude/skills/witness-action/SKILL.md` - Record witnessing of an action
- `ceremony-log/` - Audit log of ceremonial actions

## How It Works

1. Certain high-stakes operations require ceremony
2. Ceremony involves: witness, wait, confirm, execute, record
3. Each step must complete before the next
4. Full audit trail is maintained
5. The process forces deliberation

## The Ceremony

```
Witness → Wait → Confirm → Execute → Record
```

### Witness
Someone (or something) must witness the intent. This creates accountability.

### Wait
A mandatory pause. Time to reconsider. Cannot be skipped.

### Confirm
Explicit re-confirmation after the wait. "Yes, I still want to do this."

### Execute
Only now does the action occur.

### Record
Full documentation of what happened, who witnessed, and why.

## Philosophy

Some actions are irreversible. Some have serious consequences. Making them too easy is a design flaw, not a feature:

- **Friction is a feature**: The inconvenience is the point
- **Weight matters**: Serious actions should feel serious
- **Records protect**: Audit trails help everyone
- **Pauses prevent regret**: Forced reflection catches mistakes

## When to Use Ceremony

Good candidates for ceremony:
- Deleting production data
- Deploying to production
- Changing permissions
- Modifying security settings
- Any irreversible action

Not needed for:
- Read-only operations
- Easily reversible changes
- Low-stakes modifications

## Ceremony Configuration

Each ceremonial skill defines:
- **Wait duration**: How long to pause (seconds)
- **Confirmation phrase**: What must be typed to confirm
- **Witness requirement**: Whether witness is needed
- **Audit level**: How much to record

## Usage

```bash
# Delete with ceremony
@"executor (agent)" Ceremonially delete the old user database

# Deploy with ceremony
@"executor (agent)" Deploy version 2.0 to production

# Record a witness action
@"executor (agent)" Witness this configuration change
```

## Ceremony Log

All ceremonial actions are recorded in `ceremony-log/`:

```
ceremony-log/
├── index.md           # Summary of all ceremonies
└── 2024-01-15-delete.md  # Individual ceremony records
```

## Available Skills

- **ceremony-delete** - Ritualized deletion with full ceremony
- **ceremony-deploy** - Ritualized deployment with full ceremony
- **witness-action** - Record witnessing of high-stakes action

## Example Ceremony

```markdown
# Ceremony Record: Database Deletion

**Date:** 2024-01-15 14:30:00
**Action:** Delete user-archive database
**Requested By:** user
**Witnessed By:** executor agent

## Intent
User requested deletion of user-archive database
to free up storage space.

## Wait Period
60 seconds (14:30:00 - 14:31:00)
No cancellation received.

## Confirmation
User confirmed with phrase: "I understand this is permanent"

## Execution
Database deleted at 14:31:05

## Outcome
Action completed successfully.
No data recovery possible.

---
*This action was performed with full ceremony.*
```

## Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
