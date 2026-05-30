#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────
# ai-agent-template init script
#
# Replaces template placeholders, creates symlinks, initializes
# git, and prepares the repo for use. Self-deletes when done.
# ──────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║         ai-agent-template — Project Setup               ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── Collect inputs ────────────────────────────────────────────

read -rp "Project name (human-readable, e.g. 'Acme Platform'): " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: project name is required."
  exit 1
fi

# Generate default slug from project name
default_slug="$(printf '%s' "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
read -rp "Project slug (lowercase, e.g. '${default_slug}'): [${default_slug}] " PROJECT_SLUG
PROJECT_SLUG="${PROJECT_SLUG:-$default_slug}"

read -rp "GitHub organization or owner (e.g. 'acme-corp'): " ORG_NAME
if [ -z "$ORG_NAME" ]; then
  echo "Error: organization name is required."
  exit 1
fi

read -rp "Git remote prefix (e.g. 'git@github.com:${ORG_NAME}'): [git@github.com:${ORG_NAME}] " REPO_PREFIX
REPO_PREFIX="${REPO_PREFIX:-git@github.com:${ORG_NAME}}"

echo ""
echo "── Configuration ──────────────────────────────────────────"
echo "  Project name:  ${PROJECT_NAME}"
echo "  Project slug:  ${PROJECT_SLUG}"
echo "  Organization:  ${ORG_NAME}"
echo "  Remote prefix: ${REPO_PREFIX}"
echo "──────────────────────────────────────────────────────────"
echo ""

read -rp "Proceed? [Y/n] " confirm
if [[ "${confirm:-Y}" =~ ^[Nn] ]]; then
  echo "Aborted."
  exit 0
fi

# ── Replace placeholders ─────────────────────────────────────

echo ""
echo "→ Replacing template placeholders..."

# Find all text files (skip .git, binary files, and this script)
find . -type f \
  -not -path './.git/*' \
  -not -path './init.sh' \
  -not -name '*.gitkeep' \
  | while IFS= read -r file; do
    if file "$file" | grep -q 'text'; then
      # Use | as sed delimiter to avoid conflicts with paths
      sed -i '' \
        -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
        -e "s|{{PROJECT_SLUG}}|${PROJECT_SLUG}|g" \
        -e "s|{{ORG_NAME}}|${ORG_NAME}|g" \
        -e "s|{{REPO_PREFIX}}|${REPO_PREFIX}|g" \
        "$file" 2>/dev/null || true
    fi
  done

echo "  ✓ Placeholders replaced"

# ── Create symlinks ──────────────────────────────────────────

echo "→ Creating .claude/ symlinks..."

# Remove placeholder directories if they exist (from git clone)
rm -rf .claude/rules .claude/skills 2>/dev/null || true

cd .claude
ln -sf ../agents/rules rules
ln -sf ../agents/skills skills
cd ..

echo "  ✓ .claude/rules -> ../agents/rules"
echo "  ✓ .claude/skills -> ../agents/skills"

# ── Make scripts executable ──────────────────────────────────

echo "→ Making scripts executable..."
chmod +x scripts/memory_add.sh scripts/memory_compact.sh
echo "  ✓ scripts/memory_add.sh"
echo "  ✓ scripts/memory_compact.sh"

# ── Initialize git ───────────────────────────────────────────

if [ ! -d .git ]; then
  echo "→ Initializing git repository..."
  git init -b main
  echo "  ✓ Git initialized (branch: main)"
else
  echo "→ Git already initialized, skipping."
fi

# ── Remove this script ───────────────────────────────────────

echo "→ Removing init.sh (no longer needed)..."
rm -f init.sh
echo "  ✓ init.sh removed"

# ── Initial commit ───────────────────────────────────────────

echo "→ Creating initial commit..."
git add -A
git commit -m "docs(agents): initialize ${PROJECT_NAME} meta-repo from ai-agent-template"
echo "  ✓ Initial commit created"

# ── Optional remote setup ────────────────────────────────────

echo ""
read -rp "Set up a git remote? [Y/n] " setup_remote
if [[ ! "${setup_remote:-Y}" =~ ^[Nn] ]]; then
  default_remote="${REPO_PREFIX}/${PROJECT_SLUG}-meta.git"
  read -rp "Remote URL: [${default_remote}] " remote_url
  remote_url="${remote_url:-$default_remote}"
  git remote add origin "$remote_url"
  echo "  ✓ Remote 'origin' set to: ${remote_url}"
  echo ""
  echo "  To push: git push -u origin main"
fi

# ── Done ─────────────────────────────────────────────────────

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                    Setup complete!                       ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo ""
echo "  1. Add your submodules:"
echo "     git submodule add ${REPO_PREFIX}/<repo>.git repos/<repo>"
echo ""
echo "  2. Create your first memory entry:"
echo "     ./scripts/memory_add.sh \"Project initialized\" \"Set up meta-repo\" \"setup\""
echo ""
echo "  3. Open in your AI coding agent:"
echo "     - Claude Code: auto-loads CLAUDE.md, rules, skills, and settings"
echo "     - Copilot: auto-loads .github/copilot-instructions.md"
echo "     - Cursor: auto-loads .cursorrules"
echo "     - Gemini: use GEMINI.md as the entrypoint"
echo ""
echo "  4. Read the playbooks in playbooks/ for operational guides."
echo ""
echo "  5. Use handoffs/ for long-running cross-agent collaboration."
echo ""
