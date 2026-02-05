# Speculative Patterns

Experimental design patterns for Claude Code that push beyond established approaches. These patterns explore what's possible when you treat Claude Code as a platform for implementing theories about how AI systems should operate.

## Status: Experimental

These patterns have **not yet been validated** in real projects. They represent promising ideas that emerged from analyzing Claude Code's architecture and capabilities, but they need investigation and testing before being considered production-ready.

**Use these patterns to:**
- Explore new possibilities
- Experiment with novel approaches
- Contribute improvements and learnings back

**Before using in production:**
- Test thoroughly in your specific context
- Validate that the pattern delivers value
- Be prepared to iterate or abandon if it doesn't work

## How These Patterns Were Developed

These patterns emerged from a structured exploration process:

1. **Analyze existing patterns** — We examined the four foundation patterns (Knowledge Hooks, Procedural Skills, Skill Discovery, Subagent Skill Creation) to understand the underlying principles and constraints they address.

2. **Study Claude Code documentation** — We reviewed the official documentation for hooks, skills, agents, MCP, permissions, and other extension points to understand what the platform exposes.

3. **Extract underlying concepts** — We identified the tensions each pattern resolves (autonomy vs. determinism, freshness vs. efficiency, growth vs. maintenance) and the design philosophies they embody.

4. **Generate new possibilities** — We asked: what other theories about AI system design could be implemented? What other tensions exist? What patterns might emerge from Claude Code's architecture?

5. **Implement as working code** — Each pattern was built with real agents, skills, hooks, and supporting infrastructure—not just documentation.

The prompt that initiated this exploration asked Claude to "read between the lines, unlock latent space, think about the subtext" of the existing patterns and imagine what other patterns might be possible when treating Claude Code as "a platform to be explored, to be understood, a platform where whatever isn't forbidden is possible."

---

## The Patterns

### Dialectic Agents
**Directory:** `dialectic-agents/`

Multiple agents with opposing mandates debate proposals to surface assumptions and produce better decisions.

| Agent | Role |
|-------|------|
| **Advocate** | Builds the strongest case FOR |
| **Critic** | Finds weaknesses, argues AGAINST |
| **Arbiter** | Synthesizes into a decision |

**Core idea:** Single-agent systems have blind spots. Structured disagreement surfaces hidden assumptions and explores the full solution space.

**Skills:** `debate-initiate`, `debate-synthesize`

---

### Reflexive Monitoring
**Directory:** `reflexive-monitoring/`

Agents that watch themselves via hooks. After significant actions, the system injects reflection prompts encouraging course correction.

**Core idea:** Current patterns assume forward momentum. Reflexivity introduces self-doubt as a feature—pausing after actions to ask "should I continue?"

**Key mechanism:** `PostToolUse` hook that injects reflection questions after edits.

**Skills:** `reflect-on-action`

---

### Evolutionary Skills
**Directory:** `evolutionary-skills/`

Skills compete for adoption through measured evaluation. Multiple versions run on the same input, fitness is scored, winners are promoted.

**Core idea:** Skills are typically static. This pattern treats them as living artifacts that evolve through variation, competition, and selection.

**Structure:**
```
arena/
├── competitors/    # Skill versions being tested
├── results/        # Competition records
└── champions/      # Current best versions
```

**Skills:** `skill-compete`, `fitness-eval`, `skill-promote`

---

### Constraint Inheritance
**Directory:** `constraint-inheritance/`

Hierarchical constraints flow from parent agents to child agents. Define governance once, apply everywhere.

**Core idea:** Per-agent constraint definition leads to repetition and inconsistency. Inheritance creates organizational policy that flows downward.

**Agents:**
- **Guardian** — Defines and enforces organizational constraints
- **Worker** — Inherits constraints, checks before risky actions

**Skills:** `check-constraints`

**Includes:** Example constraints (`no-delete-without-backup`, `no-credential-exposure`, `audit-config-changes`)

---

### Session Archaeology
**Directory:** `session-archaeology/`

Mine previous sessions for patterns, failures, and insights. Extract learnings after work, inject them at session start.

**Core idea:** Each session starts fresh. Archaeology bridges this gap by distilling and preserving institutional knowledge across sessions.

**Structure:**
```
learnings/
├── patterns/    # Successful approaches
├── failures/    # Mistakes to avoid
└── insights/    # Understanding gained
```

**Key mechanism:** `SessionStart` hook that injects recent learnings.

**Skills:** `extract-learnings`, `apply-learnings`

---

### Capability Synthesis
**Directory:** `capability-synthesis/`

Observe when skills are used together. Track co-occurrence patterns. When combinations recur, propose composite skills.

**Core idea:** Skill Discovery finds existing skills. Skill Creation makes new ones deliberately. Capability Synthesis notices emergent idioms and proposes codifying them.

**Structure:**
```
observations/
├── log.md         # Raw observations
├── patterns.md    # Identified patterns
└── candidates.md  # Synthesis candidates
```

**Skills:** `observe-composition`, `propose-skill`

---

### Gradual Trust
**Directory:** `gradual-trust/`

Agents start with minimal permissions and earn more through demonstrated competence. Trust is earned through successful operations.

**Core idea:** Static permissions create a dilemma—too little access blocks useful work, too much risks damage. Progressive expansion resolves this.

**Trust levels:**
| Level | Name | Permissions |
|-------|------|-------------|
| 0 | Observer | Read, Glob, Grep |
| 1 | Contributor | + Write, Edit |
| 2 | Builder | + Bash (safe) |
| 3 | Operator | + Bash (dev tools) |
| 4 | Trusted | Full access |

**Skills:** `check-trust-level`, `record-success`, `request-escalation`

---

### Deliberate Forgetting
**Directory:** `deliberate-forgetting/`

Active memory management through intentional pruning. Review entries for relevance, archive the stale, prune the obsolete.

**Core idea:** Knowledge systems that only accumulate become bloated, stale, and noisy. Deliberate forgetting keeps memory lean and relevant.

**Classifications:**
- **Active** — Currently relevant, keep
- **Stale** — Not recently used, archive
- **Obsolete** — No longer accurate, prune
- **Permanent** — Never expires

**Skills:** `review-relevance`, `prune-memory`, `archive-stale`

---

### Adversarial Testing
**Directory:** `adversarial-testing/`

Red Team probes for weaknesses, Blue Team analyzes and hardens. Agents that attack each other to find vulnerabilities.

**Core idea:** Systems designed for benevolent operation have blind spots. Structured adversarial testing reveals fragility before it causes problems.

**Agents:**
- **Red Team** — Probes boundaries, finds bypasses
- **Blue Team** — Analyzes attacks, implements defenses

**Skills:** `probe-boundaries`, `analyze-attack`, `harden-skill`

---

### Ceremony Patterns
**Directory:** `ceremony-patterns/`

Deliberate friction for high-stakes operations. Witness the intent, wait, confirm, execute, record.

**Core idea:** Making serious actions easy is a design flaw. Ceremony adds weight—the inconvenience is the point.

**The ceremony:**
```
Witness → Wait → Confirm → Execute → Record
```

**Skills:** `ceremony-delete`, `ceremony-deploy`, `witness-action`

---

## Using These Patterns

Each pattern directory contains:
- `CLAUDE.md` — Pattern documentation
- `.claude/agents/` — Agent definitions
- `.claude/skills/` — Skill definitions
- `.claude/settings.local.json` — Permission scopes
- Supporting directories (logs, state, etc.)

To explore a pattern:
```bash
cd speculative-patterns/dialectic-agents
claude
```

## Contributing

If you test these patterns and learn something—whether they work, don't work, or need modification—please share your findings. These patterns will improve through real-world feedback.
