# Scripts to Rule Them All

A collection of standardized scripts for consistent project automation across repositories. See the [PostHog Handbook article](https://posthog.com/handbook/engineering/conventions/scripts) for rationale and more details.

## Philosophy

These scripts follow the "Scripts to Rule Them All" pattern, providing a consistent interface for common development tasks across different projects and languages.

## Structure

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

## Usage

1. Copy the `bin/` directory to your project root
2. Make scripts executable: `chmod +x bin/*`
3. Customize scripts for your specific language/framework
4. Run scripts from project root: `bin/test`

## Script Guidelines

- All scripts should be idempotent
- Include help text with `#/` comments
- Source `bin/helpers/_utils.sh` for common functions
- Set working directory to project root
- Exit with appropriate status codes

## Example Implementation

See the individual script templates for language-specific examples.