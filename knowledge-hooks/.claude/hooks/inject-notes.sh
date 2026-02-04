#!/bin/bash
#
# Knowledge Hook: Inject Notes Database Content
#
# This hook fires when notes-buddy is invoked. It reads the notes database
# path from notes-config.yaml, then reads all notes and injects them into
# the agent's context window via the additionalContext JSON field.
#
# This gives notes-buddy immediate knowledge of all notes without needing
# to fetch them at runtime.

set -e

# Function to output JSON with additionalContext
output_json() {
    local content="$1"
    # Use jq if available for proper escaping, otherwise use python
    if command -v jq &> /dev/null; then
        jq -n --arg ctx "$content" '{hookSpecificOutput: {hookEventName: "SubagentStart", additionalContext: $ctx}}'
    elif command -v python3 &> /dev/null; then
        python3 -c "import json; print(json.dumps({'hookSpecificOutput': {'hookEventName': 'SubagentStart', 'additionalContext': '''$content'''}}))"
    else
        # Fallback: basic escaping (may not handle all edge cases)
        escaped=$(echo "$content" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
        echo "{\"hookSpecificOutput\":{\"hookEventName\":\"SubagentStart\",\"additionalContext\":\"$escaped\"}}"
    fi
}

# Use CLAUDE_PROJECT_DIR if available, otherwise try to find config
if [ -n "$CLAUDE_PROJECT_DIR" ]; then
    CONFIG_FILE="$CLAUDE_PROJECT_DIR/notes-config.yaml"
    EXAMPLE_FILE="$CLAUDE_PROJECT_DIR/notes-config.example.yaml"
elif [ -f "notes-config.yaml" ]; then
    CONFIG_FILE="notes-config.yaml"
    EXAMPLE_FILE="notes-config.example.yaml"
elif [ -f "../notes-config.yaml" ]; then
    CONFIG_FILE="../notes-config.yaml"
    EXAMPLE_FILE="../notes-config.example.yaml"
else
    CONFIG_FILE=""
fi

# Handle missing config file
if [ -z "$CONFIG_FILE" ] || [ ! -f "$CONFIG_FILE" ]; then
    CONTENT="# Notes Configuration Required

**notes-config.yaml not found.**

To get started:
1. Copy \`notes-config.example.yaml\` to \`notes-config.yaml\`
2. Edit \`notes-config.yaml\` and set your preferred notes directory path

Or ask me to help you set it up!"
    output_json "$CONTENT"
    exit 0
fi

# Parse the notes_path from YAML (simple grep, avoids dependencies)
NOTES_PATH=$(grep "^notes_path:" "$CONFIG_FILE" | sed 's/notes_path:[[:space:]]*//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//')

# Get the directory containing the config file for relative path resolution
CONFIG_DIR=$(dirname "$CONFIG_FILE")

# Handle relative paths and ~ expansion
if [[ "$NOTES_PATH" == ~* ]]; then
    NOTES_PATH="${NOTES_PATH/#\~/$HOME}"
elif [[ "$NOTES_PATH" == ./* ]]; then
    NOTES_PATH="$CONFIG_DIR/${NOTES_PATH#./}"
elif [[ "$NOTES_PATH" != /* ]]; then
    # Relative path without ./
    NOTES_PATH="$CONFIG_DIR/$NOTES_PATH"
fi

# Check if notes directory exists
if [ ! -d "$NOTES_PATH" ]; then
    CONTENT="# Notes Database Status

**Notes directory not found:** \`$NOTES_PATH\`

The database hasn't been initialized yet. Use the \`notes-add\` skill to create your first note, which will initialize the database."
    output_json "$CONTENT"
    exit 0
fi

# Check if index exists
INDEX_FILE="$NOTES_PATH/index.md"
if [ ! -f "$INDEX_FILE" ]; then
    CONTENT="# Notes Database Status

**Notes directory exists but no index found:** \`$NOTES_PATH\`

The database needs initialization. Use the \`notes-add\` skill to create your first note."
    output_json "$CONTENT"
    exit 0
fi

# Build the notes database content
CONTENT="# Current Notes Database

**Database Location:** \`$NOTES_PATH\`

---

## Index

$(cat "$INDEX_FILE")

---

## Note Contents

"

# Read each .md file except index.md
for note_file in "$NOTES_PATH"/*.md; do
    if [ -f "$note_file" ] && [ "$(basename "$note_file")" != "index.md" ]; then
        CONTENT="$CONTENT### $(basename "$note_file" .md)

$(cat "$note_file")

---

"
    fi
done

CONTENT="$CONTENT*End of notes database snapshot*"

# Output as JSON
output_json "$CONTENT"
