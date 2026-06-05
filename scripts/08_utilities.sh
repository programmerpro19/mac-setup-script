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

log_info "Installing System Utilities & Extras..."

# 1. Rectangle (Window Manager)
if has_app "Rectangle"; then
    log_warn "Rectangle is already installed. Skipping..."
else
    log_info "Installing Rectangle..."
    brew install --cask rectangle
    log_success "Rectangle installed."
fi

# 2. Macs Fan Control
if has_app "Macs Fan Control"; then
    log_warn "Macs Fan Control is already installed. Skipping..."
else
    log_info "Installing Macs Fan Control..."
    brew install --cask macs-fan-control
    log_success "Macs Fan Control installed."
fi

# 3. Wireshark (Network analyzer)
if has_app "Wireshark"; then
    log_warn "Wireshark is already installed. Skipping..."
else
    log_info "Installing Wireshark..."
    brew install --cask wireshark
    log_success "Wireshark installed."
fi

# 4. Tailscale (Mesh VPN)
if has_app "Tailscale"; then
    log_warn "Tailscale is already installed. Skipping..."
else
    log_info "Installing Tailscale..."
    brew install --cask tailscale
    log_success "Tailscale installed."
fi

# 5. Obsidian (Knowledge base & Markdown editor)
if has_app "Obsidian"; then
    log_warn "Obsidian is already installed. Skipping..."
else
    log_info "Installing Obsidian..."
    brew install --cask obsidian
    log_success "Obsidian installed."
fi

# 6. VLC Media Player
if has_app "VLC" || has_app "VLC media player"; then
    log_warn "VLC is already installed. Skipping..."
else
    log_info "Installing VLC..."
    brew install --cask vlc
    log_success "VLC installed."
fi

# 7. Jiggler (Prevents Mac sleeping)
if has_app "Jiggler"; then
    log_warn "Jiggler is already installed. Skipping..."
else
    log_info "Installing Jiggler..."
    brew install --cask jiggler
    log_success "Jiggler installed."
fi

# 8. Paseo
if has_app "Paseo"; then
    log_warn "Paseo is already installed. Skipping..."
else
    log_info "Installing Paseo..."
    brew install --cask paseo
    log_success "Paseo installed."
fi
