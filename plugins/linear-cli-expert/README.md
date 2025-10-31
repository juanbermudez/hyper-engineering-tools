# Linear CLI Expert Plugin

Spec-driven development workflow with Linear as your single source of truth.

## What's Included

This plugin bundles:

1. **Linear Agent CLI** - Command-line tool for Linear automation
2. **Linear CLI Expert Skill** - AI skill for orchestrating workflows
3. **Three Specialized Agents**:
   - Research Agent - Information gathering
   - Planning Agent - Project planning and task breakdown
   - Engineering Agent - Implementation

## Installation

```bash
# In Claude Code, add the marketplace
/plugin marketplace add https://github.com/juanbermudez/hyper-engineering-tools

# Install this plugin
/plugin install linear-cli-expert@hyper-engineering-tools

# Restart Claude Code
```

### Requirements

- **Deno**: The Linear Agent CLI requires Deno runtime
  - Install: https://docs.deno.com/runtime/getting_started/installation/
  - Quick install (macOS/Linux): `curl -fsSL https://deno.land/install.sh | sh`
  - Windows: `irm https://deno.land/install.ps1 | iex`

- **Linear API Key**: Required for Linear integration
  - Get your key: https://linear.app/settings/api
  - The CLI will prompt you on first use

### First-Time Setup

On first load, the plugin automatically installs the Linear Agent CLI. You'll see:

```
📦 Installing Linear Agent CLI...
✅ Linear Agent CLI installed successfully!
```

If installation fails:
1. Verify Deno is installed: `deno --version`
2. Manually install the CLI:
   ```bash
   cd ~/.claude/plugins/linear-cli-expert@hyper-engineering-tools/cli
   deno install --global --allow-all --name linear src/main.ts
   ```

## Usage

### Basic Workflow

The plugin provides a three-phase workflow for building features:

#### 1. Research Phase

Ask Claude to research what you're building:

```
"I need to add OAuth authentication to our API. Can you research our current auth implementation and document how OAuth should integrate?"
```

Claude launches the research agent, which:
- Investigates your codebase architecture
- Reviews existing documentation
- Fetches external resources (OAuth specs, best practices)
- Documents all findings in Linear

#### 2. Planning Phase

Once research is complete, ask for a plan:

```
"Review the OAuth research docs and create a project plan with implementation tasks. Break it down into phases with proper sequencing."
```

Claude launches the planning agent, which:
- Reviews all research documents
- Creates comprehensive project plan
- Writes implementation specifications
- Breaks down work into sequenced tasks with dependencies
- Creates everything in Linear (project, docs, milestones, tasks)

**Iterate on the plan:**
```
"Make the task breakdown more granular"
"Add a security review phase before implementation"
"Adjust the timeline to 8 weeks instead of 6"
```

#### 3. Implementation Phase

When ready to implement, reference specific tasks:

```
"Implement task ENG-123 for OAuth token generation"
```

Claude launches the engineering agent, which:
- Reads task specifications from Linear
- Reviews related documentation and project plan
- Studies existing codebase patterns
- Implements following conventions
- Updates task status in Linear

### Example: Full Feature Implementation

```
User: "Add Google OAuth login to our application"

Claude: [Launches research-agent]
- Researches current auth system
- Reviews Google OAuth documentation
- Documents findings in Linear
- Creates "Google OAuth Research" document

User: "Create implementation plan based on research"

Claude: [Launches planning-agent]
- Reviews research document
- Creates "OAuth System" project in Linear
- Writes implementation specs
- Creates 12 tasks across 3 milestones
- Tasks properly sequenced with dependencies

User: "Look good, but make task ENG-204 more granular"

Claude: [Updates planning]
- Breaks ENG-204 into 3 subtasks
- Adjusts dependencies
- Updates estimates

User: "Perfect. Implement ENG-201"

Claude: [Launches engineering-agent]
- Reads ENG-201 task and specs
- Studies existing auth code patterns
- Implements database schema changes
- Writes tests
- Updates ENG-201 status to "Done"
```

## Agent Customization

The plugin includes three customizable agents in `skills/linear-cli-expert/agents/`:

### Research Agent (`research-agent.md`)

**Customize:**
- Research depth (quick scan vs comprehensive analysis)
- Number of parallel sub-agents (default: 3-5)
- Documentation format and structure
- External resource handling

**Edit to change:**
```markdown
### 1. Research Depth

**Quick Scan** (default for small features):
- 2-3 parallel sub-agents
- Focus on immediate codebase area
```

### Planning Agent (`planning-agent.md`)

**Customize:**
- Task breakdown granularity (default: 1-8 points)
- Label application strategy
- Milestone structure (phase-based vs feature-based)
- Documentation level

**Edit to change:**
```markdown
### 1. Task Granularity

**Default**: 1-8 point tasks (1-2 days of work)

**More Granular**: Break into 1-3 point tasks
```

### Engineering Agent (`engineering-agent.md`)

**Customize:**
- Code review requirements
- Testing expectations
- Documentation standards
- Status update frequency

**Edit to change:**
```markdown
### 1. Code Review Requirements

**Default**: Self-review before marking done

**Strict**: Add review checklist
```

## Linear CLI Reference

The bundled Linear Agent CLI provides comprehensive Linear integration. All agents use it internally.

### Key Commands

```bash
# Issues
linear issue create --title "Task" --team ENG --priority 1 --json
linear issue update ENG-123 --state "In Progress" --json
linear issue view ENG-123 --json

# Projects
linear project create --name "Project" --team ENG --json
linear project milestone create UUID --name "Phase 1" --json

# Documents
linear document create --title "Spec" --content "..." --project "slug" --json
linear document list --project "slug" --json

# Labels
linear label list --team ENG --json
```

**Important**: Always use `--json` flag for programmatic usage.

For complete CLI documentation, see: https://github.com/juanbermudez/linear-agent-cli

## Workflow Principles

This plugin follows key principles for working with AI agents:

### Specs Are the Source of Truth

When AI implements, the specification matters more than the code. Put effort into clear, detailed specifications in Linear. Let agents figure out implementation.

### Keep Context Focused

Agents work on focused areas to stay efficient. Research launches parallel sub-agents to investigate different areas simultaneously. Planning synthesizes findings. Engineering implements focused tasks. This approach helps maintain quality by keeping each agent's work scoped appropriately.

### Task Sequencing

The planning agent uses `--blocks` relationships to create proper dependency chains:

```
Database schema (ENG-200)
  ↓ blocks
OAuth routes (ENG-203)
  ↓ blocks
Provider implementations (ENG-204, ENG-205)
  ↓ blocks
Account linking (ENG-206)
```

Agents automatically respect these dependencies.

### Iterative Refinement

Plans are starting points, not commandments. Review, refine, adjust:
- Request more granular tasks
- Adjust timelines
- Add phases
- Change priorities
- Update specs based on learnings

## Troubleshooting

### Linear CLI Not Installed

If you see "Linear Agent CLI not available":

1. Check Deno installation: `deno --version`
2. Install Deno if missing: https://docs.deno.com/runtime/getting_started/installation/
3. Manually install CLI:
   ```bash
   cd ~/.claude/plugins/linear-cli-expert@hyper-engineering-tools/cli
   deno install --global --allow-all --name linear src/main.ts
   ```

### Plugin Not Activating

1. Verify installation: `/plugin list`
2. Check it's enabled (should show checkmark)
3. Restart Claude Code
4. Try explicitly mentioning "Linear" in your request

### Agents Not Launching

Agents are model-invoked - Claude decides when to use them based on context. To ensure activation:

- Mention "research", "plan", or "implement" explicitly
- Reference Linear tasks by ID (e.g., "implement ENG-123")
- Ask for specific agent: "Launch research agent to investigate OAuth"

### Linear API Issues

If you see Linear API errors:

1. Verify API key: `linear whoami`
2. Check API key has correct permissions
3. Regenerate key if needed: https://linear.app/settings/api

## Files and Structure

```
linear-cli-expert/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── cli/                          # Bundled Linear Agent CLI
│   ├── src/
│   ├── deno.json
│   └── README.md
├── skills/
│   └── linear-cli-expert/
│       ├── SKILL.md             # Main skill definition
│       └── agents/
│           ├── research-agent.md    # Research agent config
│           ├── planning-agent.md    # Planning agent config
│           └── engineering-agent.md # Engineering agent config
├── scripts/
│   └── ensure-cli-installed.sh  # Auto-installation script
└── README.md                     # This file
```

## Contributing

Found ways to improve the workflow? Have suggestions for agent behavior?

- Open an issue: https://github.com/juanbermudez/hyper-engineering-tools/issues
- Submit a PR with improvements
- Share your customized agent configurations

## License

MIT License

Copyright (c) 2025 Juan Bermudez

See LICENSE file for details.

## Credits

- Linear Agent CLI forked from [@schpet/linear-cli](https://github.com/schpet/linear-cli)
- Workflow inspired by [@dexhorthy](https://x.com/dexhorthy)'s spec-driven development approach
- Built for [Claude Code](https://claude.com/claude-code) by Anthropic

---

**More Resources:**
- [Hyper-Engineering Tools Marketplace](https://github.com/juanbermudez/hyper-engineering-tools)
- [Linear Agent CLI Docs](https://github.com/juanbermudez/linear-agent-cli)
- [Claude Code Plugin Guide](https://docs.claude.com/en/docs/claude-code/plugins)
