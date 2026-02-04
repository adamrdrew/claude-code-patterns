# Subagent Skill Creation

In this pattern we define a subagent that enhances its own abilities by adding to its skill repertoire. Subagent Skill Creation lets you build subagents that learn and improve over time in a structured way. Because the subagent learns by creating skills, the solution is composable (skills can call other skills) and human-interactable (you can invoke the same skills the subagent created).

## Before You Dive In

This example uses concepts from **Procedural Skills** and **Skill Discovery**. You may want to review those first — not required, but it helps distinguish what's unique to this pattern versus supporting infrastructure.

## About the Pattern

At a high level the pattern is simple.

1. Give the subagent a list of skills
2. Instruct it to use skills to accomplish tasks
3. Instruct it to create new skills for anything that wasn't covered by the existing library

## The Example

In this example we have a subagent called [System Buddy](.claude/agents/system-buddy.md). It helps you use, navigate, and inspect your computer via the command line. It takes high-level requests and executes commands to meet your goals. Here's an example:

```
❯ @"system-buddy (agent)" Where is my home folder located?

⏺ system-buddy(Find home folder location)
  ⎿  Done (7 tool uses · 10.6k tokens · 52s)
⏺ Your home folder is located at: /Users/adam

This is the standard macOS home directory where your personal files, documents, desktop, downloads, and application preferences are stored.  
```

Not the most interesting subagent in the world, but if you look at the `.claude/skills` directory you'll see something interesting over time:

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

The subagent created a new skill called `buddy-check-listening-ports`! It augmented its abilities.

So, how did we do this?

## Constructing the Pattern

The key pillars of this pattern are:

1. A Skill for creating Skills
2. Subagent instructions that bias the subagent toward skill reuse and creation. 

### A Skill to Create Skills

Take a look at the [`skill-create`](.claude/skills/skill-create/) Skill. That Skill tells the subagent how to create a skill and register it with the `skill-list` Skill, which the subagent uses to find what Skills are available. Once the Skill is created, the subagent and any further invocations of it has that Skill available.

### Bias the Subagent Toward Skill Re-use and Creation
Have a look at the [`system-buddy`](.claude/agents/system-buddy.md) subagent definition. Here's Claude's summation of the design:

> The System Buddy follows a check-first, learn-after loop:
>
> 1. List skills → Check what's already available via skills-list
> 2. Run matching skills → Execute any that fulfill part/all of the request
> 3. Plan & execute → Handle remaining work with bash commands
> 4. Create skills → Codify any new procedures discovered into reusable skills
>
> The key principle: always check for existing skills before doing work, always create skills after figuring something out. This creates a virtuous cycle where the subagent gets more capable with each novel request.

And it does get more capable with each novel request! If you spent a few hours interacting with this subagent you could build up a solid library of reusable and composable skills.

## Be Mindful of What the Subagent Creates

Giving subagents the ability to extend their capabilities by authoring skills is powerful but requires oversight.

**What to watch for:**

- **Overly broad skills** — Skills that do too much or have vague descriptions
- **Security concerns** — Skills that could expose sensitive data or run dangerous commands
- **Skill sprawl** — Many similar skills that should be consolidated
- **Incorrect procedures** — Skills that encode a suboptimal or wrong approach

**Recommendations:**

1. Periodically review `.claude/skills/buddy-*/SKILL.md` files
2. Delete or consolidate skills that aren't useful
3. Refine skill descriptions so the agent uses them appropriately
4. Consider adding explicit constraints to `skill-create` about what skills should/shouldn't do

## Plugin Considerations

If you're building a plugin that uses this pattern, created skills need to be registered in your plugin's `skills/` directory and referenced appropriately. See the [Claude Code plugins documentation](https://code.claude.com/docs/en/plugins) for the current plugin structure.

## Going Further
The example in this repo is extremely minimal. You can imagine more complex scenarios.

You could have a model where the active subagent uses skill composition to finish its work, but if a Skill isn't available it opens a ticket for skill creation. Another subagent could come along and consume the ticket and create the skill. This could lead to better separation of concerns.

You can use this pattern to facilitate what I call *"Grow, Don't Build"* where you *"grow"* a subagent to suit your needs rather than attempt to build one up front. If you combine Subagent Skill Creation with giving the subagent the ability to edit itself, you can create extremely rich and complex subagents and skill libraries starting from little more than "You are a helpful subagent ready to learn. For anything you learn to do, create a skill." That and a simple skill creation bootstrap can get you from nothing to a rich subagent and skill library with no Big Design Up Front.

There's a lot you can do with this pattern!

## Further Reading

- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Official Claude Code subagents documentation
- [Extend Claude with skills](https://code.claude.com/docs/en/skills) - How to create and use skills
- [Claude Code settings](https://code.claude.com/docs/en/settings) - Configuration reference
- [Anthropic Skills repository](https://github.com/anthropics/skills) - Official skills examples

