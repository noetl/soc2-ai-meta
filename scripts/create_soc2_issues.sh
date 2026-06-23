#!/usr/bin/env bash
set -euo pipefail

TOKEN="${GITHUB_TOKEN:-$(read -rsp "GitHub PAT: " t; echo "$t")}"
REPO="noetl/soc2-ai-meta"
API="https://api.github.com/repos/${REPO}/issues"

create_issue() {
  local title="$1"
  local body="$2"
  local labels="$3"
  curl -s -X POST "$API" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -d "{\"title\": $(echo "$title" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read().strip()))'), \"body\": $(echo "$body" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read().strip()))'), \"labels\": $labels}" \
    | python3 -c 'import sys,json; d=json.load(sys.stdin); n=str(d["number"]); t=d["title"]; u=d["html_url"]; print("#"+n+" "+t+" -> "+u)'
}

echo "Creating SOC2 compliance issues in $REPO..."

create_issue \
  "[SOC2-CC1/CC2] Write and ratify Security Policy" \
  "## Context
noetl lacks a written security policy covering acceptable use, data classification, access management, and incident response overview.

## Goal
Produce a ratified Security Policy document covering:
- Acceptable use of noetl infrastructure
- Data classification tiers (see [Data Flow wiki](https://github.com/noetl/soc2-ai-meta/wiki/Data-Flow-and-Boundaries))
- Access management principles
- Incident response overview
- Employee security responsibilities

## Pointers
- Wiki: https://github.com/noetl/soc2-ai-meta/wiki/SOC2-Compliance-Plan
- TSC: CC1.1, CC1.3, CC2.1, CC2.2

## Blocked on
Nothing — first deliverable in Phase 1.

## Links
- [SOC2 Compliance Plan](https://github.com/noetl/soc2-ai-meta/wiki/SOC2-Compliance-Plan)
- [Trust Service Criteria Mapping](https://github.com/noetl/soc2-ai-meta/wiki/Trust-Service-Criteria-Mapping)" \
  '["soc2","phase-1","policy","critical"]'

create_issue \
  "[SOC2-CC3] Create and maintain Risk Register" \
  "## Context
No formal risk register exists. SOC2 CC3 requires documented risk identification, assessment, and tracking.

## Goal
- Create a risk register (wiki page or structured GitHub project)
- Enumerate top infrastructure risks (NATS single-pod, Cloud SQL single-region, dependency vulnerabilities, credential exposure)
- Score each risk (likelihood × impact)
- Assign mitigation controls and owners
- Review quarterly

## Pointers
- Wiki: https://github.com/noetl/soc2-ai-meta/wiki/SOC2-Compliance-Plan
- TSC: CC3.1, CC3.2, CC3.3, CC3.4

## Blocked on
Security Policy (#1) should be drafted first to establish risk appetite.

## Links
- [Trust Service Criteria Mapping](https://github.com/noetl/soc2-ai-meta/wiki/Trust-Service-Criteria-Mapping)" \
  '["soc2","phase-1","risk","critical"]'

create_issue \
  "[SOC2-CC7] Write Incident Response Plan" \
  "## Context
noetl/soc2-ai-meta wiki has a draft Incident Response page but it needs formal ratification, external communication templates, and a tested escalation path.

## Goal
- Finalize and ratify the [Incident Response wiki page](https://github.com/noetl/soc2-ai-meta/wiki/Incident-Response)
- Add external notification template (for affected tenants / stakeholders)
- Define on-call rotation and escalation contacts
- Conduct a tabletop exercise (simulate P1 scenario)
- Document exercise result in Audit Log

## Pointers
- Wiki: https://github.com/noetl/soc2-ai-meta/wiki/Incident-Response
- TSC: CC7.3, CC7.4, CC7.5

## Blocked on
Security Policy (#1) should establish classification definitions first." \
  '["soc2","phase-1","incident-response","critical"]'

create_issue \
  "[SOC2-CC6] Implement quarterly Access Review process" \
  "## Context
No formal access review cadence exists. CC6.2 and CC6.3 require periodic review of all access rights.

## Goal
- Enumerate all GCP IAM principals: \`gcloud projects get-iam-policy noetl-demo-19700101\`
- Enumerate all K8s service accounts and RBAC bindings in noetl-cluster
- Enumerate all GitHub org members for noetl org
- Verify least-privilege for each; remove stale access
- Document results in [Access Control Inventory wiki](https://github.com/noetl/soc2-ai-meta/wiki/Access-Control-Inventory) and [Audit Log](https://github.com/noetl/soc2-ai-meta/wiki/Audit-Log)
- Establish quarterly GitHub issue template for future reviews

## Pointers
- Wiki: https://github.com/noetl/soc2-ai-meta/wiki/Access-Control-Inventory
- TSC: CC6.2, CC6.3

## Blocked on
Nothing — run immediately as Phase 1 kickoff." \
  '["soc2","phase-1","access-control","high"]'

create_issue \
  "[SOC2-CC6] Enforce MFA on GitHub org and GCP IAM admin roles" \
  "## Context
MFA enforcement for admin-level access has not been formally verified.

## Goal
- Verify GitHub org 'noetl' has 'Require two-factor authentication' enabled in org Settings → Authentication security
- Verify GCP org policy \`constraints/iam.allowedPolicyMemberDomains\` and MFA enforcement at Adiona.org level
- Document verified state in [Access Control Inventory wiki](https://github.com/noetl/soc2-ai-meta/wiki/Access-Control-Inventory)

## Pointers
- TSC: CC6.1

## Blocked on
Nothing." \
  '["soc2","phase-1","access-control","high","mfa"]'

create_issue \
  "[SOC2-CC6/C1] Define Data Retention and Deletion Policy" \
  "## Context
noetl has no formal data retention policy. Cloud Logging uses GCP defaults (30 days). Cloud SQL event log has no expiry. SOC2 C1.3 requires documented disposal procedures.

## Goal
- Define retention tiers: 90-day hot, 1-year cold archive, then deletion
- Apply Cloud Logging bucket retention rules per log type
- Implement or document Cloud SQL PITR window + archival policy
- Define Helm release history \`max-history: 10\` in noetl/ops
- Add policy to Security Policy document (#1)
- Update [Data Flow wiki](https://github.com/noetl/soc2-ai-meta/wiki/Data-Flow-and-Boundaries)

## Pointers
- TSC: CC6.5, C1.1, C1.3

## Blocked on
Security Policy (#1)." \
  '["soc2","phase-1","data-retention","confidentiality","high"]'

create_issue \
  "[SOC2-CC7] Add vulnerability scanning to CI pipeline" \
  "## Context
No automated vulnerability or dependency scanning exists in any noetl repo CI pipeline. CC7.1 requires detecting and responding to vulnerabilities.

## Goal
- Add \`cargo audit\` to GitHub Actions in: noetl/server, noetl/worker, noetl/tools, noetl/gateway, noetl/cli
- Add \`trivy\` container image scanning in Artifact Registry pipeline (noetl/ops or per-repo CI)
- Block PR merge on CRITICAL/HIGH findings (or triage process if false positive)
- Store scan reports; link monthly summary to [Audit Log](https://github.com/noetl/soc2-ai-meta/wiki/Audit-Log)

## Pointers
- Repos: noetl/server, noetl/worker, noetl/tools, noetl/gateway, noetl/cli, noetl/ops
- TSC: CC7.1

## Blocked on
Nothing." \
  '["soc2","phase-2","vulnerability-scanning","high","ci"]'

create_issue \
  "[SOC2-CC4] Commission external penetration test" \
  "## Context
SOC2 CC4.2 requires separate evaluations such as an external security assessment. noetl has not had a penetration test.

## Goal
- Select and engage an external penetration testing vendor
- Define scope: noetl-gateway, noetl-server API surface, GKE cluster, Secrets Wallet endpoints
- Conduct test; receive report
- Remediate findings; document in [Audit Log](https://github.com/noetl/soc2-ai-meta/wiki/Audit-Log)
- Schedule annual recurrence

## Pointers
- TSC: CC4.2

## Blocked on
Phase 2 controls (#7) should be implemented first to avoid known findings." \
  '["soc2","phase-2","penetration-test","high"]'

create_issue \
  "[SOC2-CC8] Formalize Change Management Policy and audit branch protection" \
  "## Context
Change management is practiced (PR-based, kind→GKE validation) but not formally documented as a ratified policy. Branch protection rules may not be consistently applied across all repos.

## Goal
- Ratify [Change Management wiki page](https://github.com/noetl/soc2-ai-meta/wiki/Change-Management) as the official policy
- Audit branch protection on all noetl/* repos: require PR, 1 reviewer, passing status checks, no direct push to main
- Document any exceptions with justification
- Ensure every infra change has a linked GitHub issue (for audit trail)

## Pointers
- Wiki: https://github.com/noetl/soc2-ai-meta/wiki/Change-Management
- TSC: CC8.1, CC8.2" \
  '["soc2","phase-2","change-management","medium"]'

create_issue \
  "[SOC2-CC9] Third-party vendor risk assessment" \
  "## Context
noetl relies on GCP, Cloudflare, GitHub, crates.io, and optional providers (AWS, Azure, Vault). CC9.2 requires assessing vendor risk.

## Goal
- Review [Infrastructure Inventory](https://github.com/noetl/soc2-ai-meta/wiki/Infrastructure-Inventory) vendor list
- For each critical vendor: review SOC2 / ISO 27001 / compliance posture (obtain their reports where possible)
- Document data shared with each vendor and contractual data protection terms
- Assign risk tier (critical / high / medium / low)
- Review annually

## Pointers
- Wiki: https://github.com/noetl/soc2-ai-meta/wiki/Infrastructure-Inventory
- TSC: CC9.2" \
  '["soc2","phase-2","vendor-risk","medium"]'

create_issue \
  "[SOC2-A1] Business Continuity and Disaster Recovery Plan" \
  "## Context
No documented RTO/RPO or DR plan exists. Cloud SQL PITR is available but has never been tested. NATS runs as a single pod.

## Goal
- Define RTO (recovery time objective) and RPO (recovery point objective) for noetl platform
- Document Cloud SQL PITR recovery procedure and test it (see issue #12)
- Evaluate NATS clustering vs. single-pod risk acceptance; document decision
- Document GKE regional failover posture (Autopilot multi-zone behavior)
- Write DR runbook; add to [playbooks/](https://github.com/noetl/soc2-ai-meta/tree/main/playbooks)

## Pointers
- TSC: A1.1, A1.2, A1.3" \
  '["soc2","phase-2","disaster-recovery","availability","medium"]'

create_issue \
  "[SOC2-A1] Verify and document Cloud SQL backup and PITR procedure" \
  "## Context
Cloud SQL automated backups and PITR are enabled but have never been formally tested or documented as a recovery procedure.

## Goal
- Confirm backup schedule and retention window in Cloud SQL console
- Perform a PITR restore drill on a non-production clone
- Document restore steps and timing in DR runbook (linked from issue #11)
- Schedule annual restore drill; record in [Audit Log](https://github.com/noetl/soc2-ai-meta/wiki/Audit-Log)

## Pointers
- TSC: A1.2, A1.3

## Blocked on
DR Plan (#11) should define RTO/RPO targets first." \
  '["soc2","phase-2","backup","availability","medium"]'

create_issue \
  "[SOC2-CC1] Implement security training program" \
  "## Context
CC1.4 requires demonstrating commitment to competence. No formal security training or records exist.

## Goal
- Define minimum security training for all personnel with noetl system access
- Topics: secure coding, credential hygiene, phishing awareness, incident reporting
- Record completion (date + person) in [Audit Log](https://github.com/noetl/soc2-ai-meta/wiki/Audit-Log)
- Schedule annual recurrence

## Pointers
- TSC: CC1.4" \
  '["soc2","phase-1","training","medium"]'

create_issue \
  "[SOC2-CC7] Formalize log retention policy and Cloud Logging bucket rules" \
  "## Context
Cloud Logging uses GCP 30-day default. No explicit retention bucket rules are set. This is a gap for CC7.2 and C1.3.

## Goal
- Define log types and retention requirements (aligned with data retention policy from issue #6)
- Apply explicit Cloud Logging bucket retention rules per log type via \`gcloud logging buckets update\`
- Enable Cloud SQL data-access audit logging
- Document in [Data Flow wiki](https://github.com/noetl/soc2-ai-meta/wiki/Data-Flow-and-Boundaries)

## Pointers
- TSC: CC7.2, C1.3

## Blocked on
Data Retention Policy (#6)." \
  '["soc2","phase-2","logging","medium"]'

create_issue \
  "[SOC2-CC6] Document and enforce network segmentation (K8s NetworkPolicy)" \
  "## Context
GKE Autopilot provides node isolation but no explicit K8s NetworkPolicy restricts pod-to-pod traffic within the cluster. CC6.6 requires hardened network controls.

## Goal
- Define desired network segments: gateway, server, worker, monitoring, NATS
- Write K8s NetworkPolicy manifests in noetl/ops restricting inter-pod traffic to known paths
- Apply to noetl-cluster; validate with \`kubectl describe networkpolicy\`
- Document topology in [Infrastructure Inventory](https://github.com/noetl/soc2-ai-meta/wiki/Infrastructure-Inventory)

## Pointers
- TSC: CC6.6" \
  '["soc2","phase-2","network","low"]'

create_issue \
  "[SOC2-A1] Evaluate NATS JetStream clustering for HA" \
  "## Context
NATS JetStream runs as a single pod in GKE. A pod failure interrupts message delivery until restart. This is an availability risk.

## Goal
- Evaluate NATS clustering (3-node JetStream cluster) vs. risk acceptance
- If clustering: implement in noetl/ops Helm chart; validate with kind-val rig
- If risk acceptance: document rationale with compensating controls (fast restart, KEDA backpressure)
- Update [Infrastructure Inventory](https://github.com/noetl/soc2-ai-meta/wiki/Infrastructure-Inventory)

## Pointers
- TSC: A1.1" \
  '["soc2","phase-2","nats","availability","low"]'

echo ""
echo "All issues created."
