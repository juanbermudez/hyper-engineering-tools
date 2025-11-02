# Initialize All Hyper-Engineering Agents

You are tasked with customizing all three hyper-engineering agents (research, planning, and engineering) for this specific codebase and Linear workspace. This command runs all three initialization processes sequentially.

## Overview

This will initialize:
1. **Research Agent** - Customized for this codebase's documentation and research patterns
2. **Planning Agent** - Customized for this team's Linear workflow and planning conventions
3. **Engineering Agent** - Customized for this codebase's tech stack and development practices

## Your Task

Run each initialization in sequence:

### Step 1: Initialize Research Agent

Execute the `/hyper-init-research-agent` command functionality:
- Analyze codebase documentation structure
- Investigate Linear workspace patterns
- Create customized research agent at `.claude/agents/research-agent.md`
- Generate findings at `.claude/temp/hyper-init/research-agent-findings.md`

### Step 2: Initialize Planning Agent

Execute the `/hyper-init-planning-agent` command functionality:
- Analyze Linear workspace configuration (workflows, labels, etc.)
- Study project and issue patterns
- Create customized planning agent at `.claude/agents/planning-agent.md`
- Generate findings at `.claude/temp/hyper-init/planning-agent-findings.md`

### Step 3: Initialize Engineering Agent

Execute the `/hyper-init-engineering-agent` command functionality:
- Analyze technology stack and code organization
- Study coding patterns and testing practices
- Create customized engineering agent at `.claude/agents/engineering-agent.md`
- Generate findings at `.claude/temp/hyper-init/engineering-agent-findings.md`

## Process

For each agent:
1. Create the `.claude/temp/hyper-init/` directory if it doesn't exist
2. Perform the analysis as described in the individual init commands
3. Generate the findings document
4. Create the customized agent file
5. Provide a brief summary before moving to the next agent

## Output Format

After completing all three initializations, provide:

### Summary Report

```markdown
# Hyper-Engineering Agents Initialization Complete

## Research Agent
- **Status**: ✅ Initialized
- **Location**: .claude/agents/research-agent.md
- **Key Findings**: [1-2 sentence summary]

## Planning Agent
- **Status**: ✅ Initialized
- **Location**: .claude/agents/planning-agent.md
- **Key Findings**: [1-2 sentence summary]
- **Team**: [TEAM-KEY]
- **Workflow States**: [count] states
- **Label Groups**: [count] groups

## Engineering Agent
- **Status**: ✅ Initialized
- **Location**: .claude/agents/engineering-agent.md
- **Key Findings**: [1-2 sentence summary]
- **Primary Language**: [language]
- **Test Framework**: [framework]

## Next Steps

1. Review the customized agents in `.claude/agents/`
2. Check the detailed findings in `.claude/temp/hyper-init/`
3. Adjust any agent configurations if needed
4. Start using the agents with project-specific context!

## Usage Examples

Now you can use the customized agents:
- "Use the research-agent to investigate OAuth implementation patterns"
- "Use the planning-agent to break down the mobile app project"
- "Use the engineering-agent to implement task ENG-123"
```

## Important Notes

- Each agent initialization may take 2-5 minutes depending on codebase size
- All temporary findings are saved in `.claude/temp/hyper-init/`
- Customized agents are created in `.claude/agents/` (project-level overrides)
- You can re-run this command anytime to update agent customizations
- Individual agent init commands can be run separately if needed

Begin the full initialization process now. Provide progress updates as you complete each agent.
