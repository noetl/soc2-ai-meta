# {{PROJECT_NAME}} AI Instructions

## Repo purpose

This repository is the coordination layer and shared memory for the {{PROJECT_NAME}} project. It can support a monorepo, linked repositories, or a forked starter workflow. It contains:

- Optional linked repos or subprojects under `repos/`
- A Git-tracked **memory system** under `memory/`
- **Sync notes** under `sync/`
- **Playbooks** under `playbooks/`
- **Agent infrastructure** under `agents/`
- **Cross-agent handoffs** under `handoffs/`

## Mission

- Orchestrate changes across project areas, repositories, or workstreams.
- Keep shared instructions, skills, and rules consistent.
- Maintain reproducible references for linked repos, releases, or other external dependencies.

## Foundational execution model

Before proposing architecture or workflow changes, verify this boundary:

- Gateway/service edge handles auth, routing, and protocol concerns.
- Workers execute atomic compute units.
- Workflow/playbook definitions remain declarative and replayable.
- Shared state transport is explicit and reconstructable.
- Event/history log remains append-only source of truth.

If a proposal moves business data touches into a gateway/client layer or introduces hidden long-lived runtime state without replay semantics, redesign before implementation.

## Safety rules

- This repository is public. Never store secrets, tokens, credentials, or sensitive values.
- Do not store product code here unless this repo is intentionally forked into a working project.
- Never rewrite history on `main`.
- Memory updates must be append-only through Git history.

## Hard rules

1. This repository is public. Never store secrets or sensitive values.
2. Do not store product code here.
3. Use this repo for orchestration docs, AI instructions, memory, handoffs, sync notes, and coordination updates.
4. Keep memory updates append-only through Git history.
5. Keep pointer updates minimal and deterministic.
6. Never rewrite history on `main`.
7. Do not edit previous handoff rounds; append new rounds only.
8. For substantive changes, update issue/ticket state and docs/wiki state in the same change set when those systems are in use.

## Allowed content

Only the following may be committed to this repo:

- AI instruction files (CLAUDE.md, AGENTS.md, .claude/, agents/)
- Orchestration docs and checklists (playbooks/, sync/)
- Pointer updates or repository-link updates (repos/*)
- AI memory entries and compactions (memory/)
- Handoff prompt/result files (handoffs/active/, handoffs/archive/, handoffs/templates/)

## Repository workflow

- Make code changes in the repository or project area that owns the code.
- Open PRs and merge in the upstream repository or main branch you actually use.
- After merge, update any pointer, link, or reference in this repo if your workflow tracks that state here.

## Commit conventions

- `memory(add): <topic>` — new memory inbox entry
- `memory(compact): <scope or date>` — compaction run
- `memory(curate): <scope>` — manual current.md refresh
- `chore(sync): bump <repo> to <short-sha>` — linked-repo or pointer update
- `docs(agents): <description>` — instruction/agent doc changes
- `handoff(open): <slug>` — open handoff thread
- `handoff(result): <slug> round NN` — publish handoff result
- `handoff(close): <slug>` — archive completed thread

## Memory workflow

1. Add entries: `./scripts/memory_add.sh "<title>" "<summary>" "<tags>"`
2. Commit: `git add memory/inbox && git commit -m "memory(add): <topic>"`
3. Compact: `./scripts/memory_compact.sh`
4. Commit: `git add memory && git commit -m "memory(compact): <scope>"`

## Extended memory systems

Use these as supported extensions to repository memory:

- GitHub Issues: durable issue lifecycle and acceptance criteria
- Jira: project management state and dependency tracking
- GitHub Wiki: repository-scoped technical memory
- Confluence: broader architecture and operations memory

Operational rule: when a substantive task progresses, update local memory and the linked issue/ticket/wiki in the same working session.

## Agent rules

All agents must:

- Read `AGENTS.md` at session start
- Read `memory/current.md` for active working state
- Follow commit conventions above
- Never store secrets or credentials
- Work in the source tree that owns the code for changes
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
