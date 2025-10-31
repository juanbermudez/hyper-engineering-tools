# Hyper-Engineering Tools

Tools for building product faster with AI coding agents.

## What This Is

This is a collection of tools I've put together while figuring out how to ship code at a rate I never thought possible. This is not vibe-coding. When AI writes the implementation, your specification becomes the source of truth. Not the code. The spec.

## Installation

```bash
# Add the marketplace
/plugin marketplace add https://github.com/juanbermudez/hyper-engineering-tools

# Install Linear CLI Expert
/plugin install linear-cli-expert@hyper-engineering-tools

# Restart Claude Code
```

The plugin automatically installs the [Linear Agent CLI](https://github.com/juanbermudez/linear-agent-cli) when you first load it.

**Requirements:**
- [Deno](https://docs.deno.com/runtime/getting_started/installation/) - Required for Linear Agent CLI
- Linear API key - Set up during first use

## Available Tools

### Linear CLI Expert

Transform Linear into your spec-driven development platform using AI agents.

**What's Included:**
- **Linear Agent CLI** - Bundled CLI tool for Linear automation
- **Research Agent** - Gathers information from codebases, docs, and external sources
- **Planning Agent** - Creates project plans and breaks down work into tasks
- **Engineering Agent** - Implements tasks following specifications

**Workflow:**

1. **Research & Draft**
   > "Research how to add OAuth to our API"

   The research agent launches parallel sub-agents to investigate your codebase, review documentation, and fetch external resources. All findings are documented in Linear.

2. **Plan & Break Down**
   > "Create implementation plan for OAuth based on research"

   The planning agent reviews research documents, creates a comprehensive project plan with milestones, writes implementation specs, and breaks down work into sequenced tasks with proper dependencies.

3. **Review & Refine**

   Review the generated plan and tasks. Request changes:
   > "Make the task breakdown more granular"
   > "Add a Phase 0 for security review"

4. **Implement**
   > "Implement task ENG-123"

   The engineering agent reads task specs and related documentation, studies existing codebase patterns, implements following conventions, and updates Linear as work progresses.

5. **Iterate**

   Continue implementing tasks, updating specs based on learnings, and refining the plan as you go.

**Key Features:**
- **Parallel Research**: Launches multiple sub-agents simultaneously
- **Focused Work**: Each agent tackles specific areas to stay efficient
- **Task Sequencing**: Automatic dependency management with `--blocks`
- **Linear Integration**: All specs, docs, and tasks live in Linear
- **Customizable**: Modify agent behavior by editing configuration files

This plugin is designed to work with Linear as your single source of truth for what you're building.

## Principles

These aren't grand architectural ideas. They're what I've learned actually works when building with AI:

### Specs Are the Source of Truth

When AI writes your code, the specification matters more than the implementation. Put your effort into clear, detailed specifications—in Linear, in docs, wherever—and let the agent figure out the implementation.

### Keep Context Focused

When the agent is juggling too much, quality drops. Keep each task focused, each spec contained. Sub-agents as researchers is key here—use your main agent as a coordinator for collecting details from your codebase, docs, etc. This keeps individual agents focused on specific areas rather than trying to handle everything at once.

### Don't Be Precious With Code

It's okay to trash an implementation that went wrong and start over. Sometimes fixing broken code takes longer than rewriting it. The spec is what matters. The code is disposable.

### Use Tokens Liberally

Don't optimize for token usage. That's the wrong metric. Optimize for getting to working code faster. If the agent needs to read the entire file to understand context, let it. If it needs to generate verbose explanations, that's fine. Tokens are cheap. Your time isn't.

## Customization

The plugin includes customizable agent configurations:

```
plugins/linear-cli-expert/
└── skills/
    └── linear-cli-expert/
        └── agents/
            ├── research-agent.md    # Customize research behavior
            ├── planning-agent.md    # Customize planning approach
            └── engineering-agent.md # Customize implementation standards
```

Edit these files to adjust:
- Research depth and documentation format
- Task breakdown granularity and label strategy
- Code quality requirements and testing expectations

See each agent file for specific customization points.

## Background

I used to be a software engineer (not a great one) and product designer. Then I became a founder and product leader at early-stage companies. I wasn't writing code anymore—I was thinking about product, talking to customers, managing teams.

In early 2025 I started diving into using coding agents, and have been obsessively learning about it. It has been life-changing.

I think this is what building product will look like in the coming years as more people adopt this approach. You don't need to be a 10x engineer. You do need to understand system design, the technologies you're using, how things fit together. But here's the thing: LLMs aren't just good at writing code—they're also incredible learning tools. They can enable you to address some of your blindspots and improve your technical proficiency, which is critical when it comes to generating a good spec.

This is my attempt to share the tools and workflows I've been learning, and might help others jumping on this journey.

## Contributing

If you've built tools that make working with AI agents better, I'd love to see them here. Open a PR, add your plugin, share what you've learned.

**Plugin structure:**
```
plugins/your-plugin-name/
├── .claude-plugin/
│   └── plugin.json
└── skills/
    └── your-skill/
        ├── SKILL.md
        └── agents/
            └── your-agent.md
```

See [Claude Code Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins) for details.

## Resources

Great talks and people to follow to learn about hyper-engineering: [@dexhorthy](https://x.com/dexhorthy), [@GeoffreyHuntley](https://x.com/GeoffreyHuntley), [@sgrove](https://x.com/sgrove), and [@ProgramWithAi](https://x.com/ProgramWithAi).

**Learning:**
- [Advanced Context Engineering (Dex Horthy)](https://www.youtube.com/watch?v=IS_y40zY-hc)
- [Specs as Code (Geoffrey Huntley)](https://ghuntley.com/specs/)
- [Ralph - AI Tool That Works For You (Geoffrey Huntley)](https://ghuntley.com/ralph/)
- [Building Products with AI Agents (Simon Willison)](https://www.youtube.com/watch?v=8rABwKRsec4)
- [The New Code (Sean Grove, OpenAI)](https://www.youtube.com/watch?v=J3oJqan2Gv8)

**Tools:**
- [Linear Agent CLI](https://github.com/juanbermudez/linear-agent-cli)
- [Claude Code Skills](https://docs.claude.com/en/docs/claude-code/skills)
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)

## Troubleshooting

**Plugin not working:**
- Check installation: `/plugin list`
- Verify marketplace: `/plugin marketplace list`
- Restart Claude Code
- Mention "Linear" explicitly in your requests

**Linear CLI not installing:**
- Ensure Deno is installed: `deno --version`
- Install Deno: https://docs.deno.com/runtime/getting_started/installation/
- Manually install CLI: See plugin README

**Need help:**
- [Open an issue](https://github.com/juanbermudez/hyper-engineering-tools/issues)

## License

MIT License - See individual plugins for their licenses.

## Thanks

- [@dexhorthy](https://x.com/dexhorthy) - For the spec-driven development approach
- [@schpet](https://github.com/schpet) - For creating the original Linear CLI
- Anthropic - For building Claude and Claude Code

---

_If this helps you ship faster, star the repo and share what you build._
