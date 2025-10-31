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
else
  echo "⚠️  Linear Agent CLI not available. Install manually:"
  echo "   deno install --global --allow-all --name linear \\"
  echo "     https://raw.githubusercontent.com/juanbermudez/linear-agent-cli/main/src/main.ts"
fi
