# Dialectic Agents Pattern

## Overview

This pattern demonstrates structured disagreement between agents to surface assumptions and produce better outcomes. Multiple agents with opposing mandates debate a topic, then an arbiter synthesizes the strongest position.

## Key Files

- `.claude/agents/advocate.md` - Argues for the proposed approach (thesis)
- `.claude/agents/critic.md` - Argues against, finds weaknesses (antithesis)
- `.claude/agents/arbiter.md` - Synthesizes the debate into a decision (synthesis)

## How It Works

1. User presents a question, proposal, or decision
2. Invoke the `debate-initiate` skill to structure the debate
3. Advocate agent builds the strongest case FOR
4. Critic agent builds the strongest case AGAINST
5. Arbiter agent synthesizes both positions into a reasoned conclusion
6. Result captures the tension, not just consensus

## The Dialectic Process

```
Thesis (Advocate)  +  Antithesis (Critic)  →  Synthesis (Arbiter)
```

This pattern is valuable when:
- Evaluating architectural decisions
- Reviewing code approaches
- Assessing risk/reward tradeoffs
- Stress-testing assumptions

## Usage

```bash
# Full dialectic process
@"arbiter (agent)" Should we use a microservices architecture for this project?

# Just get the opposing view
@"critic (agent)" Here's my plan to refactor the auth system: [plan]

# Strengthen a weak argument
@"advocate (agent)" Make the strongest case for using MongoDB here
```

## Philosophy

Single-agent systems have blind spots. By structuring disagreement, we:
- Surface hidden assumptions
- Explore the full solution space
- Avoid premature consensus
- Produce more robust decisions

The goal is not to find "who wins" but to understand the full landscape of a decision.

## Available Skills

- **debate-initiate** - Structure a topic for dialectic analysis
- **debate-synthesize** - Combine opposing positions into conclusion

## Further Reading

- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Official Claude Code subagents documentation
- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - How to create and use skills
