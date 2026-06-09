# Cross-Project Change Playbook

Canonical checklist for changes spanning multiple repositories, services, or project areas.

## Inputs

- Feature/bug description
- Impacted repositories or project areas
- Required release channels
- Linked issue/ticket IDs (GitHub and/or Jira, if used)
- Linked docs memory targets (GitHub Wiki and/or Confluence, if used)

## Steps

1. Confirm impacted repositories or project areas.
2. Create branches in impacted repos.
3. Implement + validate per repo.
4. Open PRs and merge.
5. Update issue/ticket status and docs memory links.
6. Update any pointers or references this repo tracks.
7. Add a short sync note in `sync/`.

## Output

- List of merged PRs
- Final references or SHAs
- Linked issue/ticket updates
- Linked wiki/confluence updates
- Any follow-up release actions
