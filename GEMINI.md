# Gemini Entry Point

Read these files at session start (in order):

1. `AGENTS.md` — mandatory rules for this repo
2. `agents/rules/execution-model.md` — architecture and boundary guardrails
3. `memory/current.md` — active working state
4. `agents/profiles/gemini.md` — Gemini profile
5. `agents/rules/` — modular rule set
6. Open tracked work items, if your project uses them
7. `sync/issues/` — in-flight coordination notes, if your project uses them
8. Linked wiki/doc surfaces for impacted areas, if your project uses them

## Workflow highlights

- Use `agents/skills/` workflows when available.
- Use file-based handoffs in `handoffs/` for cross-session work.
- Keep product code changes inside the project source tree unless this repo is intentionally forked into an active project.
- Keep local memory, issues/tickets, and docs memory synchronized for substantive changes when those systems are in use.

## Quick checks

- Verify local memory and open tasks are aligned before starting work.
- Verify impacted wiki/confluence pages are identified before pointer bumps when those systems are in use.
- Confirm tracked issue/ticket updates and docs updates for changed public surfaces when those systems are in use.

## Quick commands

- Add memory: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
- Compact memory: `./scripts/memory_compact.sh`
- Submodule status: `git submodule status --recursive`