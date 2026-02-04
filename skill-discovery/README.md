# Skill Discovery

In this pattern we give Agents the ability to discover skills without injecting all skills into the agent context ahead of time.

Agents run in their own context and don't inherit everything from the parent context. One of the things Agent's don't recieve is the list of skill names and descriptions. This means that, by default, Agents wont know what skills you have available.

Claude Code [allows injecting Skills into the Agent context](https://code.claude.com/docs/en/sub-agents#preload-skills-into-subagents). This makes the Skills available to Agents. However, the way Claude Code does this is to inject the full skill definitions into the Agent at invocation time. This can eat a lot of context space and use up a lot of tokens. For a few skills it may not be an issue, but for many skills and large skills it can be costly and introduce noise into the context window.

The Skill Discovery pattern allows you to make Skills available to Agents on-demand, without injecting them into the context. 

## About the Pattern
At a high level the pattern is simple.

1. Create a skill that can list the other skills
2. Inject the skill lookup skill into the agent
3. Tell the agent to use the lookup skill to find skills

## The Example
In this example we have an Agent called [Weather Buddy](.claude/agents/weather-buddy.md)