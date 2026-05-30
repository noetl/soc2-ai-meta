---
globs:
  - "repos/**"
---

# Submodule Rules

## Working in submodules

- Code changes happen **inside** the relevant `repos/<name>` submodule.
- Open PRs and merge in the submodule's upstream repository.
- Never move files between submodules from the meta-repo root.
- Never vendor code from one submodule into another.
- Keep pointer updates small and deterministic where possible.

## Updating pointers

- After upstream PRs are merged, update the pointer:
  ```
  git submodule sync --recursive
  git submodule update --init --recursive
  git submodule update --remote repos/<name>
  git add repos/<name>
  git commit -m "chore(sync): bump <name> to <short-sha>"
  ```
- Always verify the diff before committing pointer updates.

## Adding new submodules

- Add with: `git submodule add <remote-url> repos/<name>`
- Commit with: `chore(sync): add <name> submodule`
