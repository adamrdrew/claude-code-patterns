# constraint: audit-config-changes
severity: audit
applies_to: all

## Description

All changes to configuration files must be logged for audit purposes. This creates an audit trail of configuration modifications for troubleshooting and compliance.

## Check

When modifying any configuration file:
- `*.config`, `*.json`, `*.yaml`, `*.yml`, `*.toml`, `*.ini`
- Files in `config/`, `.config/`, `settings/` directories
- Environment files: `.env*`

Record:
1. What file was modified
2. What was changed (before/after summary)
3. When the change was made
4. Why the change was made (from context)

## Violation Response

This is an audit constraint (severity: audit), so violations don't block actions.

If audit logging is not performed:
1. ALLOW the operation to proceed
2. LOG: "Configuration change not audited: [file]"
3. Recommend: Record the change in the audit log

## Audit Log Format

Changes should be noted in the response or logged:

```
CONFIG AUDIT:
- File: [path]
- Change: [summary of modification]
- Reason: [why this change was made]
```

## Examples

### Proper Audit
```
Action: Modify config.json to change timeout from 30 to 60
Audit: "CONFIG AUDIT: config.json - timeout: 30→60 - User requested longer timeout"
Result: PASS (audited)
```

### Missing Audit
```
Action: Modify config.json (no audit logged)
Result: PASS (but logged as unaudited for review)
```
