---
name: check-constraints
description: Verify that a proposed action complies with all inherited constraints. Use before risky operations.
---

# Check Constraints

Verify that a proposed action complies with all organizational constraints.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify the Proposed Action

Clearly state what action is being evaluated:
- What operation? (delete, modify, execute, etc.)
- What target? (file, directory, system, etc.)
- What context? (why is this being done?)

## Step 2: Load All Constraints

Use Glob to find all constraint files:
```
.claude/constraints/*.md
```

For each constraint file, use Read to load its content.

Parse each constraint to extract:
- Name
- Severity (block, warn, audit)
- Applies to (all or specific agents)
- Check procedure
- Violation response

## Step 3: Filter Applicable Constraints

From the loaded constraints, identify which apply:
- Constraints with `applies_to: all`
- Constraints with `applies_to` including this agent

List the applicable constraints.

## Step 4: Evaluate Each Constraint

For each applicable constraint:

1. Read the "Check" section
2. Evaluate whether the proposed action satisfies the check
3. Record the result:
   - **PASS**: Check satisfied
   - **FAIL**: Check not satisfied
   - **UNCLEAR**: Cannot determine, need more information

## Step 5: Aggregate Results

Collect all evaluation results:

| Constraint | Severity | Result |
|------------|----------|--------|
| [name] | [block/warn/audit] | [PASS/FAIL/UNCLEAR] |

## Step 6: Determine Overall Verdict

Apply this logic:
1. If ANY `block` constraint FAILs → **BLOCKED**
2. If ANY `warn` constraint FAILs → **ALLOWED WITH WARNING**
3. If ANY constraint is UNCLEAR → **NEEDS CLARIFICATION**
4. If ALL constraints PASS → **ALLOWED**

## Step 7: Report Results

Format the constraint check report:

### If BLOCKED:
```
CONSTRAINT CHECK: BLOCKED

The proposed action violates the following constraint(s):

Constraint: [name]
Severity: Block
Violation: [what specifically violates it]
Required: [what would be needed to comply]

This action cannot proceed until the constraint is satisfied.
```

### If ALLOWED WITH WARNING:
```
CONSTRAINT CHECK: ALLOWED WITH WARNING

The proposed action raises the following concern(s):

Constraint: [name]
Severity: Warning
Concern: [what the warning is about]

Proceeding is allowed but be aware of the above.
```

### If NEEDS CLARIFICATION:
```
CONSTRAINT CHECK: NEEDS CLARIFICATION

Cannot fully evaluate the following constraint(s):

Constraint: [name]
Question: [what information is needed]

Please provide: [specific information needed]
```

### If ALLOWED:
```
CONSTRAINT CHECK: PASSED

All applicable constraints satisfied:
- [constraint 1]: PASS
- [constraint 2]: PASS

Proceeding with the action is approved.
```
