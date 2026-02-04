# Teach Claude: Knowledge Hooks Pattern

This prompt teaches Claude Code how to implement the **Knowledge Hooks** pattern - a system that front-loads subagents with knowledge via hooks at invocation time.

---

## Prompt

I want you to set up a **Knowledge Hooks** pattern in this project. This pattern injects knowledge into a subagent's context before it starts processing, making it more token-efficient than runtime fetching.

### What This Pattern Does

- Uses Claude Code's hook system to run a script when a subagent starts
- The hook script reads data (files, databases, configs) and injects it as context
- The subagent receives complete, fresh data before it begins working
- More deterministic and token-efficient than having the agent fetch data at runtime

### Setup Instructions

#### 1. Add to CLAUDE.md

Add these instructions to the project's CLAUDE.md file:

```markdown
## Knowledge Hooks Pattern

This project uses the Knowledge Hooks pattern. The `[agent-name]` subagent receives injected knowledge at invocation via a hook.

### Invoking the Subagent
Use: `@"[agent-name] (agent)" [your request]`

### How the Hook Works
- When the subagent starts, the `SubagentStart` hook fires
- The hook script reads [data source] and injects it as context
- The subagent can answer questions using this pre-loaded knowledge
- For modifications, the subagent uses skills to update the data

### Configuration
- Config file: `[config-file-name]` - Specifies where data is stored
- Hook script: `.claude/hooks/[hook-script-name].sh`
```

#### 2. Create Directory Structure

```
.claude/
├── agents/
│   └── [agent-name].md
├── hooks/
│   └── inject-[data-type].sh
├── skills/
│   ├── [prefix]-add/
│   │   └── SKILL.md
│   ├── [prefix]-read/
│   │   └── SKILL.md
│   ├── [prefix]-list/
│   │   └── SKILL.md
│   └── [prefix]-delete/
│       └── SKILL.md
├── settings.json          # Hook configuration
└── settings.local.json    # Permissions
```

#### 3. Create the Agent Definition

Create `.claude/agents/[agent-name].md`:

```yaml
---
name: [agent-name]
description: [Brief description of what the agent does]
tools:
  - Skill
  - Read
  - Write
  - Edit
  - Bash
skills: []
color: blue
---
```

Note: `skills: []` is empty because knowledge comes from the hook, not preloaded skills.

The agent prompt should include:

- **Role description**: What the agent does
- **Operating Rules**: Safety constraints
- **Operating Procedure**:
  1. Check for injected context (look for a specific section header)
  2. If context is missing, help user set up the config file
  3. For queries, answer using the injected knowledge
  4. For modifications, use the appropriate skill
  5. Report results to the user

#### 4. Create the Hook Configuration

Create `.claude/settings.json`:

```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "[agent-name]",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/inject-[data-type].sh",
            "timeout": 5000
          }
        ]
      }
    ]
  }
}
```

#### 5. Create the Hook Script

Create `.claude/hooks/inject-[data-type].sh`:

```bash
#!/bin/bash

# Read configuration
CONFIG_FILE="$CLAUDE_PROJECT_DIR/[config-file-name]"

if [ ! -f "$CONFIG_FILE" ]; then
    echo '{"additionalContext": "## Setup Required\n\nNo config file found. Help the user create [config-file-name]."}'
    exit 0
fi

# Read the data source path from config
DATA_PATH=$(grep 'path:' "$CONFIG_FILE" | sed 's/path: *//' | sed 's/^ *//')

# Expand ~ and resolve relative paths
if [[ "$DATA_PATH" == ~* ]]; then
    DATA_PATH="${DATA_PATH/#\~/$HOME}"
elif [[ "$DATA_PATH" == ./* ]]; then
    DATA_PATH="$CLAUDE_PROJECT_DIR/${DATA_PATH#./}"
fi

# Build context from data
CONTEXT="## Current [Data Type] Database\n\n"

# Read and append data files
for file in "$DATA_PATH"/*.md; do
    if [ -f "$file" ]; then
        CONTEXT="$CONTEXT### $(basename "$file")\n\n"
        CONTEXT="$CONTEXT$(cat "$file")\n\n"
    fi
done

# Output JSON with escaped content
# Use jq if available, otherwise python3, otherwise basic escaping
if command -v jq &> /dev/null; then
    echo "{\"additionalContext\": $(echo -e "$CONTEXT" | jq -Rs .)}"
elif command -v python3 &> /dev/null; then
    echo "{\"additionalContext\": $(echo -e "$CONTEXT" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')}"
else
    ESCAPED=$(echo -e "$CONTEXT" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | tr '\n' ' ')
    echo "{\"additionalContext\": \"$ESCAPED\"}"
fi
```

Make the script executable:
```bash
chmod +x .claude/hooks/inject-[data-type].sh
```

#### 6. Create Example Config File

Create `[config-file-name].example`:

```yaml
# Path to your [data type] directory
# Can be absolute, relative (./), or use ~ for home directory
path: ./[data-directory]/
```

#### 7. Create CRUD Skills

Create skills for Create, Read, Update, Delete operations. Each skill should:
- Have a clear name and description in YAML frontmatter
- Define procedural steps for the operation
- Update any index files as needed

Example skill structure:
```yaml
---
name: [prefix]-add
description: Add a new [item] or update an existing one
---

# Add [Item]

## Procedure

1. Determine the [item] name from user input
2. Check if [item] already exists
3. Write the [item] content to file
4. Update the index
5. Report success
```

#### 8. Configure Permissions

Create `.claude/settings.local.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(cat:*)",
      "Bash(mkdir:*)",
      "Bash(ls:*)",
      "Bash(rm:*)",
      "Bash(echo:*)"
    ]
  }
}
```

### After Setup

Once complete, report to the user:

**Knowledge Hooks pattern is ready!**

You can now:
- Invoke the subagent: `@"[agent-name] (agent)" [request]`
- The subagent receives the current [data] snapshot at startup
- Query existing [data] without any fetching delay
- Modify [data] using the provided skills

Setup required:
1. Copy `[config-file-name].example` to `[config-file-name]`
2. Set the path to your [data] directory
3. The hook will inject [data] on each subagent invocation

Available skills:
- `[prefix]-add` - Add or update [items]
- `[prefix]-read` - Read a specific [item]
- `[prefix]-list` - List all [items]
- `[prefix]-delete` - Delete an [item]

The hook injects fresh data every time you invoke the subagent.