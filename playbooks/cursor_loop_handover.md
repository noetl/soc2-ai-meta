# Cursor/Codex Loop Handover

Use this when one agent prepares work and another executes it.

## Steps

1. Open a handoff thread under `handoffs/active/<slug>/`.
2. Write `round-01-prompt.md` with phased plan and explicit gates.
3. Hand exact prompt path to executor.
4. Executor writes `round-01-result.md`.
5. Dispatcher decides: close thread or open next round.

## Safety

- Keep handoff files secret-free.
- Never rewrite prior rounds.
- Use new rounds for clarifications and follow-up.