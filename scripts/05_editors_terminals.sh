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

log_info "Installing GUI Editors & Terminal emulators..."

# 1. Visual Studio Code
if has_app "Visual Studio Code" || has_command code; then
    log_warn "VS Code is already installed. Skipping..."
else
    log_info "Installing Visual Studio Code..."
    brew install --cask visual-studio-code
    
    # Configure CLI 'code' launcher in PATH by symlinking to /opt/homebrew/bin
    if [ -d "/Applications/Visual Studio Code.app" ]; then
        log_info "Creating symlink for VS Code CLI 'code' utility..."
        mkdir -p "$(brew --prefix)/bin"
        ln -sf "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$(brew --prefix)/bin/code"
        log_success "VS Code CLI launcher configured."
    fi
fi

# 2. Zed Editor
if has_app "Zed" || has_command zed; then
    log_warn "Zed editor is already installed. Skipping..."
else
    log_info "Installing Zed..."
    brew install --cask zed
    log_success "Zed editor installed."
fi

# 3. iTerm2 Terminal Emulator
if has_app "iTerm" || has_app "iTerm2"; then
    log_warn "iTerm2 is already installed. Skipping..."
else
    log_info "Installing iTerm2..."
    brew install --cask iterm2
    log_success "iTerm2 installed."
fi

# 4. Ghostty Terminal Emulator
if has_app "Ghostty" || has_command ghostty; then
    log_warn "Ghostty terminal is already installed. Skipping..."
else
    log_info "Installing Ghostty..."
    brew install --cask ghostty
    log_success "Ghostty terminal installed."
fi

# 5. JetBrains Toolbox
if has_app "JetBrains Toolbox"; then
    log_warn "JetBrains Toolbox is already installed. Skipping..."
else
    log_info "Installing JetBrains Toolbox..."
    brew install --cask jetbrains-toolbox
    log_success "JetBrains Toolbox installed."
fi
