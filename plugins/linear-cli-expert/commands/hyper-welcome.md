---
description: Learn about the Linear CLI Expert plugin features and how to get started
---

# Welcome to Linear CLI Expert Plugin! 🚀

Thank you for installing the Linear CLI Expert plugin for Claude Code. This plugin provides specialized agents and tools for spec-driven development with Linear.

## What's Included

### 🤖 Three Specialized Agents
- **Research Agent** - Gathers information from codebases, docs, and Linear
- **Planning Agent** - Creates project plans and task breakdowns in Linear
- **Engineering Agent** - Implements tasks following specs and patterns

### 🛠️ Linear CLI Integration
- Complete Linear CLI automatically installed and configured
- Full CRUD operations for issues, projects, documents, and more
- JSON output for automation and scripting

### 📚 Linear CLI Expertise Skill
- Comprehensive knowledge of Linear CLI commands and patterns
- Available to all agents and your main conversation

## Quick Start

### 1. Initialize This Project (Required)

Set up Linear CLI Expert for **this specific project**:

```
/hyper-setup
```

This copies skills and agents to `.claude/` in your project directory, making them:
- ✅ Project-specific and customizable
- ✅ Shareable with your team via git
- ✅ Independent from other projects

### 2. Configure Linear API Key (Required)

If you haven't already, set up your Linear API key:

```bash
linear config setup
```

Or manually:
```bash
linear config set auth.token "lin_api_..."
linear config set defaults.team "TEAM-KEY"
```

Get your API key at: https://linear.app/settings/api

### 3. Customize Agents for Your Codebase (Recommended)

The agents work out of the box, but they're much more powerful when customized for your specific codebase and Linear workspace:

```
/hyper-init-all
```

This will analyze your codebase and Linear workspace, then create customized versions of all three agents with:
- Your project's documentation structure
- Your team's Linear workflow and labels
- Your codebase's tech stack and patterns
- Project-specific examples and guidance

**Or initialize individually:**
```
/hyper-init-research-agent   # Customize research patterns
/hyper-init-planning-agent   # Customize for your Linear workflow
/hyper-init-engineering-agent # Customize for your tech stack
```

### 3. Start Using the Agents

Once customized, use the agents naturally:

```
"Use the research-agent to investigate how authentication works in our codebase"
"Use the planning-agent to break down the mobile app project into tasks"
"Use the engineering-agent to implement task ENG-123"
```

Or let Claude Code automatically delegate to the right agent based on your request!

## Workflow Example

### Spec-Driven Development Flow

1. **Research Phase**:
   ```
   "Research how to add OAuth to our API"
   ```
   → Research agent explores codebase, docs, and external resources
   → Creates research document in Linear

2. **Planning Phase**:
   ```
   "Create a plan for implementing OAuth based on the research"
   ```
   → Planning agent reviews research document
   → Creates project in Linear with milestones
   → Breaks down into sequenced tasks

3. **Implementation Phase**:
   ```
   "Implement task ENG-123"
   ```
   → Engineering agent reads task from Linear
   → Reviews linked specs and docs
   → Implements following established patterns
   → Updates task status

## Key Features

### Research Agent
- Parallel sub-agent execution for faster research
- Codebase pattern analysis
- External documentation fetching
- Linear document creation with cross-references

### Planning Agent
- Linear workspace-aware planning
- Project and milestone creation
- Task breakdown with dependencies
- Label hierarchy and metadata management

### Engineering Agent
- Linear task integration
- Spec-driven implementation
- Pattern-based code generation
- Test-aware development

## Available Commands

- `/hyper-init-all` - Initialize all agents for your codebase
- `/hyper-init-research-agent` - Customize research agent
- `/hyper-init-planning-agent` - Customize planning agent
- `/hyper-init-engineering-agent` - Customize engineering agent
- `/hyper-welcome` - Show this welcome message again

## Linear CLI Quick Reference

### Common Commands
```bash
# Issues
linear issue list
linear issue create --title "Task" --team ENG --json
linear issue view ENG-123

# Projects
linear project list
linear project create --name "Project" --team ENG --json

# Documents
linear document create --title "Spec" --project PROJECT-SLUG --json
linear document list --project PROJECT-SLUG

# Configuration
linear whoami
linear config get defaults
```

See the [Linear CLI documentation](https://github.com/juanbermudez/linear-agent-cli) for complete reference.

## Tips

1. **Initialize agents first** - They work much better when customized for your project
2. **Use explicit delegation** - Mention the agent name for complex tasks
3. **Review findings** - Check `.claude/temp/hyper-init/` for detailed analysis
4. **Iterate on customization** - Re-run init commands as your project evolves
5. **Leverage Linear** - Use it as your single source of truth for specs

## Need Help?

- **Linear CLI Issues**: https://github.com/juanbermudez/linear-agent-cli/issues
- **Plugin Issues**: https://github.com/juanbermudez/hyper-engineering-tools/issues
- **Documentation**: Check the README files in the repositories above

## Next Steps

1. ✅ Run `/hyper-setup` to initialize this project
2. ✅ Configure your Linear API key with `linear config setup`
3. ✅ Run `/hyper-init-all` to customize agents for your codebase
4. ✅ Start using the agents for spec-driven development!

## Project vs Global

**This plugin installs at the PROJECT level**, not globally:
- Each project gets its own copy of skills and agents in `.claude/`
- Customize agents independently per project
- Share configurations with your team via git
- Different projects can have different workflows

Happy building! 🚀
