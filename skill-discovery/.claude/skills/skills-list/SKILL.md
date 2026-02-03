---
name: skills-list
description: Get a list of currently available skills that you can invoke to perform actions. Always check this list to see if something you want to do has an already well established pattern that can be reused.
---

# Available Skills

Any of these skills can be invoked by name via the Skill tool

---

```
name: skill-create
description: A description of how to create skills in the correct way for this project
```
---
```
name: buddy-system-status
description: Get a comprehensive summary of system activity including running processes, CPU usage, memory status, uptime, load averages, and top resource-consuming applications. Use this when the user wants to know what is running on their computer or wants a system health check.
```
---
```
name: buddy-check-disk-space
description: Check available disk space on the system. Displays storage capacity, used space, and available space for all mounted filesystems in a human-readable format. Use this when the user wants to know how much free disk space they have or needs storage information.
```
---
```
name: buddy-check-chrome
description: Check if Google Chrome is running on the system. Reports the number of Chrome processes, their combined CPU and memory usage, Chrome version, and details about each process type (main, GPU, network, storage, renderer, crashpad). Use this when the user wants to know if Chrome is running or needs information about Chrome browser processes.
```
---
```
name: buddy-terminate-chrome
description: Terminate all running Google Chrome processes on the system. This skill first identifies all Chrome processes (main, GPU, network, storage, renderer, crashpad handler), displays their count and resource usage, then gracefully terminates them using pkill, and verifies complete termination. Use this when the user wants to close Chrome, kill Chrome processes, or stop the Chrome browser.
```
---
