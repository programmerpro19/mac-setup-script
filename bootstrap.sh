#!/bin/bash

# Exit on errors
set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=============================================${NC}"
echo -e "${BLUE}      macOS Setup Bootstrapper               ${NC}"
echo -e "${BLUE}=============================================${NC}"

# Ensure Xcode Command Line Tools are installed (needed for git)
if ! xcode-select -p &>/dev/null; then
    echo -e "${BLUE}[INFO]${NC} Xcode Command Line Tools not found. Prompting for installation..."
    xcode-select --install
    echo -e "${RED}[WARN]${NC} A macOS dialog has appeared prompting you to install Command Line Tools."
    echo -e "${RED}[WARN]${NC} Please complete that installation and then re-run this bootstrap command."
    exit 0
fi

REPO_DIR="$HOME/mac-setup-script"

# Check if directory already exists
if [ -d "$REPO_DIR" ]; then
    echo -e "${RED}[WARN]${NC} Directory '${REPO_DIR}' already exists."
    echo -n -e "Would you like to delete and recreate it? (y/N): "
    read overwrite
    if [[ "$overwrite" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}[INFO]${NC} Removing old directory..."
        rm -rf "$REPO_DIR"
    else
        echo -e "${BLUE}[INFO]${NC} Entering existing directory '${REPO_DIR}' and pulling latest changes..."
        cd "$REPO_DIR"
        git pull || echo -e "${RED}[WARN]${NC} Git pull failed. Continuing with existing files..."
        chmod +x setup.sh scripts/*.sh
        ./setup.sh
        exit 0
    fi
fi

# Clone repository
echo -e "${BLUE}[INFO]${NC} Cloning mac-setup-script repository into ${REPO_DIR}..."
git clone https://github.com/programmerpro19/mac-setup-script.git "$REPO_DIR"

# Enter directory and run
cd "$REPO_DIR"
chmod +x setup.sh scripts/*.sh

echo -e "${GREEN}[SUCCESS]${NC} Repository cloned. Starting setup wizard..."
echo ""
./setup.sh
