---
name: issue-close
description: Close a tracked issue only after acceptance criteria are met.
argument-hint: "<number>"
allowed-tools:
  - Bash
  - Read
---

# Close Tracked Issue

1. Read issue and verify all goal bullets are satisfied.
2. Identify landing PR(s) and pointer bump commit(s).
3. Close with citation comment referencing those artifacts.
4. Do not close on intent only.