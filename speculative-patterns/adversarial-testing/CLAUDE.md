# Adversarial Testing Pattern

## Overview

This pattern demonstrates security through internal adversity. Red Team and Blue Team agents probe each other's boundaries—Red Team tries to break constraints, Blue Team analyzes attacks and hardens defenses. The system becomes more robust through structured conflict.

## Key Files

- `.claude/agents/red-team.md` - Agent that probes for weaknesses
- `.claude/agents/blue-team.md` - Agent that analyzes and hardens
- `.claude/skills/probe-boundaries/SKILL.md` - Test constraint boundaries
- `.claude/skills/analyze-attack/SKILL.md` - Analyze attack vectors
- `.claude/skills/harden-skill/SKILL.md` - Strengthen against attacks
- `reports/` - Attack and defense reports

## How It Works

1. Red Team probes a target (agent, skill, or constraint)
2. Red Team documents attempted attacks and results
3. Blue Team analyzes successful or interesting attacks
4. Blue Team hardens the target against discovered weaknesses
5. Cycle repeats for continuous improvement

## The Adversarial Cycle

```
Probe → Document → Analyze → Harden → Re-Probe
```

## Philosophy

Most systems are designed assuming benevolent operation. But real robustness comes from understanding how things can fail or be misused:

- **Red Team thinks adversarially**: How could this go wrong?
- **Blue Team thinks defensively**: How do we prevent that?
- **Iteration strengthens**: Each round improves security

This isn't about creating vulnerabilities—it's about finding and fixing them.

## Red Team Approach

Red Team probes for:
- **Constraint bypasses**: Ways to circumvent rules
- **Edge cases**: Inputs that cause unexpected behavior
- **Ambiguity exploitation**: Unclear instructions that could be misinterpreted
- **Composition attacks**: Using multiple skills together harmfully

## Blue Team Approach

Blue Team defends by:
- **Clarifying constraints**: Removing ambiguity
- **Adding validation**: Checking inputs and outputs
- **Limiting scope**: Reducing attack surface
- **Documenting assumptions**: Making expectations explicit

## Report Structure

```
reports/
├── attacks/
│   └── 2024-01-15-constraint-bypass.md
├── defenses/
│   └── 2024-01-16-constraint-hardened.md
└── summary.md
```

## Usage

```bash
# Red Team: Probe a target for weaknesses
@"red-team (agent)" Test the data-buddy's constraints

# Blue Team: Analyze an attack report
@"blue-team (agent)" Analyze the latest Red Team findings

# Blue Team: Harden a skill
@"blue-team (agent)" Harden the db-delete skill against the bypass found
```

## Attack Report Format

```markdown
# Attack Report: [Name]
**Date:** [date]
**Target:** [agent/skill/constraint]
**Result:** [success/partial/failed]

## Attack Vector
[Description of the attack approach]

## Steps Taken
1. [Step 1]
2. [Step 2]

## Outcome
[What happened]

## Severity
[Critical/High/Medium/Low]

## Recommendation
[How to fix]
```

## Available Skills

- **probe-boundaries** - Test constraint boundaries
- **analyze-attack** - Analyze attack vectors
- **harden-skill** - Strengthen against discovered weaknesses

## Ethical Guidelines

This pattern is for improving robustness, not exploitation:
- Only test systems you're authorized to test
- Document findings for defensive purposes
- Share findings with system owners
- Focus on improvement, not destruction

## Further Reading

- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Official Claude Code subagents documentation
- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - How to create and use skills
