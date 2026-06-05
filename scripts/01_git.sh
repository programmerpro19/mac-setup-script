#!/bin/bash
source "$(dirname "$0")/../lib/utils.sh"

# Ensure Git is installed
if ! has_command git; then
    log_warn "Git is not installed. Installing via Homebrew..."
    
    # Pre-requisite check for Homebrew
    if [ "${PARENT_RUN}" != "true" ] && ! has_command brew; then
        require_script "00_homebrew.sh"
    fi
    
    brew install git
fi

log_info "Configuring global Git options..."

# Fetch current config (if any)
current_name=$(git config --global user.name || true)
current_email=$(git config --global user.email || true)

# Prompt for user name
echo -n -e "Enter Git global user name [Current: '${current_name:-Not Set}']: "
read git_name
git_name=${git_name:-$current_name}

# Prompt for user email
echo -n -e "Enter Git global user email [Current: '${current_email:-Not Set}']: "
read git_email
git_email=${git_email:-$current_email}

# Set Git configs (only if values are available)
if [ -n "$git_name" ]; then
    git config --global user.name "$git_name"
    log_success "Git user.name set to: $git_name"
else
    log_warn "Git user.name not configured (empty)."
fi

if [ -n "$git_email" ]; then
    git config --global user.email "$git_email"
    log_success "Git user.email set to: $git_email"
else
    log_warn "Git user.email not configured (empty)."
fi

# Set sensible default configurations
git config --global init.defaultBranch main
log_success "Git default branch set to: main"

# On macOS, use osxkeychain for credentials caching
git config --global credential.helper osxkeychain
log_success "Git credential helper set to: osxkeychain"

# Enable coloring in terminal output
git config --global color.ui auto
log_success "Git color UI enabled."
