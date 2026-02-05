---
name: ceremony-deploy
description: Perform a deployment with full ceremony - witness, wait, confirm, execute, record
---

# Ceremonial Deployment

Perform a production deployment with full deliberation and audit trail.

Use TaskCreate to create a task for each step below, then execute them in order. Mark each task `in_progress` when starting and `completed` when done using TaskUpdate.

## Step 1: Witness the Intent

Acknowledge the deployment request formally:

```markdown
## Ceremony: Deployment Request

**Timestamp:** [current datetime]
**Requested By:** user
**Witnessed By:** executor

### Deployment Details
- **What:** [what is being deployed]
- **Where:** [target environment]
- **Version:** [version/commit/tag]

### Potential Impact
- [Impact 1: e.g., "Users may experience brief downtime"]
- [Impact 2: e.g., "New features will be live"]
- [Impact 3: e.g., "Rollback available via [method]"]

### Pre-Deployment Checklist
- [ ] Tests passing
- [ ] Code reviewed
- [ ] Backup available
- [ ] Rollback plan ready

### Witness Statement
I have witnessed and recorded this deployment request.
A ceremony is now required to proceed.
```

Present this to the user.

## Step 2: Verify Pre-Conditions

Check deployment readiness:

```markdown
## Pre-Deployment Verification

Before proceeding, confirm the following:

1. **Tests:** Are all tests passing?
2. **Review:** Has the code been reviewed?
3. **Backup:** Is there a backup or snapshot?
4. **Rollback:** Do you know how to roll back?
5. **Timing:** Is this a good time to deploy?

Please confirm each item or identify any concerns.
```

Wait for user to acknowledge pre-conditions.

## Step 3: Begin Wait Period

Enforce a 30-second wait:

```markdown
## Wait Period

A mandatory 30-second reflection period is now in effect.

Consider:
- Is everything ready for this deployment?
- Who needs to be notified?
- What will you do if something goes wrong?
- Is there anything else to check first?

**Wait began:** [time]
**Wait ends:** [time + 30s]
```

## Step 4: Request Confirmation

After the wait, require explicit confirmation:

```markdown
## Confirmation Required

The wait period has completed.

To proceed with deployment, type exactly:

**"Deploy to [environment]"**

This confirms you:
- Are ready to deploy
- Accept the potential impact
- Have a rollback plan

To cancel, type: **"cancel"**
```

## Step 5: Verify Confirmation

Check the confirmation is valid and exact.

If invalid:
```
Confirmation not recognized. The exact phrase is required.
Please type: "Deploy to [environment]"
Or say "cancel" to abort.
```

## Step 6: Execute Deployment

Only after valid confirmation:

```markdown
## Executing Deployment

**Confirmation received:** [timestamp]
**Deploying:** [what]
**Target:** [environment]

Beginning deployment...
```

Execute the deployment commands or report what should be executed:

```markdown
## Deployment Commands

The following deployment would be executed:
[Deployment commands or description]

**Note:** Actual deployment execution depends on your CI/CD setup.
```

```markdown
## Deployment Status

**Started:** [time]
**Completed:** [time]
**Status:** [Success/Failed]
```

## Step 7: Post-Deployment Verification

Prompt for verification:

```markdown
## Post-Deployment Verification

Please verify the deployment:

1. Application accessible?
2. Key features working?
3. Logs show expected behavior?
4. Monitoring normal?

Report any issues immediately.
```

## Step 8: Create Ceremony Record

Write to `ceremony-log/[date]-deploy-[env].md`:

```markdown
# Ceremony Record: Deployment

**Date:** [full datetime]
**Type:** Deployment
**Target:** [environment]
**Version:** [version]

## Request
- **Requested By:** user
- **Witnessed By:** executor
- **Request Time:** [timestamp]

## Pre-Conditions
- Tests: [status]
- Review: [status]
- Backup: [status]
- Rollback: [plan]

## Wait Period
- **Duration:** 30 seconds
- **Completed:** [time]

## Confirmation
- **Phrase:** "Deploy to [environment]"
- **Received:** [time]

## Execution
- **Started:** [time]
- **Completed:** [time]
- **Status:** [Success/Failed]

## Post-Deployment
- **Verification:** [status]
- **Issues:** [any issues]

---
*Ceremony conducted by executor agent*
```

## Step 9: Update Index and Report

Append to `ceremony-log/index.md` and report completion:

```markdown
## Ceremony Complete

**Action:** Deployment to [environment]
**Version:** [version]
**Status:** [Success/Failed]
**Record:** ceremony-log/[filename].md

This deployment has been permanently documented.
```
