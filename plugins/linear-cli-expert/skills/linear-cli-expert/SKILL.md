---
name: linear-cli-expert
description: Expert guidance for spec-driven development with Linear CLI and AI agents. Orchestrates research, planning, and implementation workflows using specialized sub-agents. Use when managing complex projects, coordinating development workflows, or implementing spec-driven development with Linear as the source of truth.
---

# Linear CLI Expert

Orchestrator for spec-driven development workflows using Linear CLI and AI sub-agents.

## Overview

This skill helps you build software using a spec-driven development approach with Linear as your single source of truth. It uses three specialized sub-agents to guide you through the complete development lifecycle:

1. **Research Agent** - Gathers information from codebases, documentation, and external sources
2. **Planning Agent** - Creates project plans, specifications, and task breakdowns
3. **Engineering Agent** - Implements tasks following the specifications

**Key Principle**: When AI writes the implementation, your specification becomes the source of truth. Not the code. The spec.

## Quick Start

### Basic Workflow

```bash
# 1. Research: Gather information about what you're building
# The research agent will launch parallel sub-agents to investigate
# your codebase, docs, and external resources

# 2. Planning: Create project plan and task breakdown
# The planning agent reviews research and creates structured specs
# in Linear as documents, then breaks down into sequenced tasks

# 3. Implementation: Execute tasks
# The engineering agent reads specs and implements each task,
# updating Linear as work progresses
```

## Workflow Phases

### Phase 1: Research

**When to use**: Starting a new feature, investigating a problem, or gathering context before planning.

**What it does**:
- Launches multiple parallel research sub-agents
- Investigates codebase architecture and patterns
- Reviews existing documentation
- Fetches external resources (links, docs, references)
- Documents all findings in Linear documents (linked to project)

**How to invoke**: Ask to research a topic or feature. The skill will automatically launch the research-agent sub-agent.

**Example**:
> "I need to add OAuth authentication to our API. Can you research our current auth implementation and document how OAuth should integrate?"

**Output**: Linear documents containing:
- Current implementation analysis
- External research findings
- Integration recommendations
- Next steps for planning

**Customization**: Edit `agents/research-agent.md` to customize research behavior, tools, or output format.

---

### Phase 2: Planning

**When to use**: After research is complete, when you need to create a structured plan and task breakdown.

**What it does**:
- Reviews all research documents from Phase 1
- Creates comprehensive project plan
- Writes implementation specifications
- Breaks down work into sequenced Linear tasks
- Applies appropriate labels and priorities
- Sets up task dependencies using `--blocks` relationships

**Feedback Loop**: After initial plan creation, you can:
- Review and approve the plan
- Request modifications
- Ask for more detail in specific areas
- Refine task breakdown

**How to invoke**: Ask to create a plan or break down work into tasks. The skill will automatically launch the planning-agent sub-agent.

**Example**:
> "Review the OAuth research docs and create a project plan with implementation tasks. Break it down into phases with proper sequencing."

**Output**:
- Project with milestones in Linear
- Implementation documents/specs
- Sequenced tasks with dependencies
- Labels applied (Work-Type, Scope, Priority)

**Task Sequencing**: The planning agent uses `--blocks` to create dependency chains:
```bash
# Foundation work created first
DB_TASK="ENG-100"

# Dependent work blocks on foundation
linear issue create --title "API layer" --blocks ENG-100
linear issue create --title "Frontend" --blocks ENG-100
```

**Customization**: Edit `agents/planning-agent.md` to customize planning behavior, task templates, or label strategies.

---

### Phase 3: Implementation

**When to use**: After planning is approved and tasks are ready in Linear with status "To Do".

**What it does**:
- Reads task specifications and related documents
- Reviews codebase patterns before implementing
- Writes code following established conventions
- Updates task status as work progresses
- Creates sub-tasks when needed

**Implementation Process**:
1. Agent reads Linear task with `linear issue view TASK-ID --json`
2. Reads all linked documents and specifications
3. Reviews codebase for existing patterns
4. Implements following spec and patterns
5. Updates task status: `linear issue update TASK-ID --state "In Progress"`
6. Completes and marks done: `linear issue update TASK-ID --state "Done"`

**How to invoke**: Ask to implement a specific task by ID or description. The skill will automatically launch the engineering-agent sub-agent.

**Example**:
> "Implement task ENG-123 for OAuth token generation"

**Output**:
- Implemented code following specifications
- Updated task status in Linear
- Sub-tasks created if needed
- Progress documented

**Customization**: Edit `agents/engineering-agent.md` to customize implementation behavior, code review steps, or status updates.

## Agent Configurations

All agents are configured in the `agents/` directory and can be customized for your workflow.

### Research Agent

**File**: `agents/research-agent.md`

**Tools**: Read, Grep, Glob, Bash, WebFetch, Task

**Customization Points**:
- Research depth (quick scan vs comprehensive analysis)
- Documentation format (structure and detail level)
- External resource handling
- Linear document templates

**Default Behavior**: Launches 3-5 parallel sub-agents to investigate different areas simultaneously, with each sub-agent focused on a specific area for efficiency.

### Planning Agent

**File**: `agents/planning-agent.md`

**Tools**: Read, Grep, Task, Bash

**Customization Points**:
- Task breakdown granularity
- Label application strategy
- Milestone structure
- Dependency detection rules
- Estimation approach

**Default Behavior**: Creates tasks with Work-Type, Scope, and Priority labels. Uses `--blocks` for sequential dependencies.

### Engineering Agent

**File**: `agents/engineering-agent.md`

**Tools**: Read, Edit, Write, Bash, Grep, Glob, Task

**Customization Points**:
- Code review requirements
- Testing expectations
- Documentation updates
- Status update frequency

**Default Behavior**: Reads all related Linear documents before starting implementation. Updates task status at each phase.

## Linear CLI Best Practices

### Always Use JSON Output

All Linear CLI commands should use `--json` for programmatic parsing:

```bash
# ✓ Correct
linear issue create --title "Task" --team ENG --json

# ✗ Avoid (human-readable only)
linear issue create --title "Task" --team ENG
```

### Check Success in Responses

```bash
RESULT=$(linear issue create --title "Task" --team ENG --json)
if echo "$RESULT" | jq -e '.success' > /dev/null; then
  ISSUE_ID=$(echo "$RESULT" | jq -r '.issue.identifier')
  echo "Created $ISSUE_ID"
else
  echo "Failed: $(echo "$RESULT" | jq -r '.error.message')"
fi
```

### Task Context Detection

The CLI can detect current task from project context:

```bash
# When working within a project context
linear issue view --current-project  # Shows current task
linear issue update --state "In Progress"  # Updates current task
```

### Issue Relationships for Dependencies

Use relationship flags to create task dependencies:

```bash
# Create foundation work
linear issue create --title "Database schema" --team ENG --json

# Create dependent work
linear issue create \
  --title "API implementation" \
  --team ENG \
  --blocks ENG-100 \
  --json

# View all relationships
linear issue relations ENG-100 --json
```

### Labels and Organization

Use hierarchical labels for better organization:

```bash
# Labels display as "parent/child"
linear issue create \
  --title "Fix API bug" \
  --label Bugfix Backend \
  --team ENG \
  --json
# Result: "Work-Type/Bugfix, Scope/Backend"
```

### Documents and Specifications

Create rich specification documents linked to projects:

```bash
# Create specification
SPEC="# OAuth Implementation

## Overview
[Your spec content here]

## Dependencies
- [ENG-100](https://linear.app/workspace/issue/ENG-100)

## Implementation Plan
[Details here]"

linear document create \
  --title "OAuth Specification" \
  --content "$SPEC" \
  --project "Auth System" \
  --json
```

**Cross-references**: Use markdown links with full URLs:
- Format: `[ENG-123](https://linear.app/workspace/issue/ENG-123)`
- Plain text like `ENG-123` won't create links

### Project and Milestone Management

```bash
# Create project
PROJECT=$(linear project create \
  --name "OAuth System" \
  --description "Add OAuth 2.0 authentication" \
  --team ENG \
  --lead @me \
  --priority 1 \
  --json)

PROJECT_ID=$(echo "$PROJECT" | jq -r '.project.id')
PROJECT_SLUG=$(echo "$PROJECT" | jq -r '.project.slug')

# Create milestone (requires UUID, not slug)
linear project milestone create $PROJECT_ID \
  --name "Phase 1: Core Features" \
  --target-date 2026-03-31 \
  --json

# Add status update
linear project update-create $PROJECT_SLUG \
  --body "Week 1: Research complete, planning in progress" \
  --health onTrack \
  --json
```

## Customization Guide

### Customizing Agent Behavior

Each agent can be customized by editing its configuration file in `agents/`:

1. **Modify the frontmatter** to change tools, model, or description
2. **Edit the system prompt** to adjust behavior
3. **Update customization points** documented in each agent

**Example**: To make the planning agent create more detailed tasks:

Edit `agents/planning-agent.md` and update the task breakdown section to specify more granular task creation.

### Customizing Label Structure

The planning agent applies labels from your Linear workspace. To customize which labels are used:

1. Edit `agents/planning-agent.md`
2. Find the "Label Application" section
3. Update the label selection logic

**Default labels used**:
- Work-Type: Feature, Bug, Enhancement, Refactor
- Scope: Frontend, Backend, API, Database, Infrastructure
- Priority: Critical, High, Medium, Low

### Customizing Documentation Format

Research and planning agents create Linear documents. To customize format:

1. Edit the respective agent file (`research-agent.md` or `planning-agent.md`)
2. Find the "Output Format" section
3. Update the markdown template structure

### Workflow Preferences

You can adjust the workflow to match your team's process:

- **Skip research phase**: Directly invoke planning agent when context is known
- **Iterative planning**: Request multiple planning iterations with feedback
- **Parallel implementation**: Launch multiple engineering agents for independent tasks

## Common Patterns

### Pattern 1: New Feature Development

```
1. Research: "Research how to add OAuth to our API"
   → Launches research-agent
   → Creates research documents in Linear

2. Planning: "Create implementation plan for OAuth based on research"
   → Launches planning-agent
   → Creates project, milestones, tasks

3. Review: Review tasks, request refinements
   → "Make the task breakdown more granular"
   → Planning agent updates tasks

4. Implementation: "Implement ENG-123"
   → Launches engineering-agent
   → Implements task following spec
```

### Pattern 2: Bug Investigation and Fix

```
1. Research: "Investigate why authentication is failing on mobile"
   → Research agent analyzes codebase
   → Documents findings

2. Planning: "Create fix plan based on investigation"
   → Planning agent creates bug fix tasks
   → Sets up proper sequencing

3. Implementation: "Fix ENG-456"
   → Engineering agent implements fix
```

### Pattern 3: Large Project with Multiple Phases

```
1. Research: "Research microservices architecture for our platform"
   → Comprehensive research across multiple areas
   → Multiple documents created

2. Planning: "Create phased implementation plan"
   → Project with multiple milestones
   → Tasks sequenced across phases
   → Dependencies mapped

3. Implementation: Execute phase by phase
   → "Implement all Phase 1 tasks"
   → Engineering agent works through sequence
```

## Key Commands Reference

### Issues

```bash
# Create issue
linear issue create \
  --title "Task title" \
  --team ENG \
  --priority 1 \
  --assignee @me \
  --label Feature Backend \
  --project "Project Name" \
  --milestone "Phase 1" \
  --blocks ENG-100 \
  --json

# Update issue
linear issue update ENG-123 \
  --state "In Progress" \
  --assignee username \
  --json

# View issue with all metadata
linear issue view ENG-123 --json

# List issues
linear issue list --team ENG --json

# View relationships
linear issue relations ENG-123 --json
```

### Projects

```bash
# Create project
linear project create \
  --name "Project Name" \
  --description "Short description" \
  --team ENG \
  --lead @me \
  --priority 1 \
  --json

# Create milestone (needs project UUID)
PROJECT_ID=$(linear project view slug --json | jq -r '.project.id')
linear project milestone create $PROJECT_ID \
  --name "Milestone Name" \
  --target-date 2026-03-31 \
  --json

# Add status update
linear project update-create PROJECT-SLUG \
  --body "Status update text" \
  --health onTrack \
  --json
```

### Documents

```bash
# Create document
linear document create \
  --title "Document Title" \
  --content "$(echo "$CONTENT")" \
  --project "Project Name" \
  --json

# With current project context
linear document create \
  --title "Implementation Notes" \
  --content "$(echo "$NOTES")" \
  --current-project \
  --json
```

### Labels

```bash
# List team labels
linear label list --team ENG --json

# Create label
linear label create \
  --name "Label Name" \
  --color "#FF0000" \
  --team ENG \
  --json

# Create label group (parent)
linear label create \
  --name "Category" \
  --color "#0000FF" \
  --team ENG \
  --is-group \
  --json

# Create child label
linear label create \
  --name "Subcategory" \
  --parent "Category" \
  --team ENG \
  --json
```

## Important Notes

### User References
- Use `@me` for yourself, NOT `self`
- Use username or email for others

### Labels
- Space-separated: `--label A B C`
- NOT repeated: `--label A --label B` ❌
- Label groups: Parent must have `--is-group`, children use `--parent`

### Milestones
- Require project UUID (not slug)
- Get UUID: `linear project view SLUG --json | jq -r '.project.id'`

### Cross-References in Markdown
- Use full URLs: `[Text](https://linear.app/...)`
- Plain text like `ENG-123` won't create links ❌

### Content Fields
- Project description: Max 255 chars
- Project content: ~200KB
- Use variables for long content

### Error Handling
- Always check `success` field in JSON responses
- Parse error messages: `jq -r '.error.message'`

## Resources

### Detailed Documentation

For complete Linear CLI documentation, see:
- Installation: `docs/INSTALLATION.md`
- Usage Guide: `docs/USAGE.md`
- AI Agent Guide: `docs/AI_AGENT_GUIDE.md`

### Repository

Linear Agent CLI: https://github.com/juanbermudez/linear-agent-cli

---

**This skill is designed to work with the [Linear Agent CLI](https://github.com/juanbermudez/linear-agent-cli), making Linear your single source of truth for what you're building.**
