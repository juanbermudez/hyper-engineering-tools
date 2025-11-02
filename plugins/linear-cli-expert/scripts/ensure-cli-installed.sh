#!/bin/bash
# Ensure Linear Agent CLI is installed when plugin loads

set -e

INSTALL_MARKER="${CLAUDE_PLUGIN_ROOT}/.cli-installed"
CLI_REPO="https://github.com/juanbermudez/linear-agent-cli"

# Function to check if linear CLI is available
check_cli() {
  if command -v linear &> /dev/null; then
    return 0
  fi
  return 1
}

# Function to install CLI using deno
install_cli() {
  echo "📦 Installing Linear Agent CLI from ${CLI_REPO}..."

  # Check if deno is installed
  if ! command -v deno &> /dev/null; then
    echo "❌ Deno is not installed. Linear Agent CLI requires Deno."
    echo "📝 Install Deno: https://docs.deno.com/runtime/getting_started/installation/"
    echo ""
    echo "Quick install:"
    echo "  macOS/Linux: curl -fsSL https://deno.land/install.sh | sh"
    echo "  Windows:     irm https://deno.land/install.ps1 | iex"
    exit 1
  fi

  # Install from GitHub
  deno install --global --allow-all --name linear \
    https://raw.githubusercontent.com/juanbermudez/linear-agent-cli/main/src/main.ts

  # Mark as installed
  touch "${INSTALL_MARKER}"

  echo "✅ Linear Agent CLI installed successfully!"
}

# Only install if not already installed
if [ ! -f "${INSTALL_MARKER}" ]; then
  if ! check_cli; then
    install_cli
  else
    # Mark as installed if CLI exists
    touch "${INSTALL_MARKER}"
  fi
fi

# Verify installation
if check_cli; then
  LINEAR_VERSION=$(linear --version 2>&1 | head -1 || echo "unknown")
  echo "✓ Linear Agent CLI ready (${LINEAR_VERSION})"

  # Check if API key is configured
  if ! linear whoami &> /dev/null; then
    echo ""
    echo "⚠️  Linear API key not configured"
    echo ""
    echo "📝 To configure your Linear API key, run:"
    echo "   linear config setup"
    echo ""
    echo "Or set it manually:"
    echo "   1. Get your API key from: https://linear.app/settings/api"
    echo "   2. Run: linear config set auth.token \"lin_api_...\""
    echo "   3. Set default team: linear config set defaults.team \"TEAM-KEY\""
    echo ""
  fi

  # Show welcome message on first install
  if [ ! -f "${CLAUDE_PLUGIN_ROOT}/.welcome-shown" ]; then
    echo ""
    echo "🎉 Linear CLI Expert plugin installed successfully!"
    echo ""
    echo "📖 Run /hyper-welcome to get started"
    echo "🚀 Run /hyper-init-all to customize agents for your codebase"
    echo ""
    touch "${CLAUDE_PLUGIN_ROOT}/.welcome-shown"
  fi
else
  echo "⚠️  Linear Agent CLI not available. Install manually:"
  echo "   deno install --global --allow-all --name linear \\"
  echo "     https://raw.githubusercontent.com/juanbermudez/linear-agent-cli/main/src/main.ts"
fi
