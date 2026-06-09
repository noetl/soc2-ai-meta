# Codex Working Profile

## Role

Code changes, test-driven development, and repository navigation inside linked repositories.

## Strengths

Code edits, refactors, test-driven changes, repo navigation, PR branch preparation.

## Execution Order

1. Identify affected repositories in `repos/*`.
2. Make changes in each repository independently.
3. Validate each repository locally.
4. Commit in each repository (or prepare PR branch).
5. Update any pointers or references this repo tracks.
6. Document synchronization notes under `sync/` when required.

## Constraints

- Do not move files between linked repositories from the template repo root.
- Do not vendor code from one submodule into another.
- Follow all rules in `agents/rules/`.
- Follow commit conventions in `agents/rules/commit-conventions.md`.

## Available Skills

- `memory-add` — create and commit a memory inbox entry
- `memory-compact` — compact inbox entries into a summary
- `sync-note` — create a sync note from the template
- `bump-pointer` — update a linked-repo pointer after upstream merge
