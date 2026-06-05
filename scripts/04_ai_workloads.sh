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

log_info "Installing AI & ML tools..."

# 1. Ollama (Local LLM Server)
if has_app "Ollama" || has_command ollama; then
    log_warn "Ollama is already installed. Skipping..."
else
    log_info "Installing Ollama..."
    brew install --cask ollama
    log_success "Ollama installed."
fi

# 2. Docker Desktop (Containers & virtualization)
if has_app "Docker" || has_command docker; then
    log_warn "Docker is already installed. Skipping..."
else
    log_info "Installing Docker Desktop..."
    brew install --cask docker
    log_success "Docker Desktop installed."
fi

# 3. LM Studio (Local LLM GUI interface)
if has_app "LM Studio"; then
    log_warn "LM Studio is already installed. Skipping..."
else
    log_info "Installing LM Studio..."
    brew install --cask lm-studio
    log_success "LM Studio installed."
fi

# 4. AnythingLLM (Desktop LLM app)
if has_app "AnythingLLM"; then
    log_warn "AnythingLLM is already installed. Skipping..."
else
    log_info "Installing AnythingLLM..."
    brew install --cask anythingllm
    log_success "AnythingLLM installed."
fi

# 5. Claude Desktop App
if has_app "Claude"; then
    log_warn "Claude Desktop is already installed. Skipping..."
else
    log_info "Installing Claude Desktop..."
    brew install --cask claude
    log_success "Claude Desktop installed."
fi

# 6. Google Gemini App
if has_app "Google Gemini" || has_app "Gemini"; then
    log_warn "Google Gemini is already installed. Skipping..."
else
    log_info "Installing Google Gemini Desktop..."
    brew install --cask google-gemini
    log_success "Google Gemini Desktop installed."
fi
