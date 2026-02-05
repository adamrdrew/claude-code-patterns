---
name: skill-promote
description: Promote a winning skill version to champion status, archiving the previous champion
---

# Skill Promotion

Promote a competition winner to champion status.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Identify the Winner

Determine:
1. **Winner**: The skill version to promote (e.g., `format-v2`)
2. **Skill name**: The base skill name (e.g., `format`)

If unclear, check recent competition results in `arena/results/`.

## Step 2: Verify Competition Evidence

Use Read to load the competition record that supports this promotion.

Confirm:
- The winner actually won the competition
- The margin was sufficient (> 0.5 weighted score difference)
- No concerns were raised about the evaluation

If evidence is insufficient, report the concern.

## Step 3: Check Current Champion

Use Glob to check if a champion exists:
```
arena/champions/<skill-name>/SKILL.md
```

If exists:
- Read the current champion
- Note its version for archival

If no champion exists, this is the first promotion.

## Step 4: Archive Current Champion (if exists)

If there's an existing champion:

1. Read the current champion content
2. Determine its version (from content or infer as `v0`)
3. Verify it exists in `arena/competitors/` as well
   - If not, copy it there for preservation

The champion should always also exist in competitors.

## Step 5: Promote the Winner

1. Read the winning version from `arena/competitors/<winner>/SKILL.md`
2. Create/update `arena/champions/<skill-name>/SKILL.md` with:
   - The winner's content
   - Updated description noting it's the current champion
   - Promotion date in a comment

## Step 6: Create Promotion Record

Create or append to `arena/champions/<skill-name>/HISTORY.md`:

```markdown
# [Skill Name] Champion History

## Current Champion
**Version:** [winner version]
**Promoted:** [date]
**Previous:** [previous champion version or "None"]

## Promotion Record

### [Date] - [winner] promoted
- **Competition:** [link to results file]
- **Margin:** [score difference]
- **Key improvement:** [what made it better]

[Previous promotions below...]
```

## Step 7: Verify Promotion

Use Read to confirm:
1. The champion file contains the winning version
2. The history is updated
3. The old champion is preserved in competitors

## Step 8: Report Promotion

Announce the promotion:

```
Promotion Complete

Skill: [name]
New Champion: [winner version]
Previous Champion: [old version]

The winning version is now active at:
  arena/champions/[name]/SKILL.md

Competition evidence:
  arena/results/[competition file]

Champion history:
  arena/champions/[name]/HISTORY.md
```
