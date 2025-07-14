#!/usr/bin/env bash

# Common utility functions for scripts

# Print error to stderr in red
error() {
    echo -e "\033[31mError: $*\033[0m" >&2
}

# Print error and exit
fatal() {
    error "$*"
    exit 1
}

# Set source and root directories, cd to root
set_source_and_root_dir() {
    { set +x; } 2>/dev/null
    source_dir="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
    root_dir=$(cd "$source_dir" && cd ../ && pwd)
    cd "$root_dir"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Print colored text
print_color() {
    case $1 in
        red)    echo -e "\033[31m$2\033[0m";;
        green)  echo -e "\033[32m$2\033[0m";;
        yellow) echo -e "\033[33m$2\033[0m";;
        blue)   echo -e "\033[34m$2\033[0m";;
        *)      echo "$2";;
    esac
}

# Print warning in yellow
warning() {
    echo -e "\033[33mWarning: $*\033[0m" >&2
}

# Print success in green
success() {
    echo -e "\033[32m✓ $*\033[0m"
}

# Run command with description
run_command() {
    echo "→ ${2:-Running command}"
    [ "$VERBOSE" ] && echo "  $1"
    $1 || fatal "Command failed: $1"
}

# Check required commands exist
require_commands() {
    local missing=()
    for cmd in "$@"; do
        command_exists "$cmd" || missing+=("$cmd")
    done
    [ ${#missing[@]} -eq 0 ] || fatal "Missing commands: ${missing[*]}"
}

# Show help from script comments
show_help() {
    sed -n 's/^#\/ \?//p' "$0"
}