# Procedural Skills

In this pattern we trade some agent autonomy for determinism. AI agents are great at figuring things out and getting creative, but sometimes you want things done in a specific, predictable order. Procedural Skills let you define step-by-step procedures that the agent follows exactly, using Claude Code's Task tools (TaskCreate, TaskUpdate, TaskList) to enforce execution order.

It will never be as deterministic as classical code, but it can come darn close while still giving you the flexibility of working with an AI agent.

## About the Pattern

At a high level the pattern is simple.

1. Define Skills with numbered steps
2. Instruct the Skill to use TaskCreate to create a task for each step
3. The agent executes steps in order, using TaskUpdate to mark progress

The magic happens in how you write the Skill. Instead of giving the agent loose instructions and letting it figure out the approach, you give it explicit steps. The agent uses TaskCreate to turn those steps into a task list, then works through them sequentially using TaskUpdate to track progress. This creates a predictable execution flow that you can reason about and debug.

## The Example

In this example we have an Agent called [Data Buddy](.claude/agents/data-buddy.md). It's a simple data librarian that manages a plaintext "database" of markdown files. Users can store, retrieve, update, and delete information, and Data Buddy handles all the bookkeeping.

The database is just a `database/` directory with markdown files and an `index.md` that tracks what's stored where. Nothing fancy, but it demonstrates the pattern well.

Here's an example of storing some information:

```
❯ @"data-buddy (agent)" Remember that my dog's name is Luna and she's a golden retriever

⏺ data-buddy(Store pet information)
  ⎿  Done (8 tool uses · 9.2k tokens · 45s)

⏺ Done! I've stored your pet information.

  Created: database/pets.md
  Updated: database/index.md

  You can ask me about your pets anytime and I'll look it up for you.
```

And here's retrieving it later:

```
❯ @"data-buddy (agent)" What pets do I have?

⏺ data-buddy(Retrieve pet information)
  ⎿  Done (6 tool uses · 7.8k tokens · 32s)

⏺ According to my records, you have one pet:

  - **Luna** - Golden Retriever
```

What makes this interesting isn't what Data Buddy does, it's *how* it does it. Every operation follows a rigid procedure. When retrieving data, it doesn't just go rummaging through files. It follows a specific sequence:

1. Verify the database exists
2. Read the index
3. Search the index for relevant entries
4. Read the specific document(s)
5. Synthesize and report

The agent never skips steps, never takes shortcuts, never tries to be clever. It follows the procedure.

## Constructing the Pattern

The key pillars of this pattern are:

1. Skills written as numbered Todo steps
2. Agent instructions that enforce procedural execution
3. A skill library that covers all database operations

### Skills as Todo Lists

Take a look at the [`db-read`](.claude/skills/db-read/SKILL.md) Skill. Notice how it's structured:

```markdown
## Step 1: Verify Database
Use the Skill tool to invoke the `db-verify` skill...

## Step 2: Read Index
Use the Read tool to read `database/index.md`...

## Step 3: Find Relevant Documents
Search the index for entries matching the user's query...

## Step 4: Read Documents
For each relevant document found, use the Read tool...

## Step 5: Report Results
Synthesize the information and report to the user...
```

Each Step is a discrete unit with clear instructions. The agent uses TaskCreate to create a task for each step, then executes them in order using TaskUpdate to track status. If a step fails (like the database not existing), the procedure handles it explicitly rather than letting the agent improvise.

### Agent Instructions for Procedural Execution

Have a look at the [`data-buddy`](.claude/agents/data-buddy.md) Agent definition. The critical section is:

```markdown
## Critical Operating Rules

1. **Skills Only**: You must ONLY use skills from your skill library. You must
   NEVER attempt to read, write, or navigate files directly outside of skills.

2. **Procedural Execution**: Every skill you invoke uses TaskCreate to create
   a task list. Execute tasks in order, using TaskUpdate to mark each as
   in_progress when starting and completed when done.

3. **No Improvisation**: If a skill fails or a step cannot be completed, STOP
   and report the issue. Do NOT attempt workarounds or creative solutions.
```

This is the key constraint. The agent is explicitly forbidden from going off-script. It can only act through skills, and skills are procedural. This creates a predictable system where you know exactly what the agent will do for any given request.

### The Skill Library

The skill library covers all database operations:

| Skill | Purpose |
|-------|---------|
| `db-verify` | Check if database exists and is properly initialized |
| `db-init` | Initialize the database with an empty index |
| `db-read` | Find and read documents matching a query |
| `db-upsert` | Create or update a document |
| `db-delete` | Remove a document and update the index |
| `db-list` | List all documents in the database |

Each skill is self-contained and procedural. Skills can invoke other skills (like `db-read` invoking `db-verify` first), creating composable procedures.

## Why Not Just Use Code?

Fair question. If you want determinism, why not just write a Python script?

The answer is that Procedural Skills give you *constrained flexibility*. The agent still interprets natural language, figures out which skill to use, and synthesizes results. You get the benefits of AI (natural language interface, intelligent synthesis) with the predictability of procedures (known execution paths, debuggable steps).

For Data Buddy, this means users can ask questions in natural language ("What pets do I have?", "Tell me about Luna", "Do I have any dogs?") and the agent figures out the right skill to use. But once the skill is invoked, execution is predictable.

## Going Further

The example in this repo is minimal. You can imagine more sophisticated applications.

You could build a procedural agent for managing infrastructure, where each operation (deploy, rollback, scale) follows an exact runbook. The agent interprets what you want, but execution follows your documented procedures.

You could combine Procedural Skills with the Agent Skill Creation pattern, but with a twist: the agent can create new skills, but only procedural ones. This gives you a system that grows its capabilities while maintaining predictability.

You could also use Procedural Skills for compliance-sensitive operations where you need an audit trail. Each Todo step can log what it did, creating a record of exactly how an operation was performed.

The core insight is that you can have AI flexibility and procedural predictability in the same system. You just have to be intentional about where each one applies.

