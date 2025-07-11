#!/usr/bin/env bash

# Common utility functions for scripts

# Print error message to stderr
error() {
    echo "$@" >&2
}

# Print error message and exit with status 1
fatal() {
    error "$@"
    exit 1
}

# Set source and root directories, cd to root
set_source_and_root_dir() {
    { set +x; } 2>/dev/null
    source_dir="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
    root_dir=$(cd "$source_dir" && cd ../ && pwd)
    cd $root_dir
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS type
detect_os() {
    case "$(uname -s)" in
        Darwin*)    echo "macos";;
        Linux*)     echo "linux";;
        CYGWIN*|MINGW*|MSYS*) echo "windows";;
        *)          echo "unknown";;
    esac
}

# Print colored output
print_color() {
    local color=$1
    shift
    case $color in
        red)    echo -e "\033[0;31m$@\033[0m";;
        green)  echo -e "\033[0;32m$@\033[0m";;
        yellow) echo -e "\033[0;33m$@\033[0m";;
        blue)   echo -e "\033[0;34m$@\033[0m";;
        *)      echo "$@";;
    esac
}

# Run command with optional verbose output
run_command() {
    local cmd="$1"
    local description="$2"
    
    if [ -n "$description" ]; then
        echo "→ $description"
    fi
    
    if [ -n "$VERBOSE" ]; then
        echo "  Running: $cmd"
    fi
    
    eval "$cmd"
    local status=$?
    
    if [ $status -ne 0 ]; then
        error "Command failed: $cmd"
        return $status
    fi
    
    return 0
}

# Check for required commands
require_commands() {
    local missing=()
    
    for cmd in "$@"; do
        if ! command_exists "$cmd"; then
            missing+=("$cmd")
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        fatal "Required commands not found: ${missing[*]}"
    fi
}

# Show help text from script header
show_help() {
    grep '^#/' "$0" | cut -c4-
}

# Parse common arguments
parse_common_args() {
    while (( "$#" )); do
        case "$1" in
            -v|--verbose)
                export VERBOSE=1
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                break
                ;;
        esac
    done
}