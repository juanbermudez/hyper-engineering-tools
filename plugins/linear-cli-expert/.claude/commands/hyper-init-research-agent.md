---
description: Customize the research agent for this codebase through parallel sub-agent analysis
---

# Initialize Research Agent for This Codebase

You are tasked with customizing the **research-agent** located at `.claude/agents/research-agent.md` for this specific codebase and Linear workspace.

## Prerequisites

Ensure the project is initialized first:
- Run `/hyper-setup` if you haven't already
- Verify `.claude/agents/research-agent.md` exists

## Your Task

Use **2-5 sub-agents** to perform parallel research on different aspects of the codebase. Launch them simultaneously to gather comprehensive information efficiently.

### Step 1: Launch Parallel Research Sub-Agents

Create 2-5 research sub-agents, each focusing on a specific area:

**Sub-Agent 1: Documentation & Architecture**
```
Task: Analyze documentation structure and architecture patterns
Focus:
- Where documentation lives (docs/, README, wikis)
- Documentation formats (Markdown, JSDoc, inline comments)
- Architecture Decision Records (ADRs)
- External documentation (API docs, design docs, specifications)
- Overall project architecture and structure

Output: .claude/temp/hyper-init/research-1-documentation.md
```

**Sub-Agent 2: Technology Stack & Dependencies**
```
Task: Investigate tech stack, frameworks, and dependencies
Focus:
- Programming languages and versions
- Frameworks and libraries used
- Build tools and configuration
- External APIs and services integrated
- Database technologies

Output: .claude/temp/hyper-init/research-2-technology.md
```

**Sub-Agent 3: Code Organization & Patterns**
```
Task: Explore code structure and development patterns
Focus:
- Project directory structure
- Module/component organization
- Coding patterns and conventions
- Testing approach and coverage
- Development workflow (CI/CD, git flow)

Output: .claude/temp/hyper-init/research-3-codebase.md
```

**Sub-Agent 4: Linear Workspace Patterns** (Optional, if Linear CLI available)
```
Task: Analyze Linear workspace organization
Focus:
- Document structure in Linear (run: linear document list --json)
- Project organization (run: linear project list --json)
- Label hierarchy (run: linear label list --json)
- Workflow states (run: linear workflow list --json)
- Common patterns in issue/project naming

Output: .claude/temp/hyper-init/research-4-linear.md
```

**Sub-Agent 5: Research & Spec Patterns** (Optional)
```
Task: Identify how research and specifications are documented
Focus:
- RFCs or research document patterns
- How requirements are specified
- Design decision documentation
- Investigation/discovery processes
- Knowledge sharing practices

Output: .claude/temp/hyper-init/research-5-workflow.md
```

### Step 2: Launch Sub-Agents

Use the Task tool to launch 2-5 agents in parallel (in a single message):

```
Launch these agents simultaneously:
1. Documentation & Architecture agent
2. Technology Stack agent
3. Code Organization agent
4. Linear Workspace agent (if applicable)
5. Research Patterns agent (if applicable)
```

### Step 3: Synthesize Findings

After all sub-agents complete:

1. **Read all findings files** from `.claude/temp/hyper-init/research-*.md`

2. **Create consolidated findings** at `.claude/temp/hyper-init/research-agent-findings.md`:

```markdown
# Research Agent Customization Findings

## Codebase Characteristics

### Documentation
[Synthesize from research-1-documentation.md]
- Primary locations: ...
- Formats used: ...
- Architecture docs: ...

### Technology Stack
[Synthesize from research-2-technology.md]
- Languages: ...
- Frameworks: ...
- Key dependencies: ...

### Code Organization
[Synthesize from research-3-codebase.md]
- Structure: ...
- Patterns: ...
- Testing approach: ...

## Linear Workspace (if applicable)
[Synthesize from research-4-linear.md]
- Document patterns: ...
- Project structure: ...
- Labeling conventions: ...

## Research Workflow Patterns
[Synthesize from research-5-workflow.md]
- Spec documentation: ...
- Decision records: ...
- Investigation process: ...

## Recommendations for Research Agent

### Parallel Investigation Strategy
Based on findings, recommend how research agent should:
- Split research across sub-agents
- Optimal number of parallel agents (2-5)
- How to divide research topics

### Documentation Approach
- Where to create Linear documents
- How to structure research findings
- What format to use

### Codebase-Specific Tips
- Key areas to investigate first
- Common patterns to recognize
- External resources to reference

### Linear Integration
- How to link research to projects
- Label usage for research tasks
- Document organization strategy
```

### Step 4: Customize Research Agent

Update `.claude/agents/research-agent.md` based on findings:

1. **Read current agent**: `.claude/agents/research-agent.md`
2. **Read findings**: `.claude/temp/hyper-init/research-agent-findings.md`
3. **Update agent** with:
   - Project-specific documentation locations
   - Technology stack knowledge
   - Codebase organization understanding
   - Linear workspace conventions
   - Optimized parallel research strategy (2-5 agents)

**Customization areas**:
- Add project-specific context to system prompt
- Include examples from this codebase
- Reference key technologies and frameworks
- Add Linear document templates
- Specify optimal sub-agent count for this project

### Step 5: Summary

Provide a concise summary:

```markdown
# Research Agent Initialization Complete ✅

## Findings Created
- ✅ `.claude/temp/hyper-init/research-1-documentation.md`
- ✅ `.claude/temp/hyper-init/research-2-technology.md`
- ✅ `.claude/temp/hyper-init/research-3-codebase.md`
- ✅ `.claude/temp/hyper-init/research-4-linear.md` (if applicable)
- ✅ `.claude/temp/hyper-init/research-5-workflow.md` (if applicable)
- ✅ `.claude/temp/hyper-init/research-agent-findings.md` (consolidated)

## Agent Customized
- ✅ `.claude/agents/research-agent.md` updated with project-specific context

## Key Customizations
- [List 3-5 main customizations made]

## Recommended Usage
- Use [N] parallel sub-agents for research on this codebase
- Focus investigations on: [key areas]
- Create Linear documents in: [project/location]

## Next Steps
1. Test the customized research agent
2. Run /hyper-init-planning-agent to customize planning workflow
3. Start using research agent for actual investigations
```

## Important Notes

- **Use Task tool** to launch sub-agents in parallel (all in one message)
- **Each sub-agent** should create its own findings file
- **Synthesize** all findings into one consolidated document
- **Customize** the agent based on actual codebase characteristics
- **Reference** project-level agent at `.claude/agents/research-agent.md`
- **Sub-agents** are in `.claude/agents/` (project level, not global)

Begin the initialization process now. Launch 2-5 sub-agents in parallel to perform the research.
