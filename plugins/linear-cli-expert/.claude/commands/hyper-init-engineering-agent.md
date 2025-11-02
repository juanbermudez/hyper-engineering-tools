# Initialize Engineering Agent for This Codebase

You are tasked with customizing the engineering-agent for this specific codebase and Linear workspace. Your goal is to understand the development practices, coding patterns, and implementation workflows to create a tailored version of the engineering agent.

## Your Task

### Phase 1: Codebase Analysis

Explore and document the following:

1. **Technology Stack**:
   - Primary language(s) and versions
   - Frameworks and libraries used
   - Build tools and package managers
   - Runtime environment

2. **Code Organization**:
   - Directory structure and conventions
   - Module/component organization
   - Common file naming patterns
   - Code organization principles (layered, modular, etc.)

3. **Coding Patterns and Conventions**:
   - Code style and formatting (check for .editorconfig, prettier, eslint, etc.)
   - Common design patterns used
   - Error handling approaches
   - Logging conventions
   - Comment/documentation style

4. **Testing Strategy**:
   - Test framework(s) used
   - Test file locations and naming
   - Test coverage expectations
   - How to run tests (commands, scripts)
   - Common testing patterns (unit, integration, e2e)

5. **Development Workflow**:
   - Build process (how to build)
   - Development server/environment
   - Linting and formatting tools
   - Pre-commit hooks or CI checks
   - Deployment process (if relevant)

6. **Dependencies and Configuration**:
   - How dependencies are managed
   - Configuration file patterns
   - Environment variables usage
   - External services/APIs integrated

### Phase 2: Implementation Pattern Analysis

Study existing code to identify:

1. **Common Implementation Patterns**:
   - Look at 3-5 recent feature implementations
   - How are features typically structured?
   - What patterns are repeated across the codebase?
   - How are new files/modules created?

2. **Best Practices Examples**:
   - Find well-implemented features to use as references
   - Identify exemplary code to emulate
   - Note any anti-patterns to avoid

3. **Integration Patterns**:
   - How do different parts of the codebase interact?
   - API/interface patterns
   - Data flow patterns
   - State management approaches

### Phase 3: Linear Integration Analysis

Using the Linear CLI, investigate:

1. **Task Information Quality**:
   ```bash
   linear issue list --json | head -n 20
   ```
   - How detailed are task descriptions?
   - What information is typically included?
   - Are there links to specs/docs?
   - How are technical details documented?

2. **Implementation Workflow**:
   - How do engineers use Linear during development?
   - Are there status updates during implementation?
   - How are blockers/questions documented?
   - How is work marked as complete?

3. **Branch/Commit Conventions**:
   - Are there git branch naming conventions?
   - Commit message patterns?
   - PR/review workflows?

### Phase 4: Create Temporary Findings

Create a temporary findings document at `.claude/temp/hyper-init/engineering-agent-findings.md` with:

```markdown
# Engineering Agent Customization Findings

## Technology Stack

### Languages & Frameworks
- [List primary languages and versions]
- [List frameworks and key libraries]

### Build & Development Tools
- Build command: [command]
- Dev server: [command]
- Test command: [command]
- Lint/format: [commands]

## Code Organization

### Directory Structure
```
[Show key directories and their purposes]
```

### Naming Conventions
- Files: [pattern]
- Components/Classes: [pattern]
- Functions/Methods: [pattern]
- Tests: [pattern]

### Architecture Patterns
- [Describe overall architecture]
- [Common patterns used]

## Coding Standards

### Style & Formatting
- Style guide: [if exists]
- Formatter: [tool and config]
- Linter: [tool and config]

### Code Patterns
- Error handling: [approach]
- Logging: [approach]
- Comments: [style]
- Type usage: [if applicable]

### Common Design Patterns
1. [Pattern 1 with example location]
2. [Pattern 2 with example location]

## Testing Practices

### Test Framework
- Framework: [name]
- Location: [where tests live]
- Naming: [test file pattern]
- Coverage: [expectations]

### Testing Patterns
- Unit tests: [approach and examples]
- Integration tests: [approach and examples]
- Test utilities: [common helpers]

### Running Tests
```bash
[Commands to run tests]
```

## Development Workflow

### Getting Started
1. [Setup steps]
2. [How to run locally]

### Making Changes
1. [Branch naming]
2. [Development process]
3. [Testing before commit]
4. [PR/review process]

### Pre-commit Checks
- [List any automated checks]

## Implementation Reference Examples

### Exemplary Implementations
1. [Path to well-done feature 1] - [Why it's good]
2. [Path to well-done feature 2] - [Why it's good]

### Common Patterns
- [Pattern name]: See [file path] for example
- [Pattern name]: See [file path] for example

### Anti-patterns to Avoid
- [What not to do and why]

## Linear Integration

### Task Detail Expectations
- [What info engineers expect in tasks]
- [How specs are linked]

### Status Updates
- [When/how to update task status]
- [How to document blockers]

### Git Integration
- Branch naming: [pattern if exists]
- Commit messages: [pattern if exists]

## Engineering Workflow Recommendations

### Implementation Checklist for This Codebase
1. [Step-by-step process for implementing a task]
2. [What to check before starting]
3. [What to verify before completing]

### Code Quality Standards
- [Specific standards for this project]
- [What to check during implementation]

### Example Implementation Flow
[Detailed example of implementing a feature in THIS codebase]
```

### Phase 5: Customize Engineering Agent

Read the current engineering agent at `agents/engineering-agent.md` and create an enhanced version at `.claude/agents/engineering-agent.md` (project-level override) that includes:

1. **Technology Stack Section**:
   - Add specific languages, frameworks, and tools
   - Include build and test commands
   - Document development setup

2. **Code Organization Guide**:
   - Map out the directory structure
   - Explain where different types of code live
   - Show naming conventions with examples

3. **Coding Standards**:
   - Include the project's style guide
   - Document formatting and linting tools
   - Show common patterns with file references

4. **Testing Integration**:
   - Specify test framework and patterns
   - Include commands to run tests
   - Show examples of good tests from the codebase

5. **Implementation Checklist**:
   - Create a step-by-step checklist specific to this project
   - Include pre-implementation checks
   - Include completion criteria

6. **Reference Examples**:
   - Link to exemplary implementations in the codebase
   - Provide anti-patterns to avoid
   - Include common utilities and helpers

7. **Linear Task Integration**:
   - Show how to extract requirements from Linear tasks
   - Include status update patterns
   - Document branch/commit conventions if they exist

## Output

At the end, provide:

1. **Summary of findings** (brief overview)
2. **Path to customized agent**: `.claude/agents/engineering-agent.md`
3. **Recommendations**: Any additional setup or configuration needed
4. **Quick reference**: Key commands and patterns for this codebase

## Important Notes

- Create all temporary files in `.claude/temp/hyper-init/` (create directory if needed)
- The customized agent goes in `.claude/agents/engineering-agent.md` (project-level)
- This overrides the plugin's default engineering-agent for this project
- Preserve all original agent capabilities while adding project-specific context
- Use actual file paths and examples from this codebase
- Test build/test commands to ensure they work
- Reference real implementations as examples

Begin the initialization process now.
