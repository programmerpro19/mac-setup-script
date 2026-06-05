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

# 7. Google Antigravity App
if has_app "Antigravity"; then
    log_warn "Google Antigravity App is already installed. Skipping..."
else
    log_info "Installing Google Antigravity App..."
    brew install --cask antigravity
    log_success "Google Antigravity App installed."
fi

# 8. OpenAI Codex App
if has_app "Codex"; then
    log_warn "OpenAI Codex App is already installed. Skipping..."
else
    log_info "Installing OpenAI Codex App..."
    brew install --cask codex-app
    log_success "OpenAI Codex App installed."
fi

# 9. Claude Code CLI
if has_command claude; then
    log_warn "Claude Code CLI is already installed. Skipping..."
else
    log_info "Installing Claude Code CLI..."
    brew install --cask claude-code
    log_success "Claude Code CLI installed."
fi

# 10. Google Antigravity CLI (agy)
if has_command agy; then
    log_warn "Google Antigravity CLI (agy) is already installed. Skipping..."
else
    log_info "Installing Google Antigravity CLI (agy)..."
    brew install --cask antigravity-cli
    log_success "Google Antigravity CLI (agy) installed."
fi

# 11. OpenAI Codex CLI
if has_command codex; then
    log_warn "OpenAI Codex CLI is already installed. Skipping..."
else
    log_info "Installing OpenAI Codex CLI..."
    brew install --cask codex
    log_success "OpenAI Codex CLI installed."
fi

# 12. OpenCode CLI
if has_command opencode; then
    log_warn "OpenCode CLI is already installed. Skipping..."
else
    log_info "Installing OpenCode CLI..."
    brew install opencode
    log_success "OpenCode CLI installed."
fi

