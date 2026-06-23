# noetl infrastructure baseline for SOC2 audit
- Timestamp: 2026-06-23T00:19:41Z
- Author: Kadyapam
- Tags: soc2,infrastructure,inventory,gke,noetl

## Summary
noetl runs on GKE Autopilot (noetl-cluster, us-central1) under GCP project noetl-demo-19700101 (Adiona.org org). Core services: noetl-server (Rust v3.x, orchestrator+event store), noetl-worker (Rust, KEDA-scaled), noetl-gateway (Rust), noetl-cli (4.9.0). Data stores: Cloud SQL PostgreSQL (HA, PITR, IAM auth, PgBouncer pool), NATS JetStream (single pod — HA gap), EHDB (in development). GCP services: GKE, Cloud SQL, Cloud KMS, Secret Manager, Artifact Registry, Cloud Logging, Managed Prometheus. External: Cloudflare (DNS/CDN). Deploy: Helm charts in noetl/ops. Container runtime: Podman + kind (dev), GKE (prod). Rust-only focus as of 2026-06-04.

## Actions
-

## Repos
-

## Related
-
