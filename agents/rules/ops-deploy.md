# Ops Deploy Rule

Prefer repository playbooks/automation over ad-hoc deployment commands.

## Rules

- Keep operational manifests in the operations repository or designated infra location.
- Keep application/runtime source in product repositories.
- Use documented automation entry points for build/deploy steps.
- Document regenerate/apply/verify commands near the manifest source.