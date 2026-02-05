---
name: propose-skill
description: Analyze composition patterns and propose new composite skills
---

# Propose Composite Skill

Analyze observed patterns and propose new skills that synthesize common compositions.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Observations

Use Read to load:
- `observations/patterns.md` - Pattern counts and summaries
- `observations/candidates.md` - Flagged synthesis candidates
- `observations/log.md` - Detailed observation history

If no observations exist, report that more usage data is needed.

## Step 2: Identify Strong Candidates

Filter patterns to find strong synthesis candidates:

**Criteria:**
- Observed 3+ times
- Consistent sequence (same order each time)
- Clear context (identifiable use case)
- Complementary skills (output of one feeds input of next)

Rank candidates by:
1. Observation count (more = stronger signal)
2. Sequence consistency (always same order = better)
3. Context clarity (clear when to use = better)

## Step 3: Analyze Top Candidate

For the strongest candidate, analyze deeply:

**Skill Analysis:**
- What does skill A do? What does it output?
- What does skill B need? What does it output?
- What does skill C need? What is the final result?

**Flow Analysis:**
- How does data flow from A to B to C?
- What inputs does the user provide?
- What output does the user receive?

**Value Analysis:**
- What effort does composition save?
- What errors does it prevent?
- Is it simpler than separate invocations?

## Step 4: Design Composite Skill

Create the composite skill design:

**Name:**
- Should describe what it does, not how
- Should be shorter than listing components
- Should fit naming conventions (prefix if applicable)

**Description:**
- One sentence explaining the capability
- Mention when to use it

**Steps:**
1. What the first skill does (adapted)
2. What the second skill does (adapted)
3. What the third skill does (adapted)
4. How to present results

## Step 5: Draft Implementation

Write a complete SKILL.md:

```markdown
---
name: [composite-name]
description: [what it does and when to use it]
---

# [Title]

[Brief explanation of what this composite skill accomplishes]

Use TaskCreate to create a task for each step below...

## Step 1: [First Component]
[Instructions from first skill, adapted]

## Step 2: [Second Component]
[Instructions from second skill, adapted]
[Note how it uses output from Step 1]

## Step 3: [Third Component]
[Instructions from third skill, adapted]
[Note how it uses output from Step 2]

## Step 4: Report Results
[How to present the final output]
```

## Step 6: Document Proposal

Create a proposal document:

```markdown
# Skill Proposal: [name]
**Date:** [today]
**Status:** proposed

## Evidence

**Pattern observed:** [A] → [B] → [C]
**Observation count:** [N]
**Contexts seen:**
- [Context 1]
- [Context 2]

## Proposed Skill

**Name:** [name]
**Description:** [description]

### What It Does
[Explanation]

### When to Use
[Typical scenarios]

### Advantage Over Manual Composition
- [Advantage 1]
- [Advantage 2]

## Implementation

[Full SKILL.md content]

## Next Steps
- [ ] Review proposal
- [ ] Test implementation
- [ ] Add to skills-list
```

## Step 7: Present Proposal

Report the proposal to the user:

```
Skill Proposal: [name]

Based on [N] observations of the pattern:
  [A] → [B] → [C]

I propose creating a composite skill that:
[summary of what it does]

This would:
- Reduce [N] skill invocations to 1
- Simplify [what becomes easier]
- Prevent [what errors are avoided]

The full proposal is at: observations/proposals/[name].md

Would you like me to create this skill?
```
