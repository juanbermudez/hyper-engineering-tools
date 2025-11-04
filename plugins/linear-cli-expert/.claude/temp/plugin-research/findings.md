# Claude Code Plugin Research Findings

## The Problem

**User's Requirement:** Install skills and agents in **project's `.claude/` directory**, NOT globally/user-level.

**Current Issue:** Plugin components at plugin root (`skills/`, `agents/`) are discovered **globally**, not project-locally.

## Key Documentation Findings

### 1. Plugin Component Discovery

From plugins documentation:
> "When a plugin installs, its components become available system-wide"
> "Skills: Automatically available when the plugin is installed"

**This means:**
- `plugin-root/skills/` → Discovered globally (plugin-level)
- `plugin-root/agents/` → Discovered globally (plugin-level)
- These are NOT installed in the project's `.claude/` directory

### 2. Project-Level vs Plugin-Level

**Three distinct levels:**

| Level | Skills Location | Agents Location | Scope |
|-------|----------------|-----------------|-------|
| Personal/User | `~/.claude/skills/` | `~/.claude/agents/` | All projects for one user |
| Project | `.claude/skills/` | `.claude/agents/` | One project, all team members |
| Plugin | `plugin-root/skills/` | `plugin-root/agents/` | All projects with plugin installed |

**Priority:** Project > CLI-defined > User

**Key insight:** Plugin-level components are NOT the same as project-level components!

### 3. How to Achieve Project-Level Installation

From skills documentation:
> "Project Skills are checked into git and automatically available to team members"
> "Store them in `.claude/skills/` within your project"

From agents documentation:
> "Project subagents: `.claude/agents/` - Available in current project - Highest priority"

**The solution:** Components must be physically located in `.claude/skills/` and `.claude/agents/` within the PROJECT directory.

### 4. Plugin Distribution Recommendation

From skills documentation:
> "Recommended approach: Distribute Skills through plugins"
> "Create a plugin with Skills in the `skills/` directory"

**But this creates global/plugin-level skills, not project-level!**

## The Contradiction

The docs recommend plugins for distribution, BUT:
- Plugin components (`plugin-root/skills/`, `plugin-root/agents/`) = Global/plugin-level
- Project components (`.claude/skills/`, `.claude/agents/`) = Project-level

**You cannot have true project-level installation with components in the plugin root!**

## The Correct Solution

### Option 1: SessionStart Hook + Template Copying (Current Approach)

**Structure:**
```
plugin-root/
├── .claude-plugin/plugin.json
├── templates/              # NOT discovered by Claude
│   ├── skills/
│   │   └── linear-cli-expert/
│   │       └── SKILL.md
│   └── agents/
│       ├── research-agent.md
│       ├── planning-agent.md
│       └── engineering-agent.md
├── commands/
│   └── hyper-setup.md      # Copies templates/ to .claude/
└── scripts/
    └── ensure-cli-installed.sh
```

**Mechanism:**
1. Plugin installs (no skills/agents discovered)
2. User runs `/hyper-setup` command
3. Command copies from `templates/` to `.claude/skills/` and `.claude/agents/`
4. Project now has project-level components
5. Team commits `.claude/` to git

**Problem with current implementation:**
- I moved skills/agents to `templates/` ✓
- But `/hyper-setup` command is not being discovered ✗

### Option 2: Automatic SessionStart Hook Setup

**Alternative:**
Use SessionStart hook to automatically copy templates to `.claude/` on first session in a project.

**Hook in plugin.json:**
```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "${CLAUDE_PLUGIN_ROOT}/scripts/auto-setup.sh"
      }]
    }]
  }
}
```

**Script checks:**
```bash
if [ ! -f ".claude/.linear-cli-expert-setup" ]; then
  # Copy templates to .claude/
  mkdir -p .claude/skills/linear-cli-expert
  mkdir -p .claude/agents
  cp -r "${CLAUDE_PLUGIN_ROOT}/templates/skills/linear-cli-expert/"* .claude/skills/linear-cli-expert/
  cp "${CLAUDE_PLUGIN_ROOT}/templates/agents/"* .claude/agents/
  touch .claude/.linear-cli-expert-setup
fi
```

## Why `/hyper-setup` Command Not Working

Possible issues:
1. **Frontmatter required:** Slash commands might need YAML frontmatter (I added this)
2. **Plugin not updated:** User may have cached version 1.0.0
3. **Command discovery timing:** Commands might only load on plugin install, not update
4. **File naming:** File is `hyper-setup.md` but might need different format

## Recommendation

**Use AUTOMATIC SessionStart hook** instead of manual `/hyper-setup` command:

**Pros:**
- No manual step required
- Runs automatically on first project session
- More reliable than command discovery
- Better UX - "just works"

**Cons:**
- Less explicit (user doesn't know it happened)
- Can't re-run easily to reset templates

**Best of both worlds:**
- Automatic SessionStart hook for initial setup
- Keep `/hyper-setup` command for manual re-initialization
