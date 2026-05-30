# Wiki Maintenance Rule

Documentation should move with code, not as a delayed cleanup.

## Rule 1: first touch coverage

If a module has no dedicated docs page and you introduce substantive behavior, create that page before merge.

## Rule 2: update docs with code

When public surface changes (API, config, schema, behavior), update docs in the same change set.

## Rule 3: pointer bump check

When bumping submodule pointers in the meta-repo, verify docs coverage remains accurate for landed changes.