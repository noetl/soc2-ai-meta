# Gemini Entry Point

Read these files at session start (in order):

1. `AGENTS.md` — mandatory rules for this repo
2. `memory/current.md` — active working state
3. `agents/profiles/gemini.md` — Gemini profile
4. `agents/rules/` — modular rule set

## Workflow highlights

- Use `agents/skills/` workflows when available.
- Use file-based handoffs in `handoffs/` for cross-session work.
- Keep product code changes inside `repos/<name>` only.

## Quick commands

- Add memory: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
- Compact memory: `./scripts/memory_compact.sh`
- Submodule status: `git submodule status --recursive`