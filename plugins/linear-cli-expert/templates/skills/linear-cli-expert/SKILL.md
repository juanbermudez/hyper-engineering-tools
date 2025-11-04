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
- **Creates a draft project in Linear** to organize all research
- Documents all findings as Linear documents **appended to the draft project**

**Research Project Setup**:
```bash
# Create draft project to organize research
PROJECT=$(linear project create \
  --name "Research: OAuth Authentication" \
  --description "Research phase for OAuth implementation" \
  --team ENG \
  --lead @me \
  --state draft \
  --json)

PROJECT_SLUG=$(echo "$PROJECT" | jq -r '.project.slug')

# Append research documents to the project
linear document create \
  --title "Current Auth Implementation Analysis" \
  --content "$RESEARCH_FINDINGS" \
  --project "$PROJECT_SLUG" \
  --json

linear document create \
  --title "OAuth 2.0 Research Findings" \
  --content "$OAUTH_RESEARCH" \
  --project "$PROJECT_SLUG" \
  --json
```

**How to invoke**: Ask to research a topic or feature. The skill will automatically launch the research-agent sub-agent.

**Example**:
> "I need to add OAuth authentication to our API. Can you research our current auth implementation and document how OAuth should integrate?"

**Output**:
- **Draft project** in Linear (status: "draft")
- **Multiple research documents** linked to the project containing:
  - Current implementation analysis
  - External research findings
  - Integration recommendations
  - Next steps for planning

**Key Benefit**: All research documents are organized under a single draft project, making it easy to:
- Find all research in one place
- Share the research project link with stakeholders
- Transition from draft → planned → in progress as work proceeds
- Keep research separate from implementation tasks

**Customization**: Edit `agents/research-agent.md` to customize research behavior, tools, or output format.

---

### Phase 2: Planning

**When to use**: After research is complete, when you need to create a structured plan and task breakdown.

**What it does**:
- Reviews all research documents from Phase 1 (from the draft project)
- **Transitions project from "draft" → "planned"** status
- Creates comprehensive implementation plan document
- Writes detailed specifications
- Breaks down work into sequenced Linear tasks
- Applies appropriate labels and priorities
- Sets up task dependencies using `--blocks` relationships
- Links all tasks to the project

**Project State Transition**:
```bash
# After research phase, transition project to planned
linear project update PROJECT-SLUG \
  --state planned \
  --json

# Add planning document to the same project
linear document create \
  --title "OAuth Implementation Plan" \
  --content "$IMPLEMENTATION_PLAN" \
  --project "PROJECT-SLUG" \
  --json
```

**Result**: The research project now contains both:
- Research documents (from Phase 1)
- Implementation plan and specs (from Phase 2)
- All tasks linked to the project

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

## Linear Workflow Management

### Team Workflow and Status Progression

When working with Linear, always follow the team's workflow states in the correct order:

```bash
# Get team workflow states
linear workflow list --team ENG --json

# Common workflow progression:
# Triage → Backlog → To Do → In Progress → In Review → Done → Canceled
```

**Status Transition Rules**:
- New issues default to "Triage" or "Backlog"
- Use "To Do" for ready-to-work tasks
- Use "In Progress" when actively working
- Use "In Review" when code is ready for review
- Use "Done" only when fully complete and verified
- Use "Canceled" for abandoned work

```bash
# Start working on a task
linear issue update ENG-123 --state "In Progress" --json

# Submit for review
linear issue update ENG-123 --state "In Review" --json

# Complete task
linear issue update ENG-123 --state "Done" --json
```

### Default Values and Conventions

Apply consistent defaults for all Linear operations:

**Default Priority Levels**:
- 0 = No priority (default)
- 1 = Urgent (critical issues, blockers)
- 2 = High (important features)
- 3 = Normal (standard work)
- 4 = Low (nice-to-haves)

**Default Assignee**:
- Use `@me` when creating tasks for yourself
- Leave unassigned if delegating to team

**Default Team**:
```bash
# Query default team from config
DEFAULT_TEAM=$(linear config get defaults.team)

# Use in commands
linear issue create --title "Task" --team $DEFAULT_TEAM --json
```

### Automatic Label Assignment

Apply labels consistently based on task type and scope:

**Work-Type Labels** (choose one):
- `feature` - New functionality
- `bug` - Bug fixes
- `enhancement` - Improvements to existing features
- `refactor` - Code restructuring
- `docs` - Documentation updates
- `test` - Test additions/fixes

**Scope Labels** (choose one or more):
- `frontend` - UI/UX work
- `backend` - Server/API work
- `database` - Database changes
- `infrastructure` - DevOps/deployment
- `security` - Security-related changes

**Priority Labels** (when applicable):
- `critical` - System down, data loss risk
- `high` - Major functionality broken
- `medium` - Standard priority
- `low` - Nice-to-have improvements

```bash
# Example: Bug fix with proper labels
linear issue create \
  --title "Fix login timeout on mobile" \
  --team ENG \
  --priority 1 \
  --label bug frontend security \
  --assignee @me \
  --json
```

### Comment Quality Guidelines

When adding comments to Linear issues, follow these standards:

**Good Comment Structure**:
```markdown
[Brief summary of what happened]

**Changes Made**:
- [Specific change 1 with file reference]
- [Specific change 2 with file reference]

**Testing**:
- [What was tested]
- [Test results]

**Next Steps** (if applicable):
- [What needs to happen next]
```

**Examples**:

✅ **Good Comment**:
```bash
linear issue comment ENG-123 "Completed OAuth token generation implementation.

**Changes Made**:
- \`src/auth/oauth.ts\` - Added token generation logic
- \`src/auth/oauth.test.ts\` - Added unit tests (15 test cases)
- \`src/types/auth.ts\` - Added TokenResponse interface

**Testing**:
- All unit tests pass (\`npm test\`)
- Manual testing with Google OAuth provider successful
- Token refresh flow verified

**Next Steps**:
- Ready for code review
- Blocked on ENG-124 (token validation) before deployment" --json
```

❌ **Bad Comment**:
```bash
linear issue comment ENG-123 "done" --json
```

### Action-Specific Instructions

#### Creating Issues

**Always include**:
- Descriptive title (not "Fix bug" but "Fix authentication timeout on mobile")
- Clear description with context
- Appropriate labels
- Team assignment
- Priority level

**When creating from research**:
```bash
# Link to research document in description
linear issue create \
  --title "Implement OAuth 2.0 authentication" \
  --description "$(cat <<'EOF'
Implement OAuth 2.0 based on research findings.

**Research Document**: [OAuth Research](https://linear.app/workspace/document/abc)

**Requirements**:
- Support Google and GitHub providers
- Implement token refresh flow
- Add proper error handling

**Success Criteria**:
- All tests pass
- Documentation updated
- Security review complete
EOF
)" \
  --team ENG \
  --priority 2 \
  --label feature backend security \
  --project "Auth System" \
  --assignee @me \
  --json
```

#### Updating Status

**Always update status at key milestones**:
- Starting work: → "In Progress"
- Ready for review: → "In Review"
- Completing work: → "Done"

```bash
# Starting work
linear issue update ENG-123 \
  --state "In Progress" \
  --assignee @me \
  --json

# Add comment explaining what you're doing
linear issue comment ENG-123 \
  "Starting implementation. Will tackle token generation first, then refresh flow." \
  --json
```

#### Adding Comments During Work

**Comment at these points**:
1. When starting work (plan)
2. When encountering blockers
3. When completing major milestones
4. When requesting review
5. When completing work

```bash
# Blocker encountered
linear issue comment ENG-123 \
  "Blocked: Discovered that current database schema doesn't support OAuth provider metadata.

**Issue**: Users table lacks \`oauth_provider\` and \`oauth_id\` columns

**Options**:
1. Create migration to add columns (preferred)
2. Create separate oauth_accounts table

Need input on preferred approach before proceeding." \
  --json

# Also update issue to reflect blocker
linear issue update ENG-123 \
  --state "Blocked" \
  --label blocked \
  --json
```

#### Searching for Context

**Before creating new issues**, search for existing work:

```bash
# Search by keyword
linear issue list --search "OAuth" --json

# Filter by labels
linear issue list --label feature backend --json

# Check related issues
linear issue relations ENG-123 --json
```

#### Creating Relationships

**Use relationships to show dependencies**:

```bash
# This work blocks other work
linear issue create \
  --title "Add OAuth database schema" \
  --blocks ENG-124 ENG-125 \
  --json

# This work is related
linear issue update ENG-123 \
  --related-to ENG-126 \
  --json

# This duplicates existing work
linear issue update ENG-127 \
  --duplicate-of ENG-123 \
  --json
```

### JSON Output and Error Handling

**Always use JSON output**:
```bash
# ✓ Correct
linear issue create --title "Task" --team ENG --json

# ✗ Avoid (human-readable only)
linear issue create --title "Task" --team ENG
```

**Check success in responses**:
```bash
RESULT=$(linear issue create --title "Task" --team ENG --json)
if echo "$RESULT" | jq -e '.success' > /dev/null; then
  ISSUE_ID=$(echo "$RESULT" | jq -r '.issue.identifier')
  echo "Created $ISSUE_ID"
else
  echo "Failed: $(echo "$RESULT" | jq -r '.error.message')"
fi
```

### Documents and Specifications

Create rich specification documents linked to projects:

```bash
# Create specification with cross-references
SPEC="# OAuth Implementation Specification

## Overview
Implement OAuth 2.0 authentication supporting multiple providers.

## Research
Based on: [OAuth Research](https://linear.app/workspace/document/research-abc)

## Dependencies
- Depends on: [ENG-100](https://linear.app/workspace/issue/ENG-100)
- Blocks: [ENG-125](https://linear.app/workspace/issue/ENG-125)

## Implementation Phases

### Phase 1: Database Schema
[Details...]

### Phase 2: Token Generation
[Details...]

## Testing Strategy
[Details...]"

linear document create \
  --title "OAuth 2.0 Implementation Spec" \
  --content "$SPEC" \
  --project "Auth System" \
  --json
```

**Cross-reference format**:
- Issues: `[ENG-123](https://linear.app/workspace/issue/ENG-123)`
- Documents: `[Title](https://linear.app/workspace/document/id)`
- Projects: `[Name](https://linear.app/workspace/project/slug)`
- Plain text like `ENG-123` won't create links ❌

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
