#!/bin/bash

# Colors for logging
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Helper to check if a command exists in the current environment
has_command() {
    command -v "$1" &> /dev/null
}

# Helper to check if an application bundle (.app) exists
has_app() {
    local app_name="$1"
    [ -d "/Applications/${app_name}.app" ] || [ -d "$HOME/Applications/${app_name}.app" ]
}

# Helper to check and run prerequisite scripts
require_script() {
    local script_name="$1"
    local script_path="$(dirname "$0")/../scripts/${script_name}"
    
    # Resolve relative path if sourcing from a different location
    if [ ! -f "$script_path" ]; then
        script_path="$(dirname "${BASH_SOURCE[0]}")/../scripts/${script_name}"
    fi
    
    if [ -f "$script_path" ]; then
        log_info "Running prerequisite: ${script_name}..."
        # Export PARENT_RUN=true so nested scripts don't run their own setup.sh checks
        PARENT_RUN=true bash "$script_path"
    else
        log_error "Prerequisite script not found: ${script_name} (resolved path: ${script_path})"
        exit 1
    fi
}

# Helper to idempotently append a line to a file (like .zshrc)
append_to_file() {
    local file="$1"
    local line="$2"
    
    # Resolve home directory symbol if present
    file="${file/#\~/$HOME}"
    
    mkdir -p "$(dirname "$file")"
    touch "$file"
    
    if ! grep -Fxq "$line" "$file"; then
        echo "$line" >> "$file"
        log_success "Added line to ${file}: '${line}'"
    else
        log_info "Line already exists in ${file}, skipping: '${line}'"
    fi
}
