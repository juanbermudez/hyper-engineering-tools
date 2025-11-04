#!/bin/bash
# Auto-setup project-level skills and agents for Linear CLI Expert

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
  for agent in "${CLAUDE_PLUGIN_ROOT}/templates/agents/"*.md; do
    if [ -f "$agent" ]; then
      cp "$agent" .claude/agents/
    fi
  done
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
