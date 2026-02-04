# Skill Discovery

In this pattern we give Agents the ability to discover Skills without injecting all Skills into the Agent context ahead of time.

Agents run in their own context and don't inherit everything from the parent context. One of the things Agents don't receive is the list of Skill names and descriptions. This means that, by default, Agents won't know what Skills you have available.

Claude Code [allows injecting Skills into the Agent context](https://code.claude.com/docs/en/sub-agents#preload-skills-into-subagents). This makes the Skills available to Agents. However, the way Claude Code does this is to inject the full Skill definitions into the Agent at invocation time. This can eat a lot of context space and use up a lot of tokens. For a few Skills it may not be an issue, but for many Skills and large Skills it can be costly and introduce noise into the context window.

The Skill Discovery pattern allows you to make Skills available to Agents on-demand, without injecting them into the context.

## About the Pattern

At a high level the pattern is simple.

1. Create a Skill that can list the other Skills
2. Inject the Skill lookup Skill into the Agent
3. Tell the Agent to use the lookup Skill to find Skills

## The Example

In this example we have an Agent called [Weather Buddy](.claude/agents/weather-buddy.md). It can help you get local weather forecasts and answer questions about the weather. It uses Skill Discovery to find and invoke weather and memory Skills on-demand.

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

Weather Buddy discovers and uses multiple Skills to answer this question:

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

The Agent interprets the weather data in context of the user's actual question, providing practical advice rather than just raw forecast data.

## Constructing the Pattern

The key pillars of this pattern are:

1. A Skill that lists other Skills
2. Agent instructions that direct the Agent to discover Skills before acting

### The List Skills Skill

Take a look at the [`list-skills`](.claude/skills/list-skills/SKILL.md) Skill. It's a simple manifest that lists all available Skills with their names and descriptions. When the Agent invokes this Skill, it learns what capabilities are available without loading the full Skill definitions into context.

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

This gives the Agent enough information to know what Skills exist and what they do, without loading every Skill definition upfront.

### Agent Instructions for Skill Discovery

Have a look at the [`weather-buddy`](.claude/agents/weather-buddy.md) Agent definition. The key section is:

```markdown
## Skill Discovery

You have access to the `list-skills` skill. Before attempting any operation,
you MUST invoke this skill to discover what skills are available to you.
```

The Agent is instructed to always discover Skills first, then use only the Skills that appear in the list. This creates a lazy-loading pattern where Skill definitions are only loaded when the Agent actually invokes them.

## Skill Discovery vs Skill Injection

| Approach | Tokens at Invocation | Tokens Per Skill Use |
|----------|---------------------|---------------------|
| **Skill Injection** | High (all Skill definitions loaded) | None (already loaded) |
| **Skill Discovery** | Low (only list-skills injected) | Per-Skill (loaded on demand) |

Skill Injection is simpler and works well for Agents with a small number of small Skills. Skill Discovery is more efficient when you have many Skills or large Skill definitions, since you only pay for the Skills you actually use.

## Going Further

The list-skills Skill in this example is manually maintained. You could automate this by having a Skill that reads the `.claude/skills` directory and generates the manifest dynamically. This would ensure the list is always up to date.

You could also combine Skill Discovery with the Agent Skill Creation pattern. An Agent that can both discover and create Skills becomes a self-improving system that grows its capabilities over time while keeping context costs under control.
