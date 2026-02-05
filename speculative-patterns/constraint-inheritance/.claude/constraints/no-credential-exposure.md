# constraint: no-credential-exposure
severity: block
applies_to: all

## Description

Never output, log, or store credentials, API keys, passwords, or other secrets in plain text. This prevents accidental exposure of sensitive authentication material.

## Check

Before any output or write operation, verify:

1. **No secrets in output**: The output doesn't contain API keys, passwords, tokens, or credentials
2. **No secrets in logs**: Log messages don't include sensitive values
3. **No secrets in files**: Files being written don't contain unencrypted secrets
4. **Masked if necessary**: If secrets must be referenced, they are masked (e.g., `sk-...xxxx`)

Patterns to detect:
- API keys: `sk-`, `api_key=`, `apiKey:`
- Passwords: `password=`, `passwd:`, `pwd=`
- Tokens: `token=`, `bearer `, `auth:`
- Private keys: `-----BEGIN`, `PRIVATE KEY`
- Connection strings with passwords

## Violation Response

If credential exposure is detected:

1. BLOCK the output/write operation
2. Report: "Cannot output credentials. Please mask or remove sensitive values."
3. Suggest: Replace with masked version or environment variable reference

## Examples

### Violation
```
Action: Output "API key is sk-1234567890abcdef"
Check: Contains unmasked API key
Result: BLOCKED
```

### Compliance
```
Action: Output "API key is sk-...cdef (masked)"
Check: Key is properly masked
Result: PASS
```

### Compliance
```
Action: Output "API key is stored in $API_KEY environment variable"
Check: References variable, doesn't expose value
Result: PASS
```
