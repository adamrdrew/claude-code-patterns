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

## 🛠️ The Design Patterns

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

## 🏆 Attribution

These design patterns are ones I've *"discovered."* This doesn't mean I'm the first person to think of them — likely not. But I reasoned my way into them independently. I'm happy to add links to other design patterns or variations that others have discovered.