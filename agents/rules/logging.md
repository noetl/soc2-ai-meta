# Logging Hygiene

- Keep high-frequency paths quiet by default.
- Use INFO logs for state transitions, not polling loops.
- Prefer DEBUG with sampling/rate-limits for repetitive internals.
- For any change likely to increase log volume, include a brief flood-risk check in the PR notes.