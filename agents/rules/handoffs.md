# Cross-agent handoffs

Use file-based handoffs when work spans sessions or tools.

## When to use

- Receiver will not have current chat context.
- Work includes gated or destructive operations.
- Dispatcher wants a durable report at a known path.

## Path and naming rules

- Thread directory: `handoffs/active/<YYYY-MM-DD-slug>/`
- Prompt file: `round-NN-prompt.md`
- Result file: `round-NN-result.md`
- Round numbers are zero-padded (`01`, `02`, ...)

## Dispatcher rules

1. Create prompt from `handoffs/templates/prompt.md`.
2. Include all load-bearing context in the file.
3. Add explicit wait phrases for destructive phases.
4. Commit the prompt file.

## Executor rules

1. Read the latest prompt in the thread.
2. Respect gates and wait phrases.
3. Write result at the expected path.
4. Commit the result file.

## Shared constraints

- Never rewrite prior rounds; append new ones.
- Keep files public-safe; never include secrets.
- Close finished threads by moving to `handoffs/archive/`.