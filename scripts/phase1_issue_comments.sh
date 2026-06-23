#!/usr/bin/env bash
set -euo pipefail

TOKEN="${GITHUB_TOKEN:-$(read -rsp "GitHub PAT: " t; echo "$t")}"
REPO="noetl/soc2-ai-meta"
API="https://api.github.com/repos/${REPO}"

comment() {
  local issue="$1"; local body="$2"
  curl -s -X POST "$API/issues/${issue}/comments" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -d "{\"body\": $(echo "$body" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read().strip()))')}" \
    | python3 -c 'import sys,json; d=json.load(sys.stdin); print("Commented on #'$issue': "+d["html_url"])'
}

echo "Adding Phase 1 progress comments..."

comment 2 "## Work started — 2026-06-22

Security Policy v1.0 drafted and published to wiki.

**Evidence:** https://github.com/noetl/soc2-ai-meta/wiki/Security-Policy

Covers: data classification (4 tiers), access control principles, credential management (Secrets Wallet), vulnerability management, incident response, data retention schedule, third-party vendor risk, logging/monitoring, physical security, acceptable use.

**Status:** Draft — pending ratification by alexis.k@cybx.io
**Next:** Review document, ratify, record completion in Audit Log and close this issue."

comment 3 "## Work started — 2026-06-22

Risk Register created and published to wiki with 15 active risks scored by Likelihood × Impact.

**Evidence:** https://github.com/noetl/soc2-ai-meta/wiki/Risk-Register

Highlights:
- 3 high-priority risks (score 10–12): NATS single-pod (R-03), unpatched deps (R-05), no tested DR (R-04)
- 3 risks pre-mitigated by existing controls: credential exposure (Secrets Wallet), k8s-watcher RBAC, KEK rotation
- Risk appetite defined: accept ≤6, mitigate 7–14, treat immediately ≥15
- All risks linked to corresponding issues

**Status:** In progress — requires quarterly review cadence
**Next:** Complete Security Policy (#2), review risk register with it, then set first quarterly review date."

comment 4 "## Work started — 2026-06-22

Incident Response plan wiki page reviewed and Audit Log updated. Tabletop exercise still needed.

**Evidence:** https://github.com/noetl/soc2-ai-meta/wiki/Incident-Response

**Remaining to close this issue:**
- [ ] Ratify the IR plan (alexis.k@cybx.io sign-off)
- [ ] Add external notification template for tenant communication
- [ ] Conduct tabletop exercise (simulate P1 scenario)
- [ ] Record exercise in Audit Log"

comment 5 "## Work started — 2026-06-22

Q3 2026 Access Review page created with all enumeration commands ready.

**Evidence:** https://github.com/noetl/soc2-ai-meta/wiki/Access-Review-Q3-2026

**Action required — run these locally and paste results into the wiki page:**
\`\`\`bash
# GCP IAM
gcloud projects get-iam-policy noetl-demo-19700101 --format='table(bindings.role,bindings.members)'

# K8s RBAC
kubectl get clusterrolebindings -o wide
kubectl get rolebindings --all-namespaces -o wide

# GitHub org members + MFA
gh api orgs/noetl/members --paginate --jq '.[].login'
gh api 'orgs/noetl/members?filter=2fa_disabled' --jq '.[].login'
\`\`\`"

comment 6 "## Work started — 2026-06-22

MFA enforcement needs verification on two surfaces.

**Action required:**

1. **GitHub org:** Go to https://github.com/organizations/noetl/settings/auth → verify 'Require two-factor authentication' is checked
2. **GCP:** In GCP Console → IAM → Org policies for Adiona.org → verify MFA/2-step enforcement policy is set

Once verified, document in [Access Control Inventory](https://github.com/noetl/soc2-ai-meta/wiki/Access-Control-Inventory) and close this issue."

comment 14 "## Work started — 2026-06-22

Security Training Program defined with 6 modules and completion log.

**Evidence:** https://github.com/noetl/soc2-ai-meta/wiki/Security-Training

**Action required:**
- [ ] Kadyapam completes modules ST-01 through ST-06 and marks completion log
- [ ] Record completion date in Audit Log
- [ ] Close this issue once all current personnel have completed initial training"

echo ""
echo "All issue comments posted."
