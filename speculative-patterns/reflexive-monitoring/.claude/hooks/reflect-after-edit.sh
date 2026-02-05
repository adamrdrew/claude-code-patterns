#!/bin/bash
#
# Reflexive Monitoring Hook: Reflect After Edit
#
# This hook fires after Edit tool usage. It reads the edit details from stdin
# and generates reflection prompts to inject into the agent's context.
#
# The reflection prompts encourage the agent to pause and evaluate:
# - Was this edit consistent with the approach?
# - Were there any issues introduced?
# - Should the agent continue or reconsider?

set -e

# Read the hook input from stdin
INPUT=$(cat)

# Extract file path from the input
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // "unknown file"')
FILE_NAME=$(basename "$FILE_PATH")

# Extract what was changed (old_string tells us what was replaced)
OLD_STRING=$(echo "$INPUT" | jq -r '.tool_input.old_string // ""' | head -c 100)
NEW_STRING=$(echo "$INPUT" | jq -r '.tool_input.new_string // ""' | head -c 100)

# Determine the type of change
if [ -z "$OLD_STRING" ] && [ -n "$NEW_STRING" ]; then
    CHANGE_TYPE="addition"
elif [ -n "$OLD_STRING" ] && [ -z "$NEW_STRING" ]; then
    CHANGE_TYPE="deletion"
else
    CHANGE_TYPE="modification"
fi

# Generate reflection content based on what was edited
REFLECTION="## Reflection Point

You just made a **$CHANGE_TYPE** to \`$FILE_NAME\`.

### Reflection Questions

Take a moment to consider:

1. **Intent Match**: Did this edit achieve what you intended?
2. **Side Effects**: Could this change affect other parts of the code?
3. **Consistency**: Is this consistent with your overall approach?
4. **Error Handling**: Have you considered edge cases and error conditions?
5. **Reversibility**: If this turns out to be wrong, how hard is it to undo?

### Quick Assessment

Rate your confidence in this edit:
- **High**: Proceed without hesitation
- **Medium**: Proceed but note any concerns
- **Low**: Consider pausing to think more deeply

---

*This reflection was injected by the reflexive-monitoring hook. Thoughtful coding leads to better outcomes.*"

# Output as JSON with additionalContext
if command -v jq &> /dev/null; then
    jq -n --arg ctx "$REFLECTION" '{additionalContext: $ctx}'
else
    # Fallback: basic escaping
    ESCAPED=$(echo "$REFLECTION" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
    echo "{\"additionalContext\":\"$ESCAPED\"}"
fi
