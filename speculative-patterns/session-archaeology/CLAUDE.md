# Session Archaeology Pattern

## Overview

This pattern demonstrates cross-session learning by mining previous session transcripts for patterns, failures, and successes. Rather than starting fresh each session, agents begin with distilled wisdom from past interactions.

## Key Files

- `.claude/agents/archaeologist.md` - Agent that mines sessions for insights
- `.claude/hooks/inject-learnings.sh` - Hook that injects learnings at session start
- `.claude/skills/extract-learnings/SKILL.md` - Distill insights from session transcripts
- `.claude/skills/apply-learnings/SKILL.md` - Apply past learnings to current work
- `learnings/` - Directory containing distilled learnings

## How It Works

1. After sessions, run `extract-learnings` to analyze transcripts
2. Learnings are distilled and saved to `learnings/`
3. On new session start, hook injects relevant learnings
4. Agent begins with institutional knowledge, not blank slate

## The Archaeology Cycle

```
Session Ends → Extract Learnings → Store → New Session → Inject Learnings
```

## Philosophy

Each Claude Code session starts fresh—no memory of previous sessions. This is by design (privacy, context limits). But organizations accumulate knowledge. The same mistakes get made. The same solutions get rediscovered.

Session Archaeology bridges this gap:
- **Extract**: After work, distill what was learned
- **Store**: Save learnings in structured format
- **Inject**: Surface relevant learnings at session start
- **Apply**: Use past wisdom to guide current work

This isn't raw transcript replay—it's *distilled experience*.

## Learnings Structure

```
learnings/
├── index.md              # Master index of all learnings
├── patterns/             # Successful patterns discovered
│   └── auth-refactor.md
├── failures/             # Mistakes to avoid
│   └── db-migration-fail.md
└── insights/             # General insights
    └── testing-approach.md
```

## Learning Format

Each learning follows this structure:

```markdown
# [Title]
**Type:** pattern | failure | insight
**Context:** [When this applies]
**Date:** [When discovered]

## Summary
[One paragraph summary]

## Details
[Full explanation]

## Application
[How to apply this learning]
```

## Usage

```bash
# Extract learnings from recent work
@"archaeologist (agent)" What did we learn from today's session?

# Apply learnings to new work
@"archaeologist (agent)" What past learnings apply to this auth refactor?

# The hook automatically injects relevant learnings on session start
```

## Available Skills

- **extract-learnings** - Analyze work and distill key learnings
- **apply-learnings** - Find and apply relevant past learnings
- **skills-list** - List available skills

## Configuring the Hook

The injection hook is configured in `.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/inject-learnings.sh"
          }
        ]
      }
    ]
  }
}
```

## Further Reading

- [Hooks reference](https://code.claude.com/docs/en/hooks) - Official Claude Code hooks documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
