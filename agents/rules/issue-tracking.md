# Issue Tracking

Use issues as the durable store for non-trivial tasks that may outlive one session.

## Open an issue when

- Work needs follow-up in a later session.
- Work is blocked on external action or human decision.
- Multiple agents may touch the same task.

## Issue body shape

Use these sections in this order:

1. `## Context`
2. `## Goal`
3. `## Pointers`
4. `## Blocked on`

## Update rules

- Comment when work starts, PR opens, and PR merges.
- Include pointer bump commit references when relevant.
- Close only after acceptance criteria are satisfied.

## Safety

- Never include secrets or sensitive values.
- Avoid duplicate issues; search open issues before creating a new one.