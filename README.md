# ⚙️ Claude Code Design Patterns

Design patterns for AI-augmented engineering with Claude Code. Like classic software design patterns, these are reusable approaches that solve common problems when building subagents and skills.

## ✅ Prerequisites

Before diving in, you should have:
- **Claude Code installed and working** — you can run `claude` and have conversations
- **Basic familiarity with Claude Code** — you've used tools, read files, run commands
- **Comfort with Markdown and YAML** — the configuration formats used throughout

## 🧑‍🏫 Using This Repo

Each directory contains a standalone design pattern with its own `.claude` configuration.

**Important:** Run Claude Code from within a pattern directory, not this parent directory.

```bash
cd knowledge-hooks
claude
```

You'll find a README.md for each pattern that goes over how it works, how to apply it, further reading, and more. Follow along with the each tutorial, interact with the agents and skills, and get an idea of how they hang together and how you might apply them.

If you find a pattern you'd like to use look for the link to the `teach-claude.md` for that pattern. Paste a link to the `teach-claude.md` for the design pattern you want to use and Claude will get your project wired up for it. I suggest you do it on a branch, just in case after applying it the pattern doesn't seem like a great fit or Claude messed something up.

**Recommended starting points:**
- **Knowledge Hooks** — Most self-contained, demonstrates hooks clearly
- **Procedural Skills** — Shows how to make agents follow exact procedures

## 🛠️ Foundation Patterns

### 🪝 Knowledge Hooks
Front-load subagents with knowledge via hooks on invocation. More token-efficient and deterministic than runtime fetching.

→ [Knowledge Hooks](knowledge-hooks/README.md)

### 📋 Procedural Skills
Trade autonomy for determinism. Skills execute step-by-step using Task tools (`TaskCreate`, `TaskUpdate`, `TaskList`) to enforce execution order.

→ [Procedural Skills](procedural-skills/README.md)

### 🔭 Skill Discovery
Dynamic skill discovery for subagents. Claude Code subagents don't inherit skill manifests from the parent conversation — this pattern solves that efficiently.

→ [Skill Discovery](skill-discovery/README.md)

### 📚 Subagent Skill Creation
Subagents that augment their own abilities by creating skills as they learn. A self-reinforcing system that improves over time.

**Caution:** Review the skills your subagent creates. Combine with Skill Discovery for growth without token overhead.

→ [Subagent Skill Creation](agent-skill-creation/README.md)

## 🔮 Speculative Patterns

Beyond the foundation patterns, this repo includes **10 experimental patterns** that explore what's possible when you treat Claude Code as a platform for implementing theories about how AI systems should operate.

These patterns emerged from a structured exploration: analyzing the foundation patterns to extract underlying principles, studying Claude Code's architecture, and asking "what other patterns might be possible?" They implement ideas like structured disagreement, self-reflection, natural selection, progressive trust, and deliberate friction.

**Status:** These patterns have not yet been validated in real projects. They represent promising ideas that need testing before being considered production-ready.

| Pattern | Core Idea |
|---------|-----------|
| **Dialectic Agents** | Opposing agents debate to surface assumptions |
| **Reflexive Monitoring** | Agents watch themselves via hooks |
| **Evolutionary Skills** | Skills compete, winners get promoted |
| **Constraint Inheritance** | Governance flows from parent to child |
| **Session Archaeology** | Cross-session learning through distilled experience |
| **Capability Synthesis** | Observe skill co-occurrence, propose composites |
| **Gradual Trust** | Earn permissions through demonstrated competence |
| **Deliberate Forgetting** | Prune stale knowledge to stay lean |
| **Adversarial Testing** | Red/Blue teams probe and harden |
| **Ceremony Patterns** | Deliberate friction for high-stakes actions |

→ [Speculative Patterns](speculative-patterns/README.md)

## 🔗 Combining Patterns

These patterns complement each other:

- **Skill Creation + Skill Discovery** — Growth with low token overhead
- **Constraint Inheritance + Adversarial Testing** — Governance with continuous hardening
- **Session Archaeology + Deliberate Forgetting** — Learning that stays lean
- **Dialectic Agents + Ceremony Patterns** — High-stakes decisions with full deliberation
- **Gradual Trust + Constraint Inheritance** — Earned capabilities within governance bounds

## 🏆 Attribution

The **foundation patterns** are ones I've *"discovered."* This doesn't mean I'm the first person to think of them — likely not. But I reasoned my way into them independently.

The **speculative patterns** emerged from asking: what else is possible when you treat Claude Code as a platform for implementing theories about how AI systems should operate? They explore ideas like structured disagreement, self-reflection, natural selection, and deliberate friction.

I'm happy to add links to other design patterns or variations that others have discovered. These patterns resemble well-known ideas in software engineering, cognitive science, and organizational theory — what's interesting is applying them specifically to Claude Code.