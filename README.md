# ⚙️ Claude Code Design Patterns

We have established design patterns in software engineering. We're just starting to discover them for AI Augmented engineering. Like classic Design Patterns, AI design patterns should be general approaches that provide concrete benefits that we can apply in different projects to solve common issues. This repo gathers together some of the design patterns I've discovered.

## 🏆 Attribution
These design patterns are ones that I've *"discovered."* This doesn't mean I'm the first person to ever think of them—likely not. But it does mean I reasoned my way into them independently without knowledge of anyone else applying them. This is why I say *"discovered"* and not *"invented."* I'm happy to add links to other design patterns, or different flavors of these ones that others have discovered independently. 

## 🛠️ Using this Repo
Each directory in this repo is for a different design pattern. Each is its own Claude Code directory with its own `.claude` directory and `CLAUDE.md`. To explore and play with a design pattern run Claude Code from within its directory, not in this outer parent directory.

##  👇 The Design Patterns

### 🎓 Agent Skill Creation
You can build agents that augment their own abilities by creating skills as they discover what works and what doesn't. This is a great way to create a simple and light-weight self reinforcing system that improves as you use it.

You should exercise caution with this pattern, and keep tabs on what skills your agent is giving itself. That said, it can be a great way to create agents that improve over time.

*Tip: Combine this with Skill Discovery to allow for skill growth while keeping token overhead low!*

[Agent Skill Creation Demo](agent-skill-creation/README.md)

### 📚 Knowledge Hooks
You can use hooks to front-load an agent with knowledge. This is a great way to augment what an agent knows on invocation. This is much cheaper cost/token-wise than having the agent go out and get knowledge, and it is more deterministic.

[Knowledge Hooks Demo](knowledge-hooks/README.md)

### 📋 Procedural Skills
Agents are great at working autonomously, solving problems, and getting things done. But sometimes you want to have an agent do something in a more deterministic, procedural way. The Procedural Skills pattern lets you trade some autonomy for some determinism. It will never be as deterministic as classic code, but it can come darn close, while still giving you the flexibility of working with an AI agent.

[Procedural Skills Demo](procedural-skills/README.md)

### 🔭 Skill Discovery
Claude Code subagents do not inherit the skill manifest from the parent conversation; they have to be made aware of what skills are available and what they do. The Skill Discovery pattern gives your agents a dynamic way to discover skills while also being frugal about tokens and cost.

[Skill Discovery Demo](skill-discovery/README.md)