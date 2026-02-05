---
name: harden-skill
description: Implement defensive changes to protect against discovered vulnerabilities
---

# Harden Skill

Implement defensive changes based on attack analysis.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Analysis

Use Read to load the attack analysis from `reports/analysis/`.

Identify:
- The target to harden
- The recommended defense
- The specific changes needed

## Step 2: Locate Target

Use Read to load the target file:
- For agents: `.claude/agents/[name].md`
- For skills: `.claude/skills/[name]/SKILL.md`
- For constraints: `.claude/constraints/[name].md`

## Step 3: Plan Changes

Based on the analysis, plan specific edits:

### For Constraint Hardening:
```markdown
BEFORE:
[Current constraint text]

AFTER:
[Hardened constraint text with:]
- Explicit coverage of the exploit
- Examples of what's not allowed
- Clear edge case handling
```

### For Skill Hardening:
```markdown
BEFORE:
[Current skill instructions]

AFTER:
[Hardened instructions with:]
- Input validation steps
- Additional checks
- Explicit failure handling
```

### For Agent Hardening:
```markdown
BEFORE:
[Current agent rules]

AFTER:
[Hardened rules with:]
- Additional constraints
- Clearer boundaries
- Explicit prohibitions
```

## Step 4: Implement Changes

Use Edit to apply the planned changes.

Be careful to:
- Preserve existing functionality
- Not introduce new vulnerabilities
- Maintain readability
- Follow existing style

## Step 5: Add Defense Notes

Add a comment or note explaining the hardening:

```markdown
<!-- Hardened [date]: [attack name]
     Change: [what was changed]
     Reason: [why]
     See: reports/defenses/[report].md -->
```

## Step 6: Create Defense Report

Write to `reports/defenses/[name].md`:

```markdown
# Defense Report: [Name]

**Date:** [today]
**Attack Report:** [reference]
**Analysis:** [reference]
**Target Hardened:** [what was changed]

## Attack Summary
[Brief description of the attack]

## Root Cause
[From analysis]

## Defense Implemented

### Changes Made

#### [File 1]
**Before:**
```
[original text]
```

**After:**
```
[hardened text]
```

**Rationale:** [why this change helps]

### Additional Protections
[Any other changes made]

## Verification

### Test Case 1: Original Attack
- **Input:** [the original attack]
- **Expected:** [should be blocked]
- **Actual:** [verified blocked]

### Test Case 2: Normal Operation
- **Input:** [legitimate use]
- **Expected:** [should work]
- **Actual:** [verified working]

## Side Effects
[Any changes to functionality]

## Status
[Complete/Partial/Needs Review]

## Recommendations
- [Any follow-up items]
- [Re-probe request for Red Team]
```

## Step 7: Update Summary

Append to `reports/summary.md`:

```markdown
## [Date] - [Attack Name]
- **Severity:** [severity]
- **Status:** Hardened
- **Changes:** [brief description]
- **Reports:** [attack] → [analysis] → [defense]
```

## Step 8: Request Re-Probe

Suggest Red Team verification:

```
Hardening Complete

Target: [what was hardened]
Attack: [what was prevented]

Changes made:
- [Change 1]
- [Change 2]

Defense report: reports/defenses/[name].md

Recommendation: Request Red Team to re-probe the target
to verify the vulnerability is resolved and no new
attack surfaces were created.
```
