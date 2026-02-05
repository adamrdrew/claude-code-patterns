# constraint: no-delete-without-backup
severity: block
applies_to: all

## Description

Never delete files or data without first ensuring a backup exists or creating one. This prevents accidental data loss from irreversible delete operations.

## Check

Before any delete operation, verify ONE of:

1. **Backup already exists**: A recent backup of the file/data exists in a backup location
2. **Backup created**: A backup was created as part of this operation before deletion
3. **Explicitly temporary**: The data is explicitly temporary (e.g., `.tmp`, cache files, build artifacts)
4. **User confirmed no backup needed**: User explicitly stated backup is not required for this specific deletion

## Violation Response

If no backup condition is met:

1. BLOCK the delete operation
2. Report: "Cannot delete without backup. Please create a backup first or confirm this data is temporary/expendable."
3. Suggest: Copy files to a backup location before deletion

## Examples

### Violation
```
Action: Delete user-data.json
Check: No backup exists, not a temp file, no user confirmation
Result: BLOCKED
```

### Compliance
```
Action: Delete user-data.json
Check: Backup exists at backups/user-data.json.bak
Result: PASS
```

### Compliance (temporary)
```
Action: Delete *.tmp files
Check: Files are explicitly temporary (.tmp extension)
Result: PASS
```
