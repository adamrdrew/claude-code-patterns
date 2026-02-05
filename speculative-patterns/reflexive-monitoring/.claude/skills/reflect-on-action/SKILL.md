---
name: reflect-on-action
description: Structured reflection on a recent action. Use when you want to deeply evaluate something you just did.
---

# Reflect on Action

Perform a structured reflection on a recent action to evaluate its quality and decide whether to continue, adjust, or reconsider.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify the Action

Clearly state what action you're reflecting on:
- What tool was used?
- What was the target (file, command, etc.)?
- What was the intent?

## Step 2: Evaluate Intent Match

Ask: Did the action achieve what I intended?

- **Yes**: The action accomplished its goal
- **Partially**: Some of the goal was achieved
- **No**: The action didn't achieve its goal

If not fully achieved, note what's missing.

## Step 3: Consider Side Effects

Ask: Could this action have unintended consequences?

- What other code depends on what I changed?
- Did I change any interfaces or contracts?
- Could this break tests or other components?

List any potential side effects identified.

## Step 4: Check Consistency

Ask: Is this action consistent with my overall approach?

- Does it align with the plan I stated?
- Does it follow the patterns in this codebase?
- Would I make the same choice if starting fresh?

Note any inconsistencies.

## Step 5: Assess Confidence

Rate your confidence in this action:

| Level | Meaning | Response |
|-------|---------|----------|
| High | I'm confident this is correct | Continue |
| Medium | I think this is right but have some doubt | Note concerns, continue |
| Low | I'm uncertain this is the right approach | Pause and reconsider |

## Step 6: Decide on Course

Based on reflection, decide:

**Continue**: No issues found, proceed with the plan
**Adjust**: Minor issues found, make corrections and continue
**Reconsider**: Significant concerns, pause and think more deeply

## Step 7: Document and Act

If continuing: Briefly note reflection was done, continue
If adjusting: State what you're adjusting and why, then do it
If reconsidering: Explain the concern and what you're considering instead

Example output:

```
Reflection on edit to auth.ts:

- Intent: Add token validation ✓ Achieved
- Side effects: None identified
- Consistency: Aligns with security-first approach
- Confidence: High

Decision: Continue with next step
```
