# Knowledge Hooks Pattern

## Overview

This pattern demonstrates using hooks to inject knowledge into a subagent's context at invocation time. The subagent receives fresh data before it starts processing, making it immediately informed without needing to fetch anything.

## Key Files

- `.claude/settings.json` - Hook configuration (SubagentStart hook for notes-buddy)
- `.claude/hooks/inject-notes.sh` - Script that reads config and injects notes database
- `.claude/agents/notes-buddy.md` - The notes assistant subagent
- `notes-config.example.yaml` - Template for user configuration

## Setup

1. Copy `notes-config.example.yaml` to `notes-config.yaml`
2. Edit `notes-config.yaml` and set your preferred `notes_path`
3. Invoke notes-buddy to start using it

Or just invoke notes-buddy — it will walk you through setup if config is missing.

## How It Works

1. User invokes `@"notes-buddy (agent)"`
2. The `SubagentStart` hook fires, matching "notes-buddy"
3. `inject-notes.sh` runs, reading `notes-config.yaml` for the database path
4. The script outputs the full notes database content
5. This output is injected into notes-buddy's context window
6. notes-buddy starts with complete knowledge of all notes

## Configuration

Edit `notes-config.yaml` to set your notes database location:

```yaml
notes_path: ./notes           # Relative to config file
notes_path: ~/Documents/notes # Home directory
notes_path: /absolute/path    # Absolute path
```

## Notes Database Structure

The notes directory (wherever configured) contains:
- `index.md` - Index of all notes with descriptions
- `<topic>.md` - Individual note files

## Available Skills

- **notes-add** - Add or update a note (also handles first-time setup)
- **notes-read** - Read a specific note
- **notes-list** - List all notes
- **notes-delete** - Delete a note

## Further Reading

- [Hooks reference](https://code.claude.com/docs/en/hooks) - Official Claude Code hooks documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation
- [Claude Code settings](https://code.claude.com/docs/en/settings) - Configuration reference
