# Evolutionary Skills Pattern

## Overview

This pattern demonstrates skills that evolve through competition. Multiple versions of a skill coexist, compete on real tasks, and the most successful version gets promoted. The system improves through selection pressure rather than manual optimization.

## Key Files

- `.claude/agents/evolver.md` - Agent that manages skill evolution
- `.claude/skills/skill-compete/SKILL.md` - Run competing skill versions
- `.claude/skills/skill-promote/SKILL.md` - Promote a winning skill version
- `.claude/skills/fitness-eval/SKILL.md` - Evaluate skill fitness
- `arena/` - Directory containing competing skill versions and results

## How It Works

1. Create multiple versions of a skill (e.g., `format-v1`, `format-v2`)
2. Run both versions on the same task via `skill-compete`
3. Evaluate results with `fitness-eval`
4. Promote the winner with `skill-promote`
5. Repeat—evolution continues

## The Evolution Cycle

```
Variation → Competition → Selection → Promotion → (new Variation)
```

## Arena Structure

```
arena/
├── competitors/
│   ├── format-v1/SKILL.md     # Original version
│   └── format-v2/SKILL.md     # Challenger version
├── results/
│   └── format-2024-01-15.md   # Competition results
└── champions/
    └── format/SKILL.md         # Current best version
```

## Philosophy

Skills are typically static—once created, they stay the same. This pattern treats skills as living artifacts that evolve:

- **Variation**: Create alternatives to existing skills
- **Competition**: Run alternatives against each other
- **Selection**: Measure which performs better
- **Promotion**: Replace incumbent with superior version

This isn't random mutation—variations are intentional experiments. But selection is based on observed performance, not speculation.

## Usage

```bash
# Run a competition between skill versions
@"evolver (agent)" Compare format-v1 and format-v2 on this input: [input]

# Evaluate which version won
@"evolver (agent)" Which formatting approach worked better?

# Promote the winner
@"evolver (agent)" Promote format-v2 to champion
```

## Creating Variations

When creating a skill variation:

1. Copy the existing skill to `arena/competitors/<skill>-v<N>/`
2. Make your experimental change
3. Document what's different in the skill description
4. Run competition to evaluate

## Fitness Criteria

The `fitness-eval` skill evaluates on:

- **Correctness**: Did it produce the right output?
- **Clarity**: Is the output easy to understand?
- **Efficiency**: Did it use reasonable resources?
- **Robustness**: Does it handle edge cases?

## Available Skills

- **skill-compete** - Run competing skill versions on same input
- **skill-promote** - Promote a winning version to champion
- **fitness-eval** - Evaluate and compare skill outputs

## Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
