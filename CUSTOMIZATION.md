# Customization Guide

This guide explains how to customize the scripts for your specific project.

## Language-Specific Customization

### Node.js/JavaScript Projects

1. **package.json scripts**: The scripts automatically detect and use npm scripts if they exist
2. **Alternative package managers**: Scripts support npm, yarn, and pnpm
3. **TypeScript**: TypeScript compilation is handled automatically if tsconfig.json exists

### Python Projects

1. **Virtual environments**: Add venv activation to scripts:
   ```bash
   # In bin/helpers/_utils.sh
   activate_venv() {
       if [ -f "venv/bin/activate" ]; then
           source venv/bin/activate
       elif [ -f ".venv/bin/activate" ]; then
           source .venv/bin/activate
       fi
   }
   ```

2. **Django vs Flask**: Scripts auto-detect based on files (manage.py for Django)

### Ruby Projects

1. **Ruby version management**: Add to setup script:
   ```bash
   # Check Ruby version
   if [ -f ".ruby-version" ]; then
       required_version=$(cat .ruby-version)
       current_version=$(ruby -v | awk '{print $2}')
       # Add version check logic
   fi
   ```

### .NET Projects

1. **Multiple projects**: Modify scripts to handle solution files:
   ```bash
   # Find and use solution file
   solution=$(find . -name "*.sln" | head -1)
   ```

## Adding New Scripts

Create new scripts following this template:

```bash
#!/usr/bin/env bash
#/ Usage: bin/your-script [options]
#/ Description: What your script does
#/ Options:
#/   -o, --option    Description of option

source bin/helpers/_utils.sh
set_source_and_root_dir
parse_common_args "$@"

# Your script logic here
print_color blue "Running your task..."

# Use run_command for visibility
run_command "your command" "Description of what's happening"

print_color green "✓ Task complete"
```

## Environment Variables

Common environment variables to set:

- `VERBOSE=1` - Enable verbose output
- `CI=true` - Running in CI environment
- `NODE_ENV` - Node.js environment
- `RAILS_ENV` - Rails environment
- `FLASK_ENV` - Flask environment

## CI/CD Integration

### GitHub Actions

```yaml
- name: Setup
  run: bin/setup

- name: Lint
  run: bin/lint

- name: Test
  run: bin/test --coverage

- name: Build
  run: bin/build
```

### GitLab CI

```yaml
before_script:
  - bin/setup
  - bin/bootstrap

test:
  script:
    - bin/lint
    - bin/test
```

## Docker Integration

Add Docker-specific scripts:

```bash
# bin/docker-build
#!/usr/bin/env bash
source bin/helpers/_utils.sh
docker build -t myapp .

# bin/docker-run
#!/usr/bin/env bash
source bin/helpers/_utils.sh
docker run -p 3000:3000 myapp
```

## Project-Specific Helpers

Add custom functions to `bin/helpers/_utils.sh`:

```bash
# Database helpers
db_migrate() {
    run_command "rails db:migrate" "Running database migrations"
}

db_seed() {
    run_command "rails db:seed" "Seeding database"
}

# Asset compilation
compile_assets() {
    run_command "npm run build:css" "Building CSS"
    run_command "npm run build:js" "Building JavaScript"
}
```

## Best Practices

1. **Keep scripts simple**: Each script should do one thing well
2. **Use helpers**: Don't repeat code, add it to _utils.sh
3. **Provide feedback**: Use print_color to show progress
4. **Handle errors**: Check return codes and fail gracefully
5. **Document options**: Use #/ comments for help text
6. **Be idempotent**: Scripts should be safe to run multiple times