---
name: analyze-attack
description: Analyze an attack report to understand root cause and plan defense
---

# Analyze Attack

Analyze a Red Team attack report to understand the vulnerability and plan hardening.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Attack Report

Use Glob to find attack reports in `reports/attacks/`.

Use Read to load the specified or most recent attack report.

## Step 2: Understand the Attack

Extract from the report:
- **Target**: What was attacked?
- **Category**: What type of attack?
- **Vector**: How was it attempted?
- **Result**: Did it succeed?
- **Severity**: How bad is it?

## Step 3: Reproduce the Logic

Walk through the attack step by step:

1. What was the initial state?
2. What action was taken?
3. Why did the target respond that way?
4. At what point did the vulnerability manifest?

## Step 4: Root Cause Analysis

Identify why the vulnerability exists:

### Is it a specification gap?
- The constraint doesn't cover this case
- Instructions are ambiguous
- Expected behavior isn't defined

### Is it a logic flaw?
- The check is in the wrong place
- The validation is incomplete
- The sequence allows bypass

### Is it an assumption failure?
- An implicit assumption is wrong
- Input isn't validated
- Context isn't checked

### Is it a composition issue?
- Individual pieces are safe
- Combination creates vulnerability
- Permissions stack unsafely

## Step 5: Assess Real-World Impact

Consider:
- How likely is this to occur naturally?
- How likely is intentional exploitation?
- What's the worst case if exploited?
- What data or systems are at risk?

Rate the overall risk:
```
Likelihood: [High/Medium/Low]
Impact: [Critical/High/Medium/Low]
Overall Risk: [Critical/High/Medium/Low]
```

## Step 6: Design Defense

Propose how to fix the vulnerability:

### Constraint Fixes
- How should the constraint be reworded?
- What cases need to be explicitly covered?
- What examples would clarify?

### Validation Fixes
- What input checks are needed?
- What output verification?
- What state validation?

### Structural Fixes
- Does the design need changing?
- Should permissions be reduced?
- Should composition be limited?

## Step 7: Consider Side Effects

Before recommending the fix:
- Will it break existing functionality?
- Will it make the system too restrictive?
- Will it create new attack surfaces?
- Is it proportionate to the risk?

## Step 8: Create Analysis Report

Write analysis to `reports/analysis/[name].md`:

```markdown
# Attack Analysis: [Name]

**Date:** [today]
**Attack Report:** [reference]
**Analyst:** blue-team

## Attack Summary
[Brief description]

## Root Cause
[Why the vulnerability exists]

**Type:** [specification gap/logic flaw/assumption failure/composition]

## Impact Assessment
- **Likelihood:** [High/Medium/Low]
- **Impact:** [Critical/High/Medium/Low]
- **Overall Risk:** [Critical/High/Medium/Low]

## Proposed Defense

### Option 1: [Name]
[Description]
**Pros:** [benefits]
**Cons:** [drawbacks]

### Option 2: [Name]
[Description]
**Pros:** [benefits]
**Cons:** [drawbacks]

## Recommendation
[Which option and why]

## Implementation Notes
[Specific changes needed]

## Verification Plan
[How to test the fix works]
```

## Step 9: Report to User

Summarize the analysis:

```
Attack Analysis Complete

Attack: [name]
Severity: [severity]
Root Cause: [one line]

Recommendation: [proposed fix]

See full analysis: reports/analysis/[name].md

Ready to proceed with hardening?
Use the `harden-skill` skill to implement the defense.
```
