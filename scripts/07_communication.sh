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

log_info "Installing Communication Tools..."

# 1. Slack
if has_app "Slack"; then
    log_warn "Slack is already installed. Skipping..."
else
    log_info "Installing Slack..."
    brew install --cask slack
    log_success "Slack installed."
fi

# 2. Microsoft Teams
if has_app "Microsoft Teams" || has_app "Microsoft Teams (work or school)"; then
    log_warn "Microsoft Teams is already installed. Skipping..."
else
    log_info "Installing Microsoft Teams..."
    brew install --cask microsoft-teams
    log_success "Microsoft Teams installed."
fi

# 3. WhatsApp
if has_app "WhatsApp"; then
    log_warn "WhatsApp is already installed. Skipping..."
else
    log_info "Installing WhatsApp..."
    brew install --cask whatsapp
    log_success "WhatsApp installed."
fi

# 4. Signal
if has_app "Signal"; then
    log_warn "Signal is already installed. Skipping..."
else
    log_info "Installing Signal..."
    brew install --cask signal
    log_success "Signal installed."
fi
