# {{PROJECT_NAME}} AI Meta

Coordination repository and shared memory layer for the **{{PROJECT_NAME}}** ecosystem.

This repo tracks all participating repositories as **git submodules**, provides a **Git-tracked long memory** system for AI agents and engineers, and defines shared **rules, skills, and profiles** that any AI coding agent can use.

It also includes a **file-based cross-agent handoff system** so long-running work can move between Claude, Copilot/Codex, Cursor, Gemini, and future tools without losing context.

## Quick Start

```bash
# Clone
git clone {{REPO_PREFIX}}/{{PROJECT_SLUG}}-meta.git
cd {{PROJECT_SLUG}}-meta

# Initialize submodules
git submodule update --init --recursive
```

## What This Repo Contains

- **`repos/`** — all ecosystem repos as git submodules (pinned SHAs)
- **`memory/`** — Git-tracked long memory (inbox → compaction → current state)
- **`sync/`** — cross-repo "what changed" notes (PR links, SHAs, follow-ups)
- **`agents/`** — shared AI agent rules, skills, and profiles
- **`playbooks/`** — repeatable checklists for common tasks
- **`handoffs/`** — durable cross-agent prompt/result threads
- **`scripts/`** — automation helpers (memory_add.sh, memory_compact.sh)

## Repository Layout

```
├── AGENTS.md                          # Global rules for all agents
├── CLAUDE.md                          # Claude Code entry point (auto-loaded)
├── .github/copilot-instructions.md    # GitHub Copilot entry point
├── .cursorrules                       # Cursor entry point
├── agents/                            # Shared agent infrastructure
│   ├── rules/                         #   Modular rule files
│   ├── skills/                        #   Workflow definitions
│   └── profiles/                      #   Per-agent behavioral profiles
├── .claude/                           # Claude Code integration
│   ├── settings.json                  #   Permissions and hooks
│   ├── rules -> ../agents/rules       #   Symlink to shared rules
│   └── skills -> ../agents/skills     #   Symlink to shared skills
├── handoffs/                          # Cross-agent file handoff channel
│   ├── active/                        #   In-flight threads
│   ├── archive/                       #   Closed threads
│   └── templates/                     #   prompt/result templates
├── memory/                            # Long memory store
│   ├── current.md                     #   Active working state
│   ├── timeline.md                    #   Chronological index
│   ├── inbox/                         #   Raw entries
│   ├── compactions/                   #   Periodic summaries
│   └── archive/                       #   Processed entries
├── sync/                              # Cross-repo change notes
├── playbooks/                         # Operational checklists
├── scripts/                           # Memory and automation helpers
└── repos/                             # Git submodules
```

## Day-to-Day Workflow

1. **Work in submodules** — code changes happen inside `repos/<name>`
2. **Open PRs upstream** — each submodule has its own remote
3. **Bump pointers** — update submodule SHAs after merges
4. **Write sync notes** — capture what changed across repos
5. **Add memory entries** — record decisions and outcomes
6. **Compact periodically** — keep active memory small

## Cross-Agent Handoff Workflow

1. Open a thread in `handoffs/active/<YYYY-MM-DD-slug>/`
2. Dispatcher writes `round-NN-prompt.md`
3. Executor writes `round-NN-result.md`
4. Continue with additional rounds as needed
5. Move completed thread to `handoffs/archive/`

See `handoffs/README.md` and `agents/rules/handoffs.md`.

## Memory Commands

```bash
# Add a memory entry
./scripts/memory_add.sh "title" "summary" "tags"

# Compact inbox entries
./scripts/memory_compact.sh
```

## Commit Conventions

- `memory(add): <topic>` — new memory entry
- `memory(compact): <scope>` — compaction run
- `memory(curate): <scope>` — manual current.md refresh
- `chore(sync): bump <repo> to <sha>` — submodule pointer update
- `docs(agents): <description>` — agent infrastructure changes

## Adding Submodules

```bash
git submodule add {{REPO_PREFIX}}/<repo-name>.git repos/<repo-name>
git commit -m "chore(sync): add <repo-name> submodule"
```

## AI Agent Support

This repo supports multiple AI coding agents out of the box:

| Agent | Entry Point | Auto-loads |
|---|---|---|
| Claude Code | `CLAUDE.md` | Rules, skills, settings, hooks |
| GitHub Copilot | `.github/copilot-instructions.md` | Instructions |
| Cursor | `.cursorrules` | Instructions |
| Gemini | `GEMINI.md` (optional) | Profile + rules |
| Any other | `AGENTS.md` | Read manually |

---

*Generated from [ai-agent-template](https://github.com/noetl/ai-agent-template)*
