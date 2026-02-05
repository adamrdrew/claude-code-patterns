---
name: debate-initiate
description: Structure a topic for dialectic analysis. Frames the question clearly so Advocate and Critic can engage meaningfully.
---

# Initiate Dialectic Debate

Frame a topic for structured analysis by Advocate and Critic agents.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify the Core Question

Analyze the user's input to extract:

1. **The proposition**: What specific claim, approach, or decision is being evaluated?
2. **The context**: What constraints, goals, or background information is relevant?
3. **The stakes**: What happens if we get this wrong?

If the question is unclear, ask the user for clarification.

## Step 2: Frame for Debate

Construct a clear debate prompt that both agents can respond to:

```markdown
## Debate Topic

**Proposition:** [Clear statement of what's being proposed]

**Context:**
- [Relevant constraint 1]
- [Relevant constraint 2]
- [Current situation]

**The question:** Should we [specific action]?
```

## Step 3: Identify Key Dimensions

List the dimensions both agents should consider:

- **Technical**: Architecture, implementation, performance
- **Business**: Cost, value, timeline
- **Team**: Skills, capacity, preferences
- **Risk**: What could go wrong, probability, impact

## Step 4: Note Any Constraints

Document any constraints on the debate:

- Must-haves that aren't negotiable
- Already-made decisions that constrain the space
- Information that's missing but would be helpful

## Step 5: Report the Frame

Present the structured debate frame to the user:

```
The debate is framed as:

PROPOSITION: [statement]
CONTEXT: [summary]
KEY DIMENSIONS: [list]
CONSTRAINTS: [list]

Ready to invoke Advocate and Critic agents.
```
