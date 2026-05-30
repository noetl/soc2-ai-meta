---
thread: REPLACE-yyyy-mm-dd-short-topic
round: 1
from: claude
to: codex
created: REPLACE-ISO8601-UTC
status: open
expects_result_at: round-01-result.md
# wait_phrase: "<human phrase required before destructive actions>"
---

# REPLACE: short title

## Background

- Repository paths to touch (`repos/<name>`).
- Relevant branch, SHA, PR, and file references.
- Any preconditions the executor must verify first.

## Phases

### Phase A - read-only verification

1. ...
2. ...

### Phase B - gated write actions

> ***Run only after explicit human go-ahead. Wait phrase: `REPLACE`.***

1. ...
2. ...

## FINAL REPORT

Write the result at `expects_result_at` with:

1. One H2 per phase in this prompt.
2. `## Issues observed`
3. `## Manual escalation needed`

Status must be `complete`, `partial`, or `blocked`.

## Hard constraints

- Never force-push.
- Never merge PRs unless explicitly instructed.
- Stop and report blockers instead of improvising.
- Never include secrets in handoff files.