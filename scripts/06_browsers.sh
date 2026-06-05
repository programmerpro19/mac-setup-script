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

log_info "Installing Web Browsers..."

# 1. Google Chrome & Chromedriver
if has_app "Google Chrome"; then
    log_warn "Google Chrome is already installed. Skipping..."
else
    log_info "Installing Google Chrome..."
    brew install --cask google-chrome
    log_success "Google Chrome installed."
fi

if has_command chromedriver; then
    log_warn "chromedriver is already installed. Skipping..."
else
    log_info "Installing chromedriver..."
    brew install --cask chromedriver
    log_success "chromedriver installed."
fi

# 2. Brave Browser
if has_app "Brave Browser"; then
    log_warn "Brave Browser is already installed. Skipping..."
else
    log_info "Installing Brave Browser..."
    brew install --cask brave-browser
    log_success "Brave Browser installed."
fi

# 3. Firefox
if has_app "Firefox"; then
    log_warn "Firefox is already installed. Skipping..."
else
    log_info "Installing Firefox..."
    brew install --cask firefox
    log_success "Firefox installed."
fi

# 4. Microsoft Edge
if has_app "Microsoft Edge"; then
    log_warn "Microsoft Edge is already installed. Skipping..."
else
    log_info "Installing Microsoft Edge..."
    brew install --cask microsoft-edge
    log_success "Microsoft Edge installed."
fi
