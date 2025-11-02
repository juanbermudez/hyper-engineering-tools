# Initialize Planning Agent for This Codebase

You are tasked with customizing the planning-agent for this specific codebase and Linear workspace. Your goal is to understand how work is planned, structured, and managed in this project to create a tailored version of the planning agent.

## Your Task

### Phase 1: Codebase Analysis

Explore and document the following:

1. **Project Planning Artifacts**:
   - Where are specs/requirements stored? (docs/specs/, Linear, etc.)
   - What format are implementation plans in?
   - Are there project templates or examples?
   - How detailed are typical specs?

2. **Code Architecture**:
   - What is the high-level architecture?
   - How is work typically broken down? (by feature, module, layer)
   - What are common implementation patterns?
   - What testing strategies are used?

3. **Task Breakdown Patterns**:
   - How granular are typical tasks?
   - How are dependencies managed?
   - What information is included in task descriptions?

### Phase 2: Linear Workspace Analysis

Using the Linear CLI, investigate the team's planning patterns:

1. **Team Structure and Workflow**:
   ```bash
   linear team list --json
   linear workflow list --team TEAM-KEY --json
   linear label list --team TEAM-KEY --json
   ```
   - What workflow states exist? (Todo, In Progress, Done, etc.)
   - What custom states are used?
   - How does work flow through states?

2. **Label Hierarchy**:
   ```bash
   linear label list --team TEAM-KEY --json
   ```
   - What label groups exist? (Priority, Work-Type, Scope, etc.)
   - What labels are commonly used?
   - How are labels used to categorize work?

3. **Project Patterns**:
   ```bash
   linear project list --json
   ```
   - How are projects structured?
   - What project metadata is common? (milestones, status, etc.)
   - How detailed are project descriptions vs content?

4. **Issue Structure**:
   ```bash
   linear issue list --json | head -n 50
   ```
   - How are issues titled? (patterns, conventions)
   - How detailed are issue descriptions?
   - How are parent/child issues used?
   - What relationships are common? (blocks, related-to)

5. **Milestones and Cycles**:
   - Are milestones used? How?
   - Are cycles/sprints used? What's the pattern?
   - How is work scoped to milestones?

### Phase 3: Create Temporary Findings

Create a temporary findings document at `.claude/temp/hyper-init/planning-agent-findings.md` with:

```markdown
# Planning Agent Customization Findings

## Codebase Planning Patterns

### Specification Format
- [Where specs live and what format they use]

### Implementation Plan Structure
- [How plans are typically organized]

### Task Granularity
- [How work is broken down in this codebase]

### Architecture Patterns
- [Key architectural decisions that affect planning]

## Linear Workspace Configuration

### Team: [TEAM-KEY]

### Workflow States
- [List all states in order]
- [Note any custom states]

### Label Hierarchy
```
[Group]/[Label]:
- Priority/Critical
- Priority/High
- Work-Type/Feature
- Work-Type/Bug
...
```

### Project Patterns
- [How projects are structured]
- [Common project metadata]
- [Milestone usage patterns]

### Issue Conventions
- Title format: [describe pattern]
- Description detail: [how detailed]
- Parent/child usage: [when/how used]
- Relationships: [common patterns]

### Cycles/Sprints
- [Are they used? How long? How named?]

## Planning Workflow Recommendations

### Task Breakdown for This Team
1. [Specific guidance based on findings]
2. [Granularity recommendations]
3. [Metadata to include]

### Linear Integration Patterns
- [How to structure projects]
- [How to create milestones]
- [How to label issues]
- [How to create dependencies]

### Example Planning Flow
[Step-by-step example of planning a feature for THIS team]

### Team-Specific Guidelines
- [Any unique conventions to follow]
- [Common pitfalls to avoid]
```

### Phase 4: Customize Planning Agent

Read the current planning agent at `agents/planning-agent.md` and create an enhanced version at `.claude/agents/planning-agent.md` (project-level override) that includes:

1. **Team-Specific Workflow**:
   - Add a "## Team Workflow" section with actual workflow states
   - Include when to use each state
   - Show how work progresses through states

2. **Label and Metadata Guidance**:
   - Document the actual label hierarchy
   - Show examples of how to label different types of work
   - Include priority/estimate conventions

3. **Project Planning Templates**:
   - Provide templates that match this team's patterns
   - Include actual milestone structures if used
   - Show how to break down work for this team

4. **Issue Creation Patterns**:
   - Show title/description conventions
   - Include examples of actual issues from this team
   - Demonstrate relationship patterns (blocks, related-to)

5. **Example Planning Scenarios**:
   - Provide 2-3 complete examples for this team
   - Show how to plan a new feature end-to-end
   - Demonstrate task sequencing and dependencies

## Output

At the end, provide:

1. **Summary of findings** (brief overview)
2. **Path to customized agent**: `.claude/agents/planning-agent.md`
3. **Recommendations**: Any additional setup or configuration needed
4. **Team workflow reference**: Quick reference of states, labels, patterns

## Important Notes

- Create all temporary files in `.claude/temp/hyper-init/` (create directory if needed)
- The customized agent goes in `.claude/agents/planning-agent.md` (project-level)
- This overrides the plugin's default planning-agent for this project
- Preserve all original agent capabilities while adding project-specific context
- Use actual examples from the Linear workspace
- Include real label names, workflow states, and team conventions
- Test all Linear CLI commands to ensure they work

Begin the initialization process now.
