# 🔭 Skill Discovery

In this pattern we give subagents the ability to discover skills without injecting all skills into the context ahead of time.

Subagents (custom agents defined in `.claude/agents/`) run in their own isolated context. They don't inherit everything from the parent conversation — including the list of available skill names and descriptions. By default, your subagent won't know what skills you've created.

Claude Code [allows injecting skills into subagent context](https://code.claude.com/docs/en/sub-agents#preload-skills-into-subagents) via the `skills:` frontmatter field. However, this injects the **full skill definitions** at invocation time. For a few small skills, that's fine. For many skills or large skill definitions, it's costly and noisy.

The Skill Discovery pattern makes skills available to subagents **on-demand**, without upfront injection.

## 🔍 About the Pattern

At a high level the pattern is simple.

1. Create a skill that lists other skills
2. Inject the skill-listing skill into the subagent (via `skills:` frontmatter)
3. Instruct the subagent to use the listing skill to discover what's available

## 💡 The Example

In this example we have a subagent called [Weather Buddy](.claude/agents/weather-buddy.md). It helps you get local weather forecasts and answer questions about the weather. It uses Skill Discovery to find and invoke weather and memory skills on-demand.

Here's an example of asking Weather Buddy about snow:

```
❯ @"weather-buddy (agent)" Is there any snow expected this week?

⏺ weather-buddy(Check for snow this week)
  ⎿  Done (10 tool uses · 12.4k tokens · 37s)

⏺ Yes, snow is expected this week in Garner, NC (27529).

  Thursday, February 5th is the day to watch:
  - High: 34°F / Low: 29°F
  - 26% chance of precipitation
  - Snow in the forecast

  The rest of the week looks dry with partly cloudy skies.
```

Weather Buddy discovers and uses multiple skills to answer this question:

1. `list-skills` - Discovers what Skills are available
2. `read-memory` - Checks if the user's zip code is stored
3. `get-local-weather` - Fetches the 7-day forecast

If the user's zip code isn't stored yet, Weather Buddy asks for it and uses `create-memory` and `update-memory` to persist it for future requests.

Here's an example of a more nuanced question:

```
❯ @"weather-buddy (agent)" We've got a Super Bowl party on Sunday evening.
  How should I dress? Should our guests be worried about driving conditions?

⏺ weather-buddy(Super Bowl party weather advice)
  ⎿  Done (4 tool uses · 17.7k tokens · 22s)

⏺ Great news for your Super Bowl party — the weather should cooperate.

  Sunday, Feb 8 Forecast
  - High: 40°F → Low: 22°F
  - Partly cloudy, only 3% chance of precipitation

  What to Wear
  By evening, expect temps dropping into the low 30s to upper 20s. Recommend:
  - Warm winter coat
  - Layers underneath
  - Hat and gloves for the walk to/from the car

  Driving Conditions
  Your guests should be fine. Sunday is forecast to be dry with no ice or snow.

  Thursday's snow will have had 3 days to melt (Friday hits 47°F, Saturday 40°F),
  so roads should be clear well before your party.
```

The subagent interprets the weather data in context of the user's actual question, providing practical advice rather than just raw forecast data.

## 🏗️ Constructing the Pattern

The key pillars of this pattern are:

1. A Skill that lists other Skills
2. Subagent instructions that direct the subagent to discover Skills before acting

### 📋 The List Skills Skill

Take a look at the [`list-skills`](.claude/skills/list-skills/SKILL.md) Skill. It's a simple manifest that lists all available Skills with their names and descriptions. When the subagent invokes this Skill, it learns what capabilities are available without loading the full Skill definitions into context.

The Skill is organized by category:

```markdown
## Weather Skills
**weather-api** - Reference documentation for the Open-Meteo free weather API...
**zip-code-to-lat-and-long** - Convert US zip codes to coordinates...
**get-local-weather** - Get weather for a location...

## Memory Skills
**create-memory** - Initialize the memory persistence system...
**read-memory** - Read entries from memory...
**update-memory** - Add or update a key-value pair...
```

This gives the subagent enough information to know what Skills exist and what they do, without loading every Skill definition upfront.

### 🤖 Subagent Instructions for Skill Discovery

Have a look at the [`weather-buddy`](.claude/agents/weather-buddy.md) subagent definition. The key section is:

```markdown
## Skill Discovery

You have access to the `list-skills` skill. Before attempting any operation,
you MUST invoke this skill to discover what skills are available to you.
```

The subagent is instructed to always discover Skills first, then use only the Skills that appear in the list. This creates a lazy-loading pattern where Skill definitions are only loaded when the subagent actually invokes them.

## ⚖️ Skill Discovery vs Skill Injection

| Approach | Tokens at Invocation | Tokens Per Skill Use |
|----------|---------------------|---------------------|
| **Skill Injection** | High (all Skill definitions loaded) | None (already loaded) |
| **Skill Discovery** | Low (only list-skills injected) | Per-Skill (loaded on demand) |

Skill Injection is simpler and works well for subagents with a small number of small Skills. Skill Discovery is more efficient when you have many Skills or large Skill definitions, since you only pay for the Skills you actually use.

## 💉 A Note on Skill Injection

Claude Code also supports injecting skills directly into subagents via the `skills:` frontmatter field:

```yaml
---
name: my-agent
skills:
  - skill-one
  - skill-two
---
```

This loads the full skill content at invocation time. Use **Skill Injection** when you have a small number of small skills. Use **Skill Discovery** when you have many skills or large skill definitions — you only pay for what you use.

## 🚀 Going Further

The `list-skills` skill in this example is manually maintained. This is simple but error-prone — add a skill, forget to update the list.

**Automation options:**

1. **Dynamic manifest** — Create a skill that reads `.claude/skills/*/SKILL.md` and generates the list at runtime
2. **Build step** — Add a script that regenerates `list-skills` whenever skills change
3. **Hook-based** — Use a `SessionStart` hook to rebuild the manifest

You could also combine Skill Discovery with the Subagent Skill Creation pattern. A subagent that can both discover and create skills becomes a self-improving system that grows its capabilities over time while keeping context costs under control.

## 🚀 Use This Pattern

Want to use this pattern in your own project? Copy this link into Claude Code and it will set up everything for you:

```
https://raw.githubusercontent.com/adamrdrew/claude-code-patterns/master/skill-discovery/teach-claude.md
```

Claude will read the instructions and configure your project with the Skill Discovery pattern, including the list-skills meta-skill and a starter subagent.

## 📖 Further Reading

- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - Official Claude Code skills documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation with skill preloading info
- [Claude Code settings](https://code.claude.com/docs/en/settings) - Configuration reference
- [Anthropic Skills repository](https://github.com/anthropics/skills) - Official skills examples
