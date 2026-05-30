---
name: handoff-open
description: Open a new cross-agent handoff thread and scaffold round-01 prompt.
argument-hint: "<slug> \"<one-line description>\""
allowed-tools:
  - Bash
  - Read
  - Write
---

# Open a Handoff Thread

1. Create `handoffs/active/<slug>/` if missing.
2. Copy `handoffs/templates/prompt.md` to `round-01-prompt.md`.
3. Fill frontmatter tokens (`thread`, `created`).
4. Keep body scaffold for the dispatcher to complete.
5. Do not overwrite existing prompt/result files.