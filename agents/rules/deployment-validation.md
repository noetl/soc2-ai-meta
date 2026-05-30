# Deployment Validation Rule

For containerized/runtime-impacting changes, validate locally before shared environments.

## Validation order

1. Run unit/integration checks.
2. Build local artifact/image.
3. Deploy to local cluster/runtime.
4. Smoke test changed behavior.
5. Only then proceed to shared staging/production rollout.

## Exceptions

- Documentation-only changes.
- Non-runtime metadata updates.

When unsure, run local validation.