# PostHog Project Template

A standardized project template for consistent development workflows across all of PostHog's repositories. This template provides a solid foundation with common scripts, configuration files, license, and project structure that can be customized for your specific needs.

## Using This Template

### Creating a New Project

1. **Clone from Template**: Use GitHub's "Use this template" button or clone directly:

```bash
git clone https://github.com/PostHog/template.git your-project-name
cd your-project-name
```

2. **Initialize as New Repository**: Remove the template's git history and start fresh:

```bash
rm -rf .git
git init
git add .
git commit -m "Initial commit from template"
```

3. **Replace README**: Replace this template README with the project-specific one from [README.demo.md](README.demo.md):

```bash
mv README.demo.md README.md
```

4. **Customize for Your Project**:
   - Customize your README including language-specific requirements
   - Update configuration files
   - Add your source code and dependencies
   - Update documentation

### What's Included

This template provides:

- **Standardized Scripts**: Common development tasks in `bin/` directory
- **Project Structure**: Consistent organization across projects
- **Configuration Files**: Common `.gitignore`, `.gitattributes`, etc.
- **Documentation**: Templates and guides for customization
- **Github Configuration**: Basic issues/PR templates inside the [.github](./.github) folder

## Scripts to Rule Them All

The `bin/` directory contains standardized scripts following the "Scripts to Rule Them All" pattern, providing a consistent interface for common development tasks across different projects and languages.

### Script Structure

```
bin/
├── helpers/
│   └── _utils.sh     # Common utility functions
├── setup             # Initial project setup
├── bootstrap         # Resolve dependencies
├── start             # Start the application
├── test              # Run tests
├── fmt               # Format code
├── lint              # Run linters
├── build             # Build the project
├── clean             # Clean build artifacts
└── update            # Update dependencies
```

### Usage

1. Customize scripts for your specific language/framework
2. Run scripts from project root: `bin/test`

### Script Guidelines

- All scripts should be idempotent
- Include help text with `#/` comments
- Source `bin/helpers/_utils.sh` for common functions
- Set working directory to project root
- Exit with appropriate status codes

### Best Practices

1. **Keep scripts simple**: Each script should do one thing well
2. **Use helpers**: Don't repeat code, add it to [`_utils.sh`](./bin/helpers/_utils.sh)
3. **Provide feedback**: Use print_color to show progress
4. **Handle errors**: Check return codes and fail gracefully
5. **Document options**: Use `#/` comments for help text
6. **Be idempotent**: Scripts should be safe to run multiple times
