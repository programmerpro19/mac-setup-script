#!/bin/bash

# Exit on absolute failures, but allow clean script runs
set -e

# Resolve paths relative to script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/utils.sh"

# Title Banner
echo -e "${BLUE}"
echo "============================================="
echo "        macOS Developer Setup Script         "
echo "============================================="
echo -e "${NC}"

log_info "This script will guide you through setting up your new Mac."
log_info "You will first be shown a list of software/tool components."
log_info "You can select specific components to skip."
echo ""

# Define the components
declare -a COMPONENTS=(
    "Homebrew Setup (00_homebrew.sh)"
    "Git Configuration (01_git.sh)"
    "CLI Utilities: ripgrep, jq, fzf (02_cli_tools.sh)"
    "Languages & Runtimes: Node, Python, Rust, Java (03_languages.sh)"
    "AI / ML Workloads: Ollama, Docker, LM Studio, etc. (04_ai_workloads.sh)"
    "GUI Editors & Terminals: VS Code, Zed, iTerm2, etc. (05_editors_terminals.sh)"
    "Web Browsers: Chrome, Brave, Firefox, Edge (06_browsers.sh)"
    "Communication Tools: Slack, Teams, WhatsApp, Signal (07_communication.sh)"
    "System Utilities & Extras: Rectangle, Obsidian, VLC, etc. (08_utilities.sh)"
)

# Display the component list
for i in "${!COMPONENTS[@]}"; do
    printf "  [%d] %s\n" $((i + 1)) "${COMPONENTS[$i]}"
done
echo ""

# Prompt for skip inputs
read -p "Enter numbers of components you want to SKIP (comma/space-separated, e.g. 5,8), or press Enter to run all: " skip_input

# Parse skips into an array
declare -a SKIPPED_INDICES=()
# Replace commas with spaces and split by whitespace
for token in $(echo "$skip_input" | tr ',' ' '); do
    # Verify it is a number
    if [[ "$token" =~ ^[0-9]+$ ]]; then
        SKIPPED_INDICES+=("$token")
    else
        log_warn "Skipping invalid option: '$token' (not a number)"
    fi
done

# Helper to verify if an index should be skipped
is_skipped() {
    local index="$1"
    for skip in "${SKIPPED_INDICES[@]}"; do
        if [ "$skip" -eq "$index" ]; then
            return 0
        fi
    done
    return 1
}

# Run the components
run_component() {
    local index="$1"
    local script_name="$2"
    local name="$3"
    
    if is_skipped "$index"; then
        log_warn "Skipping component [$index]: $name"
    else
        log_info "Executing component [$index]: $name..."
        # Set PARENT_RUN to signal sub-scripts that they are called from this orchestrator
        export PARENT_RUN=true
        if [ -f "${SCRIPT_DIR}/scripts/${script_name}" ]; then
            bash "${SCRIPT_DIR}/scripts/${script_name}"
        else
            log_error "Installer script not found: scripts/${script_name}"
            exit 1
        fi
        log_success "Component [$index]: $name completed."
    fi
    echo "---------------------------------------------"
}

echo ""
log_info "Starting installations..."
echo "---------------------------------------------"

run_component 1 "00_homebrew.sh" "Homebrew Setup"
run_component 2 "01_git.sh" "Git Configuration"
run_component 3 "02_cli_tools.sh" "CLI Utilities"
run_component 4 "03_languages.sh" "Languages & Runtimes"
run_component 5 "04_ai_workloads.sh" "AI / ML Workloads"
run_component 6 "05_editors_terminals.sh" "GUI Editors & Terminals"
run_component 7 "06_browsers.sh" "Web Browsers"
run_component 8 "07_communication.sh" "Communication Tools"
run_component 9 "08_utilities.sh" "System Utilities & Extras"

echo ""
log_success "All requested configurations and installations have completed!"
log_info "Please restart your terminal session (or run 'source ~/.zshrc') to load all new PATH configurations."
