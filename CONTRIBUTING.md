# Contributing to Hyper-Engineering Tools

Thank you for your interest in contributing! This guide will help you get started.

## Repository Structure

```
hyper-engineering/
├── marketplace/              # Claude Code plugin marketplace
│   ├── .claude-plugin/
│   │   └── marketplace.json
│   ├── plugins/
│   │   └── linear-cli-expert/
│   └── README.md
└── linear-agent-cli/         # Linear CLI source
    ├── src/
    ├── docs/
    └── README.md
```

## Ways to Contribute

### 1. Add New Plugins to the Marketplace

Create a new plugin for the marketplace:

1. **Create plugin directory**:
   ```bash
   mkdir -p marketplace/plugins/your-plugin-name
   cd marketplace/plugins/your-plugin-name
   ```

2. **Create plugin structure**:
   ```
   your-plugin-name/
   ├── .claude-plugin/
   │   └── plugin.json
   ├── skills/
   │   └── your-skill/
   │       └── SKILL.md
   └── README.md
   ```

3. **Add to marketplace.json**:
   ```json
   {
     "name": "your-plugin-name",
     "source": "./plugins/your-plugin-name",
     "description": "Brief description of your plugin",
     "version": "1.0.0",
     "author": {
       "name": "Your Name",
       "email": "your@email.com"
     },
     "keywords": ["relevant", "keywords"],
     "category": "productivity"
   }
   ```

4. **Test locally**:
   ```bash
   # In Claude Code
   /plugin marketplace add /path/to/hyper-engineering/marketplace
   /plugin install your-plugin-name@hyper-engineering-tools
   ```

5. **Submit PR** with your new plugin

See [Claude Code Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins) for plugin development details.

### 2. Improve the Linear CLI

Contribute to the Linear CLI tool:

1. **Fork and clone**:
   ```bash
   git clone https://github.com/juanbermudez/hyper-engineering-tools
   cd hyper-engineering/linear-agent-cli
   ```

2. **Install dependencies**:
   ```bash
   # Ensure Deno is installed
   deno --version
   ```

3. **Make your changes** in `linear-agent-cli/src/`

4. **Test your changes**:
   ```bash
   # Run tests
   deno test

   # Test locally
   deno run --allow-all src/main.ts issue list --json
   ```

5. **Submit PR** with description of your changes

### 3. Share Agent Configurations

Share your customized agent configurations:

1. **Document your customization** in an issue or discussion
2. **Explain the use case** and how it improves the workflow
3. **Provide the modified agent file** (research-agent.md, planning-agent.md, or engineering-agent.md)
4. **Include examples** of how the customization works

We may incorporate popular customizations into the default agents or create variants.

### 4. Improve Documentation

Documentation improvements are always welcome:

- Fix typos or clarify confusing sections
- Add examples or use cases
- Improve installation instructions
- Add troubleshooting tips
- Translate documentation

### 5. Report Bugs or Request Features

- **Bugs**: [Open an issue](https://github.com/juanbermudez/hyper-engineering-tools/issues/new) with:
  - Clear description of the problem
  - Steps to reproduce
  - Expected vs actual behavior
  - Environment details (OS, Claude Code version, etc.)

- **Features**: [Open a discussion](https://github.com/juanbermudez/hyper-engineering-tools/discussions/new) to propose and discuss new features

## Development Guidelines

### Code Style

#### For Linear CLI (TypeScript/Deno)

- Follow existing code style in the repository
- Use TypeScript types consistently
- Add tests for new functionality
- Run formatter before committing:
  ```bash
  deno fmt
  ```

#### For Plugins (Markdown)

- Use clear, concise language
- Follow existing SKILL.md format
- Include examples for complex features
- Use proper markdown formatting

### Commit Messages

Write clear commit messages:

```
feat: add OAuth provider support to Linear CLI
fix: correct task sequencing in planning agent
docs: improve installation instructions for Windows
```

Prefixes:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Test additions or changes
- `chore:` - Maintenance tasks

### Pull Request Process

1. **Fork the repository**

2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**:
   - Follow code style guidelines
   - Add tests if applicable
   - Update documentation

4. **Test your changes**:
   - Run existing tests
   - Test manually
   - Verify plugin installs correctly

5. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: your clear description"
   ```

6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**:
   - Use the PR template
   - Describe your changes
   - Reference related issues
   - Add screenshots/examples if applicable

8. **Address review feedback**:
   - Respond to comments
   - Make requested changes
   - Push updates to your branch

### Testing

#### Linear CLI

```bash
# Run all tests
deno test

# Run specific test file
deno test test/commands/issue/issue-create.test.ts

# Run with coverage
deno test --coverage
```

#### Plugins

Test plugins locally before submitting:

```bash
# Add local marketplace
/plugin marketplace add /path/to/hyper-engineering/marketplace

# Install plugin
/plugin install your-plugin@hyper-engineering-tools

# Test functionality
# [Use your plugin's features]

# Uninstall and reinstall to test updates
/plugin uninstall your-plugin@hyper-engineering-tools
/plugin install your-plugin@hyper-engineering-tools
```

## Questions?

- **General questions**: [Start a discussion](https://github.com/juanbermudez/hyper-engineering-tools/discussions)
- **Bug reports**: [Open an issue](https://github.com/juanbermudez/hyper-engineering-tools/issues)
- **Quick questions**: Comment on related issues or PRs

## Code of Conduct

Be respectful and constructive:
- Welcome newcomers and help them get started
- Provide constructive feedback on PRs
- Be patient with questions
- Focus on the technical merit of contributions
- Assume good intentions

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to making software development with AI agents better!
