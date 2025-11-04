---
description: Initialize or reset Linear CLI Expert in this project
---

# Setup Linear CLI Expert for This Project

This command copies skills and agents from the plugin to your project's `.claude/` directory.

**Note:** The plugin automatically runs this setup on first session. Use this command to:
- Manually trigger setup if automatic setup failed
- Reset/update templates to latest versions
- Re-initialize after deleting `.claude/` directory

## Your Task

Run the setup script:

```bash
# Remove setup marker to force re-setup (optional)
rm -f .claude/.linear-cli-expert-setup

# Run setup
bash "${CLAUDE_PLUGIN_ROOT}/scripts/setup-project.sh"
```

This will:
1. Create `.claude/skills/linear-cli-expert/` with the main skill
2. Create `.claude/agents/` with research, planning, and engineering agents
3. Create `.claude/temp/hyper-init/` for initialization files
4. Mark setup as complete

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
