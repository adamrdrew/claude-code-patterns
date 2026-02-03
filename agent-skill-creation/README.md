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

```bash
ll .claude/skills | grep buddy
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:28 buddy-check-chrome
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:26 buddy-check-disk-space
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:50 buddy-home-folder
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:20 buddy-system-status
drwxr-xr-x@ 3 adam  staff   96 Feb  3 12:30 buddy-terminate-chrome
```

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