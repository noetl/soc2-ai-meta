---
name: handoff-result
description: Scaffold the matching result file for the latest handoff round.
argument-hint: "<slug>"
allowed-tools:
  - Bash
  - Read
  - Write
---

# Scaffold Handoff Result

1. Locate highest `round-NN-prompt.md` in `handoffs/active/<slug>/`.
2. Determine expected result path (default `round-NN-result.md`).
3. Copy `handoffs/templates/result.md` to that path.
4. Fill frontmatter tokens and set `status: partial` initially.
5. Never overwrite existing result files.