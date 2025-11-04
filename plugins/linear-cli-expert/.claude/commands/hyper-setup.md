---
description: Initialize Linear CLI Expert for this project by copying skills and agents to .claude/ directory
---

# Setup Linear CLI Expert for This Project

Initialize Linear CLI Expert plugin for this project by copying skills and agents to your project's `.claude/` directory.

## What This Does

This command sets up the Linear CLI Expert plugin for **this specific project** by:

1. **Copying the main skill** to `.claude/skills/linear-cli-expert/`
2. **Copying sub-agent templates** to `.claude/agents/`
3. **Creating initialization structure** at `.claude/temp/hyper-init/`

After setup, you can customize the agents for your specific codebase using `/hyper-init-all`.

## Your Task

Execute the following steps:

### Step 1: Create Project Directories

Create the necessary directories in the project:

```bash
mkdir -p .claude/skills/linear-cli-expert
mkdir -p .claude/agents
mkdir -p .claude/temp/hyper-init
```

### Step 2: Copy Main Skill

Copy the Linear CLI Expert skill from the plugin to the project:

```bash
cp -r "${CLAUDE_PLUGIN_ROOT}/templates/skills/linear-cli-expert/"* .claude/skills/linear-cli-expert/
```

This copies:
- `SKILL.md` - Main orchestrator skill
- Any supporting files

### Step 3: Copy Sub-Agent Templates

Copy the three sub-agent templates from the plugin to the project:

```bash
cp "${CLAUDE_PLUGIN_ROOT}/templates/agents/research-agent.md" .claude/agents/
cp "${CLAUDE_PLUGIN_ROOT}/templates/agents/planning-agent.md" .claude/agents/
cp "${CLAUDE_PLUGIN_ROOT}/templates/agents/engineering-agent.md" .claude/agents/
```

These are base templates that can be customized for your project.

### Step 4: Create Setup Marker

Mark the setup as complete:

```bash
touch .claude/.linear-cli-expert-setup
echo "Setup completed on $(date)" > .claude/.linear-cli-expert-setup
```

### Step 5: Add to .gitignore (Optional)

Consider what to track in git:

```bash
# If .gitignore exists, suggest additions
if [ -f .gitignore ]; then
  echo ""
  echo "📝 Consider adding to .gitignore:"
  echo ""
  echo "# Linear CLI Expert temporary files"
  echo ".claude/temp/"
  echo ""
  echo "Or keep everything in git to share customizations with your team."
fi
```

## Output Format

After completing the setup, provide a summary:

```markdown
# Linear CLI Expert - Project Setup Complete ✅

## What Was Installed

### Skills (Project-Level)
- ✅ `.claude/skills/linear-cli-expert/SKILL.md` - Main orchestrator skill

### Agents (Project-Level)
- ✅ `.claude/agents/research-agent.md` - Research agent template
- ✅ `.claude/agents/planning-agent.md` - Planning agent template
- ✅ `.claude/agents/engineering-agent.md` - Engineering agent template

### Directories Created
- ✅ `.claude/temp/hyper-init/` - Temporary initialization files

## Key Points

**✓ Project-Specific**: All files are in `.claude/` for this project only
**✓ Customizable**: Edit agents in `.claude/agents/` to match your workflow
**✓ Team-Shareable**: Commit to git to share with your team

## Next Steps

1. **Customize agents for your codebase** (recommended):
   ```
   /hyper-init-all
   ```
   This analyzes your codebase and Linear workspace to create optimized versions.

2. **Or start using right away**:
   ```
   "Use the research-agent to investigate authentication patterns"
   "Use the planning-agent to break down the mobile project"
   "Use the engineering-agent to implement ENG-123"
   ```

3. **Configure Linear CLI** (if not already done):
   ```bash
   linear config setup
   ```

## File Locations

All Linear CLI Expert files for this project are in:
```
.claude/
├── skills/
│   └── linear-cli-expert/
│       └── SKILL.md
├── agents/
│   ├── research-agent.md
│   ├── planning-agent.md
│   └── engineering-agent.md
└── temp/
    └── hyper-init/
```

## Customization Tips

**Edit agents** to match your project:
- `.claude/agents/research-agent.md` - Research depth, documentation format
- `.claude/agents/planning-agent.md` - Task granularity, label strategy
- `.claude/agents/engineering-agent.md` - Code review, testing requirements

**Share with team** via git:
```bash
git add .claude/
git commit -m "Add Linear CLI Expert configuration"
git push
```

Happy building! 🚀
```

## Important Notes

- Files are copied to **project directory** (`.claude/`), not global user config
- Each project gets independent, customizable copies
- Changes won't affect other projects
- Commit to git to share configurations with your team
- Re-run `/hyper-setup` to reset to default templates

## Troubleshooting

If setup fails:

1. **Check write permissions**: Ensure you can write to `.claude/` directory
2. **Check plugin installation**: Run `/plugin list` to verify plugin is installed
3. **Check CLAUDE_PLUGIN_ROOT**: Should be set by Claude Code automatically
4. **Manual verification**: Check if files exist at the plugin location:
   ```bash
   ls "${CLAUDE_PLUGIN_ROOT}/templates/skills/linear-cli-expert/"
   ls "${CLAUDE_PLUGIN_ROOT}/templates/agents/"
   ```

Begin the setup process now.
