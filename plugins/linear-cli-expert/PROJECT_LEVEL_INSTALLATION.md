# Project-Level Installation Design

## Overview

The Linear CLI Expert plugin now installs skills and agents at the **project level** rather than globally. This allows each project to have customized configurations that can be shared with the team via git.

## Architecture

### Before (Global Installation)

```
~/.claude/plugins/linear-cli-expert@hyper-engineering-tools/
├── skills/
│   └── linear-cli-expert/
│       └── SKILL.md (global, shared across all projects)
└── agents/
    ├── research-agent.md (global templates)
    ├── planning-agent.md
    └── engineering-agent.md
```

**Problems:**
- All projects shared the same skill and agent configurations
- Customizations affected all projects
- Team members couldn't share project-specific configurations

### After (Project-Level Installation)

```
# Plugin (templates only)
~/.claude/plugins/linear-cli-expert@hyper-engineering-tools/
├── skills/
│   └── linear-cli-expert/ (base templates)
└── agents/ (base templates)

# Each Project (independent copies)
my-project/
└── .claude/
    ├── skills/
    │   └── linear-cli-expert/
    │       └── SKILL.md (project-specific)
    ├── agents/
    │   ├── research-agent.md (customized for project)
    │   ├── planning-agent.md (customized for project)
    │   └── engineering-agent.md (customized for project)
    └── temp/
        └── hyper-init/ (initialization findings)
```

**Benefits:**
- ✅ Each project has independent configurations
- ✅ Customize agents per project
- ✅ Share with team via git
- ✅ Different workflows for different projects

## Installation Flow

### 1. Plugin Installation (One-Time, Global)

```bash
/plugin install linear-cli-expert@hyper-engineering-tools
```

**What happens:**
- Plugin files copied to `~/.claude/plugins/`
- Linear CLI installed globally via Deno
- SessionStart hook activated
- Base templates available in plugin directory

### 2. Project Setup (Per-Project)

```bash
/hyper-setup
```

**What happens:**
- Creates `.claude/skills/linear-cli-expert/`
- Creates `.claude/agents/`
- Copies SKILL.md from plugin to project
- Copies agent templates from plugin to project
- Creates `.claude/.linear-cli-expert-setup` marker
- Skills and agents now available at project level

### 3. Customization (Optional, Per-Project)

```bash
/hyper-init-all
```

**What happens:**
- Analyzes codebase and Linear workspace
- Customizes agents in `.claude/agents/`
- Creates findings in `.claude/temp/hyper-init/`

## User Experience

### First Time in a Project

```
$ claude

✓ Linear Agent CLI ready (v1.0.0)

📦 Linear CLI Expert plugin is ready!

⚠️  This project needs to be initialized first.

🚀 Run: /hyper-setup

This will copy skills and agents to .claude/ for this project.
```

### After Running /hyper-setup

```
$ /hyper-setup

# Linear CLI Expert - Project Setup Complete ✅

## What Was Installed

### Skills (Project-Level)
- ✅ `.claude/skills/linear-cli-expert/SKILL.md` - Main orchestrator skill

### Agents (Project-Level)
- ✅ `.claude/agents/research-agent.md` - Research agent template
- ✅ `.claude/agents/planning-agent.md` - Planning agent template
- ✅ `.claude/agents/engineering-agent.md` - Engineering agent template

## Next Steps

1. Customize agents: /hyper-init-all
2. Configure Linear: linear config setup
3. Start using the agents!
```

### Subsequent Sessions

```
$ claude

✓ Linear Agent CLI ready (v1.0.0)

# No setup warning - project is initialized
```

## File Locations

### Plugin Files (Templates)
```
~/.claude/plugins/linear-cli-expert@hyper-engineering-tools/
├── .claude-plugin/
│   └── plugin.json
├── .claude/
│   └── commands/
│       ├── hyper-setup.md (NEW)
│       ├── hyper-welcome.md (updated)
│       ├── hyper-init-all.md
│       ├── hyper-init-research-agent.md
│       ├── hyper-init-planning-agent.md
│       └── hyper-init-engineering-agent.md
├── skills/
│   └── linear-cli-expert/
│       └── SKILL.md (base template)
├── agents/
│   ├── research-agent.md (base template)
│   ├── planning-agent.md (base template)
│   └── engineering-agent.md (base template)
├── scripts/
│   └── ensure-cli-installed.sh (updated)
└── README.md (updated)
```

### Project Files (Working Copies)
```
my-project/
├── .claude/
│   ├── .linear-cli-expert-setup (marker file)
│   ├── skills/
│   │   └── linear-cli-expert/
│   │       └── SKILL.md (project copy)
│   ├── agents/
│   │   ├── research-agent.md (project copy)
│   │   ├── planning-agent.md (project copy)
│   │   └── engineering-agent.md (project copy)
│   └── temp/
│       └── hyper-init/
│           ├── research-agent-findings.md
│           ├── planning-agent-findings.md
│           └── engineering-agent-findings.md
└── .gitignore (optional: add .claude/temp/)
```

## Git Integration

### What to Commit

**Recommended:**
```bash
git add .claude/skills/
git add .claude/agents/
git add .claude/.linear-cli-expert-setup
git commit -m "Add Linear CLI Expert configuration"
```

**Optional (exclude temporary files):**
```bash
# .gitignore
.claude/temp/
```

### Team Workflow

1. **Lead developer** sets up and customizes:
   ```bash
   /hyper-setup
   /hyper-init-all
   # Customize agents in .claude/agents/
   git add .claude/
   git commit -m "Configure Linear CLI Expert"
   git push
   ```

2. **Team members** get configuration automatically:
   ```bash
   git pull
   # .claude/ files are now available
   # No need to run /hyper-setup again
   ```

3. **Updates** can be made by any team member:
   ```bash
   # Edit .claude/agents/planning-agent.md
   git commit -m "Update planning agent task granularity"
   git push
   ```

## Command Reference

### New Commands

- **`/hyper-setup`** - Initialize plugin for this project (copies templates)
  - Creates `.claude/skills/`, `.claude/agents/`, `.claude/temp/`
  - Copies SKILL.md and agent templates to project
  - Only needed once per project

### Updated Commands

- **`/hyper-welcome`** - Updated to mention `/hyper-setup` first
- **`/hyper-init-all`** - Now works on project-level agents in `.claude/agents/`
- **`/hyper-init-research-agent`** - Customizes `.claude/agents/research-agent.md`
- **`/hyper-init-planning-agent`** - Customizes `.claude/agents/planning-agent.md`
- **`/hyper-init-engineering-agent`** - Customizes `.claude/agents/engineering-agent.md`

## Technical Details

### Environment Variables

- `CLAUDE_PLUGIN_ROOT` - Set by Claude Code, points to plugin directory
  - Used in `/hyper-setup` to copy templates
  - Used in `ensure-cli-installed.sh` for setup checks

### Marker Files

- `${CLAUDE_PLUGIN_ROOT}/.welcome-shown` - Plugin installed marker (global)
- `${CLAUDE_PLUGIN_ROOT}/.cli-installed` - Linear CLI installed marker (global)
- `.claude/.linear-cli-expert-setup` - Project initialized marker (per-project)

### Skill Discovery

Claude Code discovers skills from multiple locations in this order:

1. **Project Skills**: `.claude/skills/` (highest priority)
2. **Plugin Skills**: `~/.claude/plugins/*/skills/`
3. **Personal Skills**: `~/.claude/skills/`

After `/hyper-setup`, the project-level skill takes precedence.

### Agent Discovery

The Task tool looks for agents in:

1. **Project Agents**: `.claude/agents/` (highest priority)
2. **Plugin Agents**: `~/.claude/plugins/*/agents/`
3. **Personal Agents**: `~/.claude/agents/`

After `/hyper-setup`, project-level agents are used.

## Migration Guide

### For Existing Users

If you previously installed the plugin globally, migrate to project-level:

1. **In each project**, run:
   ```bash
   /hyper-setup
   ```

2. **Optionally customize** for each project:
   ```bash
   /hyper-init-all
   ```

3. **Commit to git**:
   ```bash
   git add .claude/
   git commit -m "Add Linear CLI Expert project configuration"
   ```

### For Plugin Developers

Key changes to enable project-level installation:

1. **Keep templates in plugin** (`skills/`, `agents/`)
2. **Add setup command** (`/hyper-setup`) to copy to project
3. **Update SessionStart hook** to check for project setup
4. **Document project-level approach** in README

## Benefits Summary

### For Individual Developers

- ✅ Customize agents per project without affecting others
- ✅ Experiment with configurations safely
- ✅ Reset to defaults with `/hyper-setup` anytime

### For Teams

- ✅ Share optimized configurations via git
- ✅ Consistent workflow across team members
- ✅ Version control for agent configurations
- ✅ Different workflows for different project types

### For Plugin Authors

- ✅ Provide sensible defaults
- ✅ Allow per-project customization
- ✅ Easy distribution via marketplace
- ✅ Clear separation of templates vs working copies

## Troubleshooting

### "Skill not found" Error

**Problem**: Claude can't find the linear-cli-expert skill

**Solution**: Run `/hyper-setup` in your project

### Setup Command Not Found

**Problem**: `/hyper-setup` command doesn't exist

**Solution**: Reinstall the plugin:
```bash
/plugin uninstall linear-cli-expert@hyper-engineering-tools
/plugin install linear-cli-expert@hyper-engineering-tools
```

### Changes Not Taking Effect

**Problem**: Edited agents but Claude still uses old behavior

**Solution**:
1. Check you edited `.claude/agents/`, not plugin templates
2. Restart Claude Code to reload configurations

### Team Member Setup

**Problem**: Team member pulled .claude/ but agents don't work

**Solution**:
1. Ensure they have plugin installed: `/plugin list`
2. If not: `/plugin install linear-cli-expert@hyper-engineering-tools`
3. Linear CLI setup: `linear config setup`

## Future Enhancements

Potential improvements to the project-level approach:

1. **Auto-detection**: Automatically run `/hyper-setup` on first use
2. **Selective copying**: Let users choose which agents to install
3. **Template updates**: Command to sync with latest plugin templates
4. **Configuration profiles**: Pre-built configurations for common project types
5. **Multi-project sync**: Share configurations across related projects

## Conclusion

The project-level installation approach provides the best of both worlds:

- **Ease of installation**: One-time plugin install via marketplace
- **Project flexibility**: Each project customizes independently
- **Team collaboration**: Share configurations via git
- **Clean separation**: Templates (plugin) vs working copies (project)

This design aligns with how developers naturally work: global tools, project-specific configurations.
