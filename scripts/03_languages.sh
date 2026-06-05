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

# 1. Node.js Setup via fnm
log_info "Setting up Node.js runtime environment..."
if has_command fnm; then
    log_warn "fnm (Fast Node Manager) is already installed."
else
    log_info "Installing fnm..."
    brew install fnm
    
    # Configure shell environment for fnm
    append_to_file "~/.zshrc" 'eval "$(fnm env --use-on-cd)"'
    append_to_file "~/.bash_profile" 'eval "$(fnm env --use-on-cd)"'
    eval "$(fnm env --use-on-cd)"
fi

# Install latest Node LTS using fnm if not already present
if has_command node; then
    log_warn "Node runtime already available: $(node -v). Skipping LTS installation."
else
    log_info "Installing latest Node.js LTS via fnm..."
    eval "$(fnm env --use-on-cd)" # Make sure fnm is active in subshell
    fnm install --lts
    fnm default lts
    log_success "Node.js LTS installed and set as default."
fi


# 2. Python 3 Setup
log_info "Setting up Python 3..."
if has_command python3; then
    log_warn "Python 3 is already installed: $(python3 --version)"
else
    log_info "Installing Python 3 via Homebrew..."
    brew install python
    log_success "Python 3 installed successfully."
fi


# 3. Rust Setup via rustup
log_info "Setting up Rust compiler and toolchain..."
if has_command rustc && has_command rustup; then
    log_warn "Rust toolchain is already installed: $(rustc --version)"
else
    log_info "Installing Rust via official rustup installer..."
    # Run rustup installer non-interactively
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    
    # Configure PATH for Cargo
    append_to_file "~/.zshrc" 'source "$HOME/.cargo/env"'
    append_to_file "~/.bash_profile" 'source "$HOME/.cargo/env"'
    source "$HOME/.cargo/env"
    log_success "Rust installed successfully."
fi


# 4. Java Setup (OpenJDK)
log_info "Setting up Java Development Kit (OpenJDK)..."
if has_command java; then
    log_warn "Java runtime is already installed: $(java -version 2>&1 | head -n 1)"
else
    log_info "Installing OpenJDK via Homebrew..."
    brew install openjdk
    
    # Configure JAVA_HOME in shell profiles
    append_to_file "~/.zshrc" 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"'
    append_to_file "~/.bash_profile" 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"'
    
    # Print system linking instructions
    log_info "Note: To make system wrappers find OpenJDK, you may need to run:"
    log_info "  sudo ln -sfn \$(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk"
    
    log_success "OpenJDK installed and configured."
fi
