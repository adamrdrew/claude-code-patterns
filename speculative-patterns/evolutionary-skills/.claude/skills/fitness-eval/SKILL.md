---
name: fitness-eval
description: Evaluate and compare skill outputs using fitness criteria to determine which version is superior
---

# Fitness Evaluation

Evaluate skill outputs from a competition to determine the winner.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Load Competition Results

Use Glob to find the most recent competition result in `arena/results/`.

Use Read to load the competition record containing:
- The test input
- Output A (from skill version A)
- Output B (from skill version B)

## Step 2: Define Evaluation Criteria

Use these default criteria (or custom criteria if specified):

| Criterion | Weight | Description |
|-----------|--------|-------------|
| Correctness | 40% | Did it produce the right/expected output? |
| Clarity | 25% | Is the output easy to understand? |
| Efficiency | 20% | Was the approach reasonable? |
| Robustness | 15% | Would it handle edge cases well? |

## Step 3: Evaluate Output A

For each criterion, score Output A from 1-10:

**Correctness (1-10):**
- Does it answer the question/complete the task?
- Are there any errors or inaccuracies?

**Clarity (1-10):**
- Is the output well-organized?
- Is it easy to understand?

**Efficiency (1-10):**
- Was the approach straightforward?
- Any unnecessary complexity?

**Robustness (1-10):**
- Would this approach handle variations?
- Any fragile assumptions?

Calculate weighted score for A.

## Step 4: Evaluate Output B

Apply the same evaluation to Output B:
- Score each criterion 1-10
- Calculate weighted score for B

## Step 5: Compare Results

Create comparison table:

| Criterion | Weight | A Score | B Score | A Weighted | B Weighted |
|-----------|--------|---------|---------|------------|------------|
| Correctness | 40% | X | X | X*0.4 | X*0.4 |
| Clarity | 25% | X | X | X*0.25 | X*0.25 |
| Efficiency | 20% | X | X | X*0.2 | X*0.2 |
| Robustness | 15% | X | X | X*0.15 | X*0.15 |
| **Total** | 100% | — | — | **X.X** | **X.X** |

## Step 6: Determine Winner

Based on weighted totals:
- If A > B by > 0.5: A wins clearly
- If B > A by > 0.5: B wins clearly
- If within 0.5: Too close to call, need more tests

## Step 7: Update Competition Record

Use Edit to add evaluation results to the competition record:

```markdown
## Evaluation Results

| Criterion | [A] | [B] |
|-----------|-----|-----|
| Correctness | X | X |
| Clarity | X | X |
| Efficiency | X | X |
| Robustness | X | X |
| **Weighted Total** | **X.X** | **X.X** |

## Winner
**[Version]** wins with score X.X vs X.X

## Evaluation Notes
- [Why correctness scores differed]
- [Why clarity scores differed]
- [Other observations]

## Recommendation
[Promote / Need more testing / Keep current champion]
```

## Step 8: Report Findings

Present evaluation to user:
- The scores for each version
- The winner and margin
- Recommendation for next steps
- Any insights about what made the difference
