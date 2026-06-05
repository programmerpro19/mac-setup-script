#!/bin/bash
source "$(dirname "$0")/../lib/utils.sh"

# Check if brew exists in path
if has_command brew; then
    log_warn "Homebrew is already installed: $(brew --version | head -n 1)"
else
    log_info "Homebrew not found. Starting installation..."
    
    # Run official Homebrew installer
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Configure path based on CPU architecture (Apple Silicon vs Intel)
    if [ "$(uname -m)" = "arm64" ]; then
        log_info "Apple Silicon detected. Configuring Homebrew shell environment..."
        
        # Add to .zprofile and .zshrc
        append_to_file "~/.zprofile" 'eval "$(/opt/homebrew/bin/brew shellenv)"'
        append_to_file "~/.zshrc" 'eval "$(/opt/homebrew/bin/brew shellenv)"'
        
        # Load in current shell session
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        log_info "Intel Mac detected. Configuring Homebrew shell environment..."
        
        append_to_file "~/.zprofile" 'eval "$(/usr/local/bin/brew shellenv)"'
        append_to_file "~/.zshrc" 'eval "$(/usr/local/bin/brew shellenv)"'
        
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    # Verify installation
    if has_command brew; then
        log_success "Homebrew installed and configured successfully!"
    else
        log_error "Homebrew installation failed. Please check the logs."
        exit 1
    fi
fi
