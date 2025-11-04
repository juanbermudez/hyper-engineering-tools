# Implementation Plan: Project-Level Installation

## Goal
Install skills and agents in **project's `.claude/` directory**, not globally.

## Current State
```
plugin-root/
├── .claude-plugin/plugin.json
├── templates/
│   ├── skills/linear-cli-expert/SKILL.md
│   └── agents/*.md
├── commands/hyper-setup.md (not working)
└── scripts/ensure-cli-installed.sh
```

## Target State
```
plugin-root/
├── .claude-plugin/plugin.json
├── templates/
│   ├── skills/
│   └── agents/
├── commands/hyper-setup.md
└── scripts/
    ├── ensure-cli-installed.sh
    └── setup-project.sh (NEW)
```

**In project after plugin setup:**
```
project/
└── .claude/
    ├── skills/
    │   └── linear-cli-expert/
    │       └── SKILL.md
    ├── agents/
    │   ├── research-agent.md
    │   ├── planning-agent.md
    │   └── engineering-agent.md
    └── .linear-cli-expert-setup (marker file)
```

## Implementation Steps

### Step 1: Create Auto-Setup Script

**File:** `scripts/setup-project.sh`

```bash
#!/bin/bash
# Auto-setup project-level skills and agents

set -e

SETUP_MARKER=".claude/.linear-cli-expert-setup"

# Check if already set up
if [ -f "${SETUP_MARKER}" ]; then
  exit 0
fi

echo "🔧 Setting up Linear CLI Expert for this project..."
echo ""

# Create directories
mkdir -p .claude/skills/linear-cli-expert
mkdir -p .claude/agents
mkdir -p .claude/temp/hyper-init

# Copy skill
if [ -d "${CLAUDE_PLUGIN_ROOT}/templates/skills/linear-cli-expert" ]; then
  cp -r "${CLAUDE_PLUGIN_ROOT}/templates/skills/linear-cli-expert/"* .claude/skills/linear-cli-expert/
  echo "✓ Installed Linear CLI Expert skill in .claude/skills/"
fi

# Copy agents
if [ -d "${CLAUDE_PLUGIN_ROOT}/templates/agents" ]; then
  cp "${CLAUDE_PLUGIN_ROOT}/templates/agents/"*.md .claude/agents/ 2>/dev/null || true
  echo "✓ Installed agents in .claude/agents/"
  echo "  - research-agent.md"
  echo "  - planning-agent.md"
  echo "  - engineering-agent.md"
fi

# Create marker
touch "${SETUP_MARKER}"
echo "Setup completed on $(date)" > "${SETUP_MARKER}"

echo ""
echo "✅ Linear CLI Expert set up successfully!"
echo ""
echo "📁 Project-level components installed in .claude/"
echo ""
echo "💡 Next steps:"
echo "   1. Customize agents in .claude/agents/ for your project"
echo "   2. Run /hyper-init-all to optimize for your codebase"
echo "   3. Commit .claude/ to git to share with your team"
echo ""
```

### Step 2: Update SessionStart Hook

**File:** `.claude-plugin/plugin.json`

Change from:
```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "${CLAUDE_PLUGIN_ROOT}/scripts/ensure-cli-installed.sh"
      }]
    }]
  }
}
```

To:
```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/ensure-cli-installed.sh"
        },
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/setup-project.sh"
        }
      ]
    }]
  }
}
```

### Step 3: Update /hyper-setup Command

Keep the command but make it idempotent (can re-run to reset):

```markdown
---
description: Initialize or reset Linear CLI Expert in this project
---

# Setup Linear CLI Expert for This Project

This command copies skills and agents from the plugin to your project's `.claude/` directory.

## Your Task

Run the setup script:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/setup-project.sh"
```

This will:
1. Create `.claude/skills/linear-cli-expert/`
2. Create `.claude/agents/` with research, planning, and engineering agents
3. Mark setup as complete

To reset/update templates, delete `.claude/.linear-cli-expert-setup` and re-run this command.
```

### Step 4: Update ensure-cli-installed.sh

Simplify to only handle CLI installation:

```bash
#!/bin/bash
# Ensure Linear Agent CLI is installed

set -e

INSTALL_MARKER="${CLAUDE_PLUGIN_ROOT}/.cli-installed"

# Function to check if linear CLI is available
check_cli() {
  if command -v linear &> /dev/null; then
    return 0
  fi
  return 1
}

# Only install CLI if not already done
if [ ! -f "${INSTALL_MARKER}" ]; then
  if ! check_cli; then
    # Install CLI (existing logic)
    ...
  fi
  touch "${INSTALL_MARKER}"
fi

# Verify and show version
if check_cli; then
  LINEAR_VERSION=$(linear --version 2>&1 | head -1 || echo "unknown")
  echo "✓ Linear Agent CLI ready (${LINEAR_VERSION})"
fi
```

### Step 5: Bump Version

Update `.claude-plugin/plugin.json`:
```json
{
  "version": "1.2.0"
}
```

## Testing Plan

1. **Fresh install test:**
   - Remove plugin: `/plugin uninstall linear-cli-expert`
   - Install plugin: `/plugin install linear-cli-expert@hyper-engineering-tools`
   - Verify: `ls .claude/skills/` should show `linear-cli-expert/`
   - Verify: `ls .claude/agents/` should show agent files

2. **Existing project test:**
   - Navigate to project without setup
   - SessionStart hook should auto-setup
   - Verify marker: `cat .claude/.linear-cli-expert-setup`

3. **Manual setup test:**
   - Run `/hyper-setup`
   - Should work even if already set up (idempotent)

4. **Agent availability test:**
   - Run `/agents`
   - Should see research-agent, planning-agent, engineering-agent
   - Should be at PROJECT level, not user level

## Success Criteria

✓ Skills installed in `.claude/skills/` (project directory)
✓ Agents installed in `.claude/agents/` (project directory)
✓ Components NOT in `~/.claude/` (user directory)
✓ Agents visible in `/agents` command
✓ Skills available when needed
✓ Setup happens automatically on first session
✓ `/hyper-setup` command works for manual setup/reset
