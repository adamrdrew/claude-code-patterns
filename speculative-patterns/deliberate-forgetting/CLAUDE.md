# Deliberate Forgetting Pattern

## Overview

This pattern demonstrates active memory management through intentional forgetting. Rather than accumulating knowledge indefinitely, the system regularly prunes outdated, irrelevant, or superseded information. Forgetting is a feature, not a bug.

## Key Files

- `.claude/agents/curator.md` - Agent that manages memory lifecycle
- `.claude/skills/prune-memory/SKILL.md` - Remove outdated entries
- `.claude/skills/archive-stale/SKILL.md` - Move old entries to archive
- `.claude/skills/review-relevance/SKILL.md` - Assess if entries are still useful
- `memory/` - Active memory entries
- `archive/` - Archived (forgotten) entries

## How It Works

1. Memory entries are stored with metadata (date, context, last-used)
2. Periodically run `review-relevance` to assess entries
3. Mark entries as active, stale, or obsolete
4. Use `prune-memory` to remove obsolete entries
5. Use `archive-stale` to preserve-but-forget stale entries

## The Forgetting Cycle

```
Accumulate → Review → Classify → Prune/Archive → Leaner Memory
```

## Philosophy

Most knowledge systems only accumulate. Over time they become:
- Bloated (too much to process)
- Stale (outdated information)
- Contradictory (old and new don't agree)
- Noisy (signal lost in volume)

Deliberate Forgetting addresses this:
- **Prune the obsolete**: Information that's no longer true
- **Archive the stale**: Information not currently relevant
- **Preserve the vital**: Information still actively useful
- **Document the forgetting**: Know what you forgot and why

## Memory Structure

```
memory/
├── index.md              # Index of active memory
├── project-context.md    # Current project state
├── decisions.md          # Active decisions
└── preferences.md        # User preferences

archive/
├── index.md              # Index of archived items
├── 2024-01/              # Archived by date
│   └── old-project.md
└── forgotten.log         # Log of what was forgotten
```

## Memory Entry Format

Each memory entry includes metadata:

```markdown
# [Entry Title]
**Created:** [date]
**Last Used:** [date]
**Context:** [when this applies]
**Expires:** [date or "never"]

## Content
[The actual information]

## Relevance Signals
- [What would indicate this is still relevant]
- [What would indicate this is stale]
```

## Usage

```bash
# Review all memory entries for relevance
@"curator (agent)" Review the current memory for staleness

# Prune entries marked obsolete
@"curator (agent)" Prune obsolete entries from memory

# Archive stale entries
@"curator (agent)" Archive entries that haven't been used in 30 days
```

## Forgetting Criteria

Entries become candidates for forgetting when:
- **Time-based**: Not used in N days
- **Superseded**: Newer information replaces it
- **Context-lost**: The context it applied to no longer exists
- **Contradicted**: It conflicts with current truth

## Available Skills

- **review-relevance** - Assess memory entries for current usefulness
- **prune-memory** - Remove obsolete entries
- **archive-stale** - Move stale entries to archive

## The Archive

Archived entries aren't truly deleted—they're moved to `archive/` with:
- Original content preserved
- Reason for archival noted
- Date of archival recorded
- Searchable if needed later

## Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
