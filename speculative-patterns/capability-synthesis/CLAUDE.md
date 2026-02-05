# Capability Synthesis Pattern

## Overview

This pattern demonstrates emergent skill creation through composition observation. The system notices when skills are frequently used together and proposes new composite skills that combine them. Skills evolve not just through explicit creation but through observed usage patterns.

## Key Files

- `.claude/agents/synthesizer.md` - Agent that observes patterns and proposes new skills
- `.claude/skills/observe-composition/SKILL.md` - Track skill co-occurrence
- `.claude/skills/propose-skill/SKILL.md` - Generate composite skill proposals
- `observations/` - Directory containing composition observations

## How It Works

1. Track when skills are invoked together (via hooks or manual logging)
2. Identify frequent co-occurrence patterns
3. Propose new skills that combine frequently-paired skills
4. Review and adopt successful compositions

## The Synthesis Cycle

```
Use Skills → Observe Patterns → Identify Compositions → Propose New Skill → Adopt
```

## Philosophy

Skill Discovery finds existing skills. Skill Creation makes new ones deliberately. But what about skills that *emerge* from how existing skills are used?

Capability Synthesis watches for idioms:
- "Whenever I fetch data, I also validate it"
- "Every time I write to the database, I update the index"
- "I always check constraints before deleting"

These patterns suggest composite skills waiting to be born:
- `fetch-and-validate`
- `write-with-index`
- `safe-delete`

The system notices its own idioms and proposes codifying them.

## Observation Format

Observations are logged in `observations/log.md`:

```markdown
## Observation: 2024-01-15 14:30

**Skills invoked:**
1. db-read (topic: users)
2. validate-schema
3. transform-output

**Context:** User query about user data

**Pattern:** Read → Validate → Transform

---
```

## Usage

```bash
# Log a composition observation
@"synthesizer (agent)" I just used db-read, then validate, then transform

# Analyze patterns and propose new skills
@"synthesizer (agent)" What compositions have emerged from our usage patterns?

# Create a proposed composite skill
@"synthesizer (agent)" Create the fetch-and-validate skill we discussed
```

## Available Skills

- **observe-composition** - Log skill co-occurrence for later analysis
- **propose-skill** - Analyze patterns and propose composite skills
- **skills-list** - List available skills

## When to Synthesize

Good candidates for synthesis:
- Skills used together > 3 times
- Skills always used in the same order
- Skills that share inputs/outputs naturally

Poor candidates:
- Coincidental co-occurrence
- Skills with different purposes
- Complex, branching workflows

## Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
