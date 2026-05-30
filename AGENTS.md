# {{PROJECT_NAME}} AI Instructions

## Repo purpose

This repository is the coordination layer and shared memory for the {{PROJECT_NAME}} ecosystem. It contains:

- All ecosystem repos as **git submodules** under `repos/`
- A Git-tracked **memory system** under `memory/`
- **Sync notes** under `sync/`
- **Playbooks** under `playbooks/`
- **Agent infrastructure** under `agents/`
- **Cross-agent handoffs** under `handoffs/`

## Safety rules

- This repository is public. Never store secrets, tokens, credentials, or sensitive values.
- Do not store product code here — product code lives in the submodule repos.
- Never rewrite history on `main`.
- Memory updates must be append-only through Git history.

## Allowed content

Only the following may be committed to this repo:

- AI instruction files (CLAUDE.md, AGENTS.md, .claude/, agents/)
- Orchestration docs and checklists (playbooks/, sync/)
- Submodule pointer updates (repos/*)
- AI memory entries and compactions (memory/)
- Handoff prompt/result files (handoffs/active/, handoffs/archive/, handoffs/templates/)

## Submodule workflow

- Make code changes **inside** the relevant `repos/<name>` submodule.
- Open PRs and merge in the submodule's upstream repository.
- After merge, update the submodule pointer here and commit with `chore(sync): bump <repo> to <sha>`.

## Commit conventions

- `memory(add): <topic>` — new memory inbox entry
- `memory(compact): <scope or date>` — compaction run
- `memory(curate): <scope>` — manual current.md refresh
- `chore(sync): bump <repo> to <short-sha>` — submodule pointer update
- `docs(agents): <description>` — instruction/agent doc changes
- `handoff(open): <slug>` — open handoff thread
- `handoff(result): <slug> round NN` — publish handoff result
- `handoff(close): <slug>` — archive completed thread

## Memory workflow

1. Add entries: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
2. Commit: `git add memory/inbox && git commit -m "memory(add): <topic>"`
3. Compact: `./scripts/memory_compact.sh`
4. Commit: `git add memory && git commit -m "memory(compact): <scope>"`

## Agent rules

All agents must:

- Read `AGENTS.md` at session start
- Read `memory/current.md` for active working state
- Follow commit conventions above
- Never store secrets or credentials
- Work inside submodules for code changes
- Use the memory pipeline for decisions and outcomes
- Use file-based handoffs for multi-session or cross-agent work

Detailed modular rules are in `agents/rules/`. Behavioral profiles are in `agents/profiles/`.

## Handoff convention

When work spans sessions or tools:

1. Write prompt to `handoffs/active/<slug>/round-NN-prompt.md`
2. Execute based on that prompt only (self-contained brief)
3. Write report to `handoffs/active/<slug>/round-NN-result.md`
4. Open a new round instead of rewriting earlier files
5. Move completed thread to `handoffs/archive/<slug>/`

See `handoffs/README.md` and `agents/rules/handoffs.md`.
