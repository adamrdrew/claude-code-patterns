#!/bin/bash
#
# Session Archaeology Hook: Inject Learnings at Session Start
#
# This hook fires when a session starts. It reads the learnings archive
# and injects a summary of recent and relevant learnings into the agent's
# context window.
#

set -e

# Function to output JSON with additionalContext
output_json() {
    local content="$1"
    if command -v jq &> /dev/null; then
        jq -n --arg ctx "$content" '{additionalContext: $ctx}'
    else
        # Fallback: basic escaping
        escaped=$(echo "$content" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
        echo "{\"additionalContext\":\"$escaped\"}"
    fi
}

# Determine learnings directory
if [ -n "$CLAUDE_PROJECT_DIR" ]; then
    LEARNINGS_DIR="$CLAUDE_PROJECT_DIR/learnings"
else
    LEARNINGS_DIR="./learnings"
fi

# Check if learnings directory exists
if [ ! -d "$LEARNINGS_DIR" ]; then
    CONTENT="# Session Archaeology

No learnings archive found yet. After completing work, use the \`extract-learnings\` skill to capture insights from this session.

*Learnings will accumulate in the \`learnings/\` directory.*"
    output_json "$CONTENT"
    exit 0
fi

# Check for index
INDEX_FILE="$LEARNINGS_DIR/index.md"
if [ ! -f "$INDEX_FILE" ]; then
    CONTENT="# Session Archaeology

Learnings directory exists but no index found. Use the \`extract-learnings\` skill to populate the archive.

*Location: $LEARNINGS_DIR*"
    output_json "$CONTENT"
    exit 0
fi

# Build learnings summary
CONTENT="# Institutional Knowledge

**From the Session Archaeology archive**

---

## Learnings Index

$(cat "$INDEX_FILE")

---

## Recent Learnings

"

# Get the 3 most recently modified learning files
RECENT_FILES=$(find "$LEARNINGS_DIR" -name "*.md" -not -name "index.md" -type f -exec stat -f "%m %N" {} \; 2>/dev/null | sort -rn | head -3 | cut -d' ' -f2-)

if [ -z "$RECENT_FILES" ]; then
    CONTENT="$CONTENT*No learnings captured yet.*"
else
    for file in $RECENT_FILES; do
        if [ -f "$file" ]; then
            FILENAME=$(basename "$file" .md)
            CONTENT="$CONTENT### $FILENAME

$(head -20 "$file")

---

"
        fi
    done
fi

CONTENT="$CONTENT
*These learnings were injected by the session-archaeology pattern. Use \`apply-learnings\` to find specific relevant learnings for your current task.*"

output_json "$CONTENT"
