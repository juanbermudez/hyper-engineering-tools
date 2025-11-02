# Initialize Research Agent for This Codebase

You are tasked with customizing the research-agent for this specific codebase and Linear workspace. Your goal is to analyze the project structure, documentation patterns, and research workflows to create a tailored version of the research agent.

## Your Task

### Phase 1: Codebase Analysis

Explore and document the following:

1. **Documentation Structure**:
   - Where does documentation live? (docs/, README.md, wikis, etc.)
   - What documentation formats are used? (Markdown, JSDoc, etc.)
   - Are there architecture decision records (ADRs)?
   - What external documentation exists? (API docs, design docs)

2. **Code Organization**:
   - What is the overall project structure?
   - What are the main modules/components?
   - What technologies/frameworks are used?
   - What external dependencies/APIs exist?

3. **Research Patterns**:
   - How are specs/requirements typically documented?
   - Where are design decisions recorded?
   - Are there existing research documents or RFCs?

### Phase 2: Linear Workspace Analysis

Using the Linear CLI, investigate:

1. **Documentation in Linear**:
   ```bash
   linear document list --json
   linear project list --json
   ```
   - How are research findings typically documented?
   - What document structure is common?
   - How are documents linked to projects/issues?

2. **Project Structure**:
   - What types of projects exist?
   - How are projects organized?
   - What metadata is commonly used?

### Phase 3: Create Temporary Findings

Create a temporary findings document at `.claude/temp/hyper-init/research-agent-findings.md` with:

```markdown
# Research Agent Customization Findings

## Codebase Characteristics

### Documentation Locations
- [List where docs are found]

### Key Technologies
- [List main frameworks, languages, tools]

### External Dependencies
- [List important APIs, services, libraries]

### Code Structure
- [Summarize project organization]

## Linear Workspace Patterns

### Document Patterns
- [How research is documented in Linear]

### Project Organization
- [How projects are structured]

### Common Metadata
- [Labels, milestones, etc. used for research]

## Research Workflow Recommendations

### Best Practices for This Codebase
1. [Specific guidance based on findings]
2. [Patterns to follow]
3. [Resources to check]

### Linear Integration
- [How to document research in Linear for this team]
- [Linking strategy]
- [Collaboration patterns]

### Example Research Flow
[Step-by-step example of researching a feature in THIS codebase]
```

### Phase 4: Customize Research Agent

Read the current research agent at `agents/research-agent.md` and create an enhanced version at `.claude/agents/research-agent.md` (project-level override) that includes:

1. **Codebase-Specific Guidance**:
   - Add a "## Codebase Context" section with project-specific information
   - Include specific paths where documentation lives
   - List key technologies and their documentation sources

2. **Linear Workspace Guidance**:
   - Add examples of how this team uses Linear documents
   - Include actual label names and project structures
   - Show real examples from the workspace

3. **Customized Research Process**:
   - Adapt the research steps to this project's structure
   - Include specific commands and paths for this codebase
   - Reference actual documentation locations

4. **Example Research Scenarios**:
   - Provide 2-3 examples specific to this codebase
   - Show how to research a new feature in THIS project
   - Demonstrate Linear integration patterns

## Output

At the end, provide:

1. **Summary of findings** (brief overview)
2. **Path to customized agent**: `.claude/agents/research-agent.md`
3. **Recommendations**: Any additional setup or configuration needed

## Important Notes

- Create all temporary files in `.claude/temp/hyper-init/` (create directory if needed)
- The customized agent goes in `.claude/agents/research-agent.md` (project-level)
- This overrides the plugin's default research-agent for this project
- Preserve all original agent capabilities while adding project-specific context
- Use actual examples from the codebase and Linear workspace
- Test Linear CLI commands with `--json` flag to ensure they work

Begin the initialization process now.
