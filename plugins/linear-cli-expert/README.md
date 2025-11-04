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

# Initialize for your project
/hyper-setup
```

**Important**: This plugin installs at the **project level**, not globally. Each project gets its own copy of skills and agents in `.claude/`, allowing you to customize independently and share with your team via git.

### Requirements

- **Deno**: The Linear Agent CLI requires Deno runtime
  - Install: https://docs.deno.com/runtime/getting_started/installation/
  - Quick install (macOS/Linux): `curl -fsSL https://deno.land/install.sh | sh`
  - Windows: `irm https://deno.land/install.ps1 | iex`

- **Linear API Key**: Required for Linear integration
  - Get your key: https://linear.app/settings/api
  - The CLI will prompt you on first use

### First-Time Setup

**Step 1: Plugin Installation**

On first load, the plugin automatically installs the Linear Agent CLI. You'll see:

```
📦 Installing Linear Agent CLI...
✅ Linear Agent CLI installed successfully!
```

If installation fails:
1. Verify Deno is installed: `deno --version`
2. Manually install the CLI:
   ```bash
   deno install --global --allow-all --name linear \
     https://raw.githubusercontent.com/juanbermudez/linear-agent-cli/main/src/main.ts
   ```

**Step 2: Project Initialization**

Initialize the plugin for your specific project:

```
/hyper-setup
```

This copies skills and agents to `.claude/` in your project:
- `.claude/skills/linear-cli-expert/` - Main orchestrator skill
- `.claude/agents/` - Research, planning, and engineering agents
- `.claude/temp/hyper-init/` - Temporary initialization files

After setup, commit to git to share with your team:
```bash
git add .claude/
git commit -m "Add Linear CLI Expert configuration"
```

## Usage

### How It Works

This plugin provides specialized agents that work **collaboratively with you** through an interactive process. The agents ask questions, present options, and help you make informed decisions before taking action.

#### Research Agent: Discovery & Analysis

**You start the conversation:**
```
"I want to add OAuth authentication to our API"
```

**The agent asks clarifying questions:**
- What's the goal? (understand current system, evaluate feasibility, etc.)
- What context exists? (existing tickets, specs, similar features)
- What decisions depend on this research?
- How deep should the investigation go?

**After you provide context, the agent:**
- Reads all mentioned documents and tickets
- Spawns parallel sub-agents to investigate different areas
- Synthesizes findings from codebase and external sources

**Then asks more questions based on findings:**
- "I found your current auth uses JWT. Should OAuth replace it or work alongside it?"
- "There are 3 approaches for token storage - which trade-offs matter most to you?"
- "Should I investigate how [related system] might be affected?"

**Finally creates:**
- Comprehensive research document in Linear with findings, options, and recommendations

#### Planning Agent: Strategy & Breakdown

**You ask for a plan:**
```
"Create an implementation plan for OAuth based on the research"
```

**The agent starts with questions about scope and approach:**
- What's in scope vs out of scope?
- What are the constraints? (timeline, technical limits, team capacity)
- What's the success criteria?
- Who's implementing and who needs to approve?

**After reading research, it presents options and asks for decisions:**
- "I see 3 architectural approaches: [A], [B], [C]. Here are the trade-offs..."
- "Should we tackle [complex part X] in phase 1 or defer it?"
- "The existing [system Y] will need changes - acceptable or should we work around it?"
- "This could be done in 3-5 weeks with shortcuts or 8-10 weeks more thoroughly - what's the priority?"

**You discuss and refine:**
```
"Let's go with Approach B, but defer the migration tool to v2"
"Make the first phase just the core flow, move error handling to phase 2"
"Actually, we need to handle Google and GitHub from the start, not just Google"
```

**The agent iterates:**
- Adjusts approach based on your feedback
- Presents revised plan structure
- Asks if phasing makes sense

**Once aligned, creates:**
- Detailed implementation plan in Linear
- Project with milestones and phases
- Sequenced tasks with dependencies
- Specifications and success criteria

**Key point:** The agent doesn't just accept "plan OAuth" and run off. It engages like a senior engineer would - asking about priorities, presenting trade-offs, challenging assumptions, and ensuring alignment before committing to a plan.

#### Engineering Agent: Implementation

**You reference a specific task:**
```
"Implement task ENG-201"
```

**The agent:**
- Reads task spec and related docs from Linear
- Studies existing codebase patterns
- Implements following established conventions
- Runs tests and verifies changes
- Updates task status in Linear

### What Makes This Different

**Traditional approach (oversimplified):**
```
User: "Research OAuth"
→ Agent dumps research document
User: "Create a plan"
→ Agent dumps plan with tasks
User: "Implement it"
→ Agent implements
```
*Result: Plans miss context, wrong assumptions, rework needed*

**This plugin's approach (collaborative):**
```
User: "Research OAuth"
→ Agent: "Let me understand what you need. What's the goal? [questions]"
User: [Provides context]
→ Agent: [Does research, comes back]
→ Agent: "Found X, Y, Z. But I have questions about [trade-offs]"
User: [Discusses, clarifies]
→ Agent: Creates thorough research document

User: "Create plan"
→ Agent: "Before I plan, let me clarify scope and constraints. [questions]"
User: [Discusses]
→ Agent: [Researches codebase, comes back]
→ Agent: "Here are 3 approaches with trade-offs. I recommend B because..."
User: "Makes sense, but let's defer the complex part"
→ Agent: "Okay, here's the revised structure. Does this phasing work?"
User: "Yes, but make phase 1 more granular"
→ Agent: [Adjusts, presents again]
→ Agent: Creates detailed plan

User: "Implement ENG-201"
→ Agent: [Implements following spec]
```
*Result: Well-informed decisions, aligned plans, less rework*

**The agents act like thoughtful engineers who ask questions and discuss trade-offs, not task robots that blindly execute.**

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
