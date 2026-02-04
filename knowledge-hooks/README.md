# 🪝 Knowledge Hooks

In this pattern we use hooks to front-load a subagent with knowledge before it runs. The subagent doesn't have to fetch knowledge at runtime — it's already in the context window, ready to use.

## 🎯 The Problem This Solves

It's common to need to give a subagent domain-specific information. The simplest approach is to put it directly in the agent definition (`.claude/agents/*.md`). That works, but it gets unruly and violates separation of concerns. A more flexible approach is to use skills. But what if the knowledge is:

- **Dynamic** — it changes over time and needs to be fresh
- **External** — it lives outside the project repo
- **User-specific** — each user has their own data in their own location

You *could* have the subagent fetch this information at runtime. Have a skill that reads a config file, resolves a path, reads the data. But now you're spending tokens just doing the lookup work. And it's not deterministic — the agent might make mistakes or take a different path each time.

Here's a concrete example: you want to create a personal assistant subagent that works with a database of information — contacts, projects, notes. You want it to be a plugin so others can use it. And you want users to be able to configure where their database is stored. How do you solve that cleanly?

**Hooks.**

You have a config file in the project that says where the database lives. A hook fires when the subagent is invoked, reads the config, fetches the data, and injects it into the subagent's context window. The subagent starts fully informed. No fetching, no token overhead for lookups, no non-determinism.

## 🔍 About the Pattern

At a high level the pattern is simple:

1. Create a config file that users edit to specify their data location
2. Create a hook that fires when the subagent starts (`SubagentStart` event)
3. The hook reads the config, fetches the data, and outputs it
4. The output becomes part of the subagent's context

## 💡 The Example

In this example we have a subagent called [Notes Buddy](.claude/agents/notes-buddy.md). It manages a simple notes database stored as markdown files. Users can store notes anywhere they like — the location is configurable.

### 🚀 First Run

The first time you invoke Notes Buddy, there's no config yet:

```
❯ @"notes-buddy (agent)" What notes do I have?

⏺ notes-buddy(Check notes)
  ⎿  Done (2 tool uses · 1.8k tokens · 5s)

⏺ I see you haven't configured your notes location yet. Where would you
  like to store your notes? I can use `./notes` in the current directory,
  or you can specify another path like `~/Documents/notes`.
```

Notes Buddy detects the missing config and offers to set it up. Once configured, it creates `notes-config.yaml` from the example template.

### ✨ After Setup

Here's the magic: when you invoke Notes Buddy after setup, a hook reads your `notes-config.yaml`, finds your notes database, reads all the notes, and injects them into the subagent's context. Notes Buddy starts the conversation already knowing everything in your notes.

```
❯ @"notes-buddy (agent)" What notes do I have about my trip to Japan?

⏺ notes-buddy(Search notes for Japan trip)
  ⎿  Done (0 tool uses · 2.1k tokens · 3s)

⏺ Based on your notes, here's what you have about Japan:

  From your "travel-plans" note:
  - Tokyo: April 15-20
  - Kyoto: April 20-23
  - Osaka: April 23-25

  From your "packing-list" note:
  - JR Pass reservation confirmed
  - Need to get power adapter
  - Download offline maps
```

Notice: **0 tool uses**. Notes Buddy didn't have to go read any files. The hook already injected all the notes into context before the subagent started. It just answered from what it already knew.

Now let's add a note:

```
❯ @"notes-buddy (agent)" Add a note about restaurants to try in Tokyo

⏺ notes-buddy(Add Tokyo restaurants note)
  ⎿  Done (4 tool uses · 3.2k tokens · 8s)

⏺ Created a new note "tokyo-restaurants" with the following:

  # Tokyo Restaurants

  Restaurants to try in Tokyo.

  (Add your recommendations here)

  ---
  *Last updated: Feb 4, 2026*

  The note is ready for you to fill in. Just tell me what restaurants
  to add!
```

The Agent used skills to write the note file and update the index. Next time you invoke Notes Buddy, the hook will pick up this new note and inject it along with all the others.

## 🏗️ Constructing the Pattern

The key pillars of this pattern are:

1. A config file for user-specific settings
2. A hook script that reads the config and outputs knowledge
3. Hook configuration that fires the script when the Agent starts

### ⚙️ The Config File

Users copy [`notes-config.example.yaml`](notes-config.example.yaml) to `notes-config.yaml` and specify where their notes live:

```yaml
notes_path: ./notes
```

Simple YAML. Can be a relative path, absolute path, or use `~` for home directory. The config file is gitignored so each user has their own settings.

### 📜 The Hook Script

[`.claude/hooks/inject-notes.sh`](.claude/hooks/inject-notes.sh) does the heavy lifting:

1. Finds and reads `notes-config.yaml`
2. Extracts the `notes_path` value
3. Reads the notes index and all note files
4. Outputs everything as formatted markdown

Whatever the script writes to stdout gets injected into the subagent's context. The script handles edge cases — missing config, uninitialized database — and outputs helpful messages for those states.

### 🔧 Hook Configuration

[`.claude/settings.json`](.claude/settings.json) wires it all together:

```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "notes-buddy",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/inject-notes.sh",
            "timeout": 5000
          }
        ]
      }
    ]
  }
}
```

Key points:

- **`SubagentStart`** — The event that fires when a subagent is spawned (not `AgentStart` or similar)
- **`matcher`** — A regex pattern matching the subagent name. Use `"*"` to match all subagents, or a specific name like `"notes-buddy"`
- **`$CLAUDE_PROJECT_DIR`** — Environment variable for the project root; ensures paths resolve correctly
- **`timeout`** — Optional; milliseconds before the hook times out (default is 600000)

### 📋 Hook Input/Output Format

This is the tricky part that's easy to get wrong. Claude Code hooks have specific input/output requirements.

**Input:** Your hook script receives JSON on stdin with context about the event. For `SubagentStart`, this includes the agent name and other metadata. However, for simple injection scripts like ours, we don't need to read the input — we just need to output the right format.

**Output:** This is critical. For `SubagentStart` hooks that inject context, you must output JSON with this exact structure:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "SubagentStart",
    "additionalContext": "Your content here as a string"
  }
}
```

The `additionalContext` field contains the content that gets injected into the subagent's context window. It must be a properly escaped JSON string.

**Common Mistakes:**

1. **Plain text output** — If you just `echo` content without the JSON wrapper, it won't be injected. The hook will appear to run but nothing will reach the subagent.

2. **Improper JSON escaping** — The `additionalContext` value must be a valid JSON string. Newlines become `\n`, quotes become `\"`, backslashes become `\\`. Use `jq` or a proper JSON encoder.

3. **Wrong structure** — The nested `hookSpecificOutput` with `hookEventName` is required. Simpler structures like `{"context": "..."}` won't work.

**Robust JSON Output:**

Our script handles this with a helper function that uses `jq` for proper escaping:

```bash
output_json() {
    local content="$1"
    jq -n --arg ctx "$content" \
        '{hookSpecificOutput: {hookEventName: "SubagentStart", additionalContext: $ctx}}'
}
```

The `--arg` flag properly escapes the content string. This handles multi-line markdown, quotes, and special characters correctly.

**Environment Variables:**

Claude Code provides useful environment variables to hook scripts:

- `CLAUDE_PROJECT_DIR` — The project root directory (where `.claude/` lives)
- Standard environment like `HOME`, `PATH`, etc.

Always use `$CLAUDE_PROJECT_DIR` for paths to ensure the script works regardless of the current working directory.

**Exit Codes:**

Hook behavior depends on the exit code:

| Exit Code | Behavior |
|-----------|----------|
| `0` | Success — stdout is parsed for JSON output |
| `2` | Blocking error — for events that support blocking (like `PreToolUse`), this prevents the action |
| Other | Non-blocking error — stderr is shown in verbose mode, execution continues |

For `SubagentStart` hooks like ours, exit code 0 with proper JSON injects context. Exit code 2 would show an error but can't block subagent startup.

**Debugging Hooks:**

If your hook isn't working:

1. Add temporary logging to verify the hook fires: `echo "Hook fired" >> /tmp/hook-debug.log`
2. Log your JSON output before printing it to verify the structure
3. Test your JSON output with `jq` to verify it's valid: `echo "$output" | jq .`
4. Check that the `matcher` in settings.json matches your subagent name exactly
5. Run Claude Code with `claude --debug` to see hook execution details

## ⚖️ Knowledge Hooks vs Runtime Fetching

| Approach | Tokens for Lookup | Determinism | Freshness |
|----------|-------------------|-------------|-----------|
| **Knowledge Hooks** | Zero | High | Fresh at invocation |
| **Runtime Fetching** | Variable | Lower | Fresh at read time |

Knowledge Hooks trade the freshness of runtime fetching for token efficiency and determinism. Since the hook runs at invocation, data is as fresh as when you started the conversation. For data that might change *during* a conversation, runtime fetching is still appropriate.

## 🔌 For Plugin Developers

This pattern is particularly useful for plugins. Your plugin can ship with:

- A config example file that users customize
- A hook script that reads user config
- A subagent that expects knowledge to be pre-loaded

Users install your plugin, copy the example config, edit it once, and the hook ensures their data is always available to the subagent. No hard-coded paths, no assumptions about where user data lives.

## 🚀 Going Further

The hook in this example runs a bash script, but hooks can run any executable. You could:

- Write the hook in Python for more complex data processing
- Query an API to fetch live data
- Read from multiple sources and combine them
- Apply transformations or filtering before injection

You could also combine Knowledge Hooks with the Skill Discovery pattern. Have the hook inject a curated summary, with skills available for when the subagent needs to dig deeper. Best of both worlds — efficient context for common cases, full access when needed.

The key insight is that hooks let you front-load work that would otherwise happen at runtime. Anything you can compute before the subagent starts is context you don't have to spend tokens fetching later.

## 🚀 Use This Pattern

Want to use this pattern in your own project? Copy this link into Claude Code and it will set up everything for you:

```
https://raw.githubusercontent.com/adamrdrew/claude-code-patterns/master/knowledge-hooks/teach-claude.md
```

Claude will read the instructions and configure your project with the Knowledge Hooks pattern, including the hook script, settings configuration, and a starter subagent.

## 📖 Further Reading

- [Hooks reference](https://code.claude.com/docs/en/hooks) - Official Claude Code hooks documentation
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) - Subagents documentation with preload skills info
- [Claude Code settings](https://code.claude.com/docs/en/settings) - Configuration reference
- [How to configure hooks](https://claude.com/blog/how-to-configure-hooks) - Anthropic blog post on hooks
