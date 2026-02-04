# Agent Skill Creation

In this pattern we define an Agent that is able to enhance its abilities by adding to its skill repetoire. Agent Skill Creation lets us define agents that are able to learn and improve over time in a structured and intelligent way. And because the agent is learning by creating skills, it makes the solution composable (skills that call skills) and something humans can interact with as well.

## Before You Dive In
The example project employs the Procedural Skills and Skill Discovery patterns, so you may want to give those a look before you dive into this one. You don't have to, but it might help you distinguish between what's unique to this pattern, and other patterns I employed simply to make things efficient.

## About the Pattern
At a high level the pattern is simple.

1. Give the Agent a list of Skills
2. Tell the Agent to use Skills to accomplish its tasks
3. Tell the Agent to create new Skills for anything it needed to do that wasn't doable with the existing Skill library

## The Example
In this example we have an Agent called [System Buddy](.claude/agents/system-buddy.md). It can help you use, navigate, and inspect your computer via the command line. It takes high level requests from you and then exeecutes commands that will meet your goal. Here is an example:

```
❯ @"system-buddy (agent)" Where is my home folder located?

⏺ system-buddy(Find home folder location)
  ⎿  Done (7 tool uses · 10.6k tokens · 52s)
⏺ Your home folder is located at: /Users/adam

This is the standard macOS home directory where your personal files, documents, desktop, downloads, and application preferences are stored.  
```

Maybe not the most interesting Agent in the world, but if you look at the `.claude/skills` directory you'll see something interesting over time:

Before asking System Buddy about webservers:
```bash
ll .claude/skills | grep buddy
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:28 buddy-check-chrome
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:26 buddy-check-disk-space
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:50 buddy-home-folder
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:20 buddy-system-status
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:30 buddy-terminate-chrome
```

Asking system-buddy about webservers:
```
❯ @"system-buddy (agent)" Do I have any webservers listening on any ports?

⏺ system-buddy(Check for listening webservers)
  ⎿  Done (6 tool uses · 11.8k tokens · 60s)

⏺ No traditional web servers detected.

  Here's what's listening on your system:
  ┌───────────────────────┬──────────────────────────┬────────────────────────────────────────┐
  │        Service        │          Ports           │                 Notes                  │
  ├───────────────────────┼──────────────────────────┼────────────────────────────────────────┤
  │ macOS System Services │ 5000, 7000, 57547        │ AirPlay/Control Center, Rapport daemon │
  ├───────────────────────┼──────────────────────────┼────────────────────────────────────────┤
  │ VS Code Helper        │ multiple localhost ports │ Normal IDE activity                    │
  ├───────────────────────┼──────────────────────────┼────────────────────────────────────────┤
  │ Node.js               │ 54425, 58296 (localhost) │ Likely development processes           │
  └───────────────────────┴──────────────────────────┴────────────────────────────────────────┘
  No Apache, Nginx, or similar web servers are running on standard ports (80, 443, 8080, 3000).
```

After asking:
```bash
ll .claude/skills | grep buddy
drwxr-xr-x@  3 adam  staff   96 Feb  3 12:28 buddy-check-chrome
drwxr-xr-x@  3 adam  staff   96 Feb  3 12:26 buddy-check-disk-space
drwxr-xr-x@  3 adam  staff   96 Feb  3 12:57 buddy-check-listening-ports
drwxr-xr-x@  3 adam  staff   96 Feb  3 12:50 buddy-home-folder
drwxr-xr-x@  3 adam  staff   96 Feb  3 12:20 buddy-system-status
drwxr-xr-x@  3 adam  staff   96 Feb  3 12:30 buddy-terminate-chrome
```

The agent created a new skills called `buddy-check-listening-ports`! It augmented its abilities.

So, how did we do this?

## Contructing the Pattern

The key pillars of this pattern are:

1. A Skill for creating Skills
2. Agent instructions that bias the agent toward skill reuse and creation. 

### A Skill to Create Skills

Take a look at the [`skill-create`](.claude/skills/skill-create/) Skill. That Skill tells the agent how to create a skill and register it with the `skill-list` Skill, which the agent uses to find what Skills are available. Once the Skill is created, the Agent and any further invocations of it has that Skill available.

### Bias the Agent Toward Skill Re-use and Creation
Have a look at the [`system-buddy`](.claude/agents/system-buddy.md) Agent definition. Here's Claude's summation of the design:

> The System Buddy follows a check-first, learn-after loop:
>
> 1. List skills → Check what's already available via skills-list
> 2. Run matching skills → Execute any that fulfill part/all of the request
> 3. Plan & execute → Handle remaining work with bash commands
> 4. Create skills → Codify any new procedures discovered into reusable skills
>
> The key principle: always check for existing skills before doing work, always create skills after figuring something out. This creates a virtuous cycle where the agent gets more capable with each novel request.

And it does get more capable with each novel request! If you spent a few hours interacting with this agent you could build up a solid library of reusable and composable skills.

## Be Mindful of what the Agent Creates
Giving Agents the ability to extend their capabilities by authoring skills is a powerful pattern, but it is also a potentially dangerous one. Make sure you understand your Agent's tool privledges, your project permissions, and review the skills you agent creates!

## Plugin Considerations
If you were applying this pattern in a plugin you were developing you'd also need to ensure your new skills get added to `.claude-plugin/plugin.json`.

## Going Further
The example in this repo is extremely minimal. You can imagine more complex scenarios.

You could have a model where the active Agent uses skill composition to finish its work, but if a Skill isn't available it opens a ticket for skill creation. Another agent could come along and consume the ticket and create the ticket. This could lead to better seperation of concerns. 

You can use this pattern to fasciliate what I call *"Grow, Don't Build"* where you *"grow"* an Agent to suit your needs rather than attempt to build one up front. If you combine Agent Skill Creation with giving the Agent the ability to edit itself, you can create extremely rich and complex Agents and skill libraries starting from little more than "You are a helpful agent ready to learn. For anything you learn to do, create a skill." That and a simple skill creation bootstrap can get you from nothing to a rich agent and skill library with no Big Design Up Front.

There's a lot you can do with this pattern!

