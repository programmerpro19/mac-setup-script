#!/bin/bash
source "$(dirname "$0")/../lib/utils.sh"

# Ensure Homebrew is installed
if ! has_command brew; then
    if [ "${PARENT_RUN}" != "true" ]; then
        require_script "00_homebrew.sh"
    else
        log_error "Homebrew is required but not installed."
        exit 1
    fi
fi

# Define CLI tools to install
declare -a CLI_TOOLS=("ripgrep" "jq" "fzf")

log_info "Installing developer CLI utilities..."

for tool in "${CLI_TOOLS[@]}"; do
    if has_command "$tool"; then
        log_warn "$tool is already installed. Skipping..."
    else
        log_info "Installing $tool..."
        brew install "$tool"
        log_success "$tool installed successfully."
    fi
done

# Configure fzf shell integration (idempotent)
if [ -d "$(brew --prefix)/opt/fzf" ]; then
    log_info "Configuring fzf command line completions and key bindings..."
    
    # Run fzf installer script silently (no interaction, no auto-modifying ~/.zshrc directly)
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    
    # Add source directives to .zshrc idempotently
    append_to_file "~/.zshrc" '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'
    append_to_file "~/.bash_profile" '[ -f ~/.fzf.bash ] && source ~/.fzf.bash'
    
    log_success "fzf shell integration configured."
fi
