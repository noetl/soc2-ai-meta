# Execution Model

Before implementing architecture changes, verify the proposal respects your platform boundaries.

## Core boundary checklist

- Gateway/service edge handles auth, routing, and protocol concerns.
- Workers execute atomic compute units.
- Workflow definitions are declarative and replayable.
- Shared state transport is explicit and reconstructable.
- Event/history log remains append-only source of truth.

## Practical rule

If a proposal moves business data touches into an API gateway/client layer or introduces hidden long-lived state without explicit replay semantics, redesign before implementation.