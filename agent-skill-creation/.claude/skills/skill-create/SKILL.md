---
name: skill-create
description: A description of how to create skills in the correct way for this project
---

# Creating Skills

To create a new skill use the TodoWrite tool to create a todo list and execute this process in order:

## Todo 1: Preperation
Descide on a name for your skill. The name must start with buddy- examples: buddy-list-processes buddy-find-port buddy-list-directories. 

Also decide on a description. It should be descriptive enough and long enough that you can tell exactly what the skill does and when to do it, but not too long. No more than a paragraph.

For the remainer of thi procedure we will refer to those as $skill_name and $skill_description.

## Todo 2: Create the Directory and File

Use the Bash tool to create .claude/skills/$skill_name and .claude/skills/$skill_name/SKILL.md

## Todo 3: Create the Contents of the Skill File
Use the Write tool to fill .claude/skills/$skill_name/SKILL.md with the skill definitions. Skill files are Markdown with YAML frontmatter.

Template:
```
---
name: $skill_name
description: $skill_description
---

Detailed skill instructions written in a sequential Todo list format.

```

Example:
```
---
name: buddy-list-process
description: Get the process list. Show all running processes on the sysem 
---

# List Processes
Use the TodoWrite tool to create a Todo list and exeute the following procedure

## Todo 1: Get the Process List
Use the Bash tool to run `ps aux`

## Todo 2: Report Back
Report the result of running the command back to the user. Do not alter or summarize it, unless asked to by the user.
```

## Todo 4: Add the Skill to the Skills List
1. Use the Read tool to read .claude/skills/skills-list/SKILL.md
2. Use the Edit tool to append your new skill's $skill_name and $skill_description to the list following the pattern observed in the existing skill list

Follow this procedure and you'll have a new skill to work with!