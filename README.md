# macOS Developer Setup Script (`mac-setup-script`)

This repository contains a modular, idempotent, and interactive set of shell scripts to automate the configuration and installation of developer tools, runtimes, browsers, and utility applications on a fresh macOS machine (Intel or Apple Silicon).

## 🚀 Key Features

* **Interactive Skip Menu**: Displays all setup components with numbers on launch, allowing you to skip any component by inputting their numbers (e.g. entering `5, 8` skips AI Workloads and System Utilities).
* **Idempotency**: All installer scripts check if a utility or configuration is already active or installed before trying to install it. It is safe to run the script multiple times.
* **Modular Sub-Scripts**: Run the entire suite through `setup.sh` or execute specific parts independently (e.g., `bash scripts/03_languages.sh`).
* **Dependency Awareness**: Individual scripts auto-detect and run their pre-requisites (like Homebrew) if executed independently.

---

## 📁 Repository Structure

```text
mac-setup-script/
├── README.md                # Documentation & instructions
├── bootstrap.sh             # One-liner bootstrap script
├── setup.sh                 # Main interactive orchestrator entrypoint
├── lib/
│   └── utils.sh             # Shared helper functions (logging, idempotency helpers)
└── scripts/
    ├── 00_homebrew.sh       # Homebrew compiler & shell integration
    ├── 01_git.sh            # Global Git defaults and credentials caching
    ├── 02_cli_tools.sh      # Basic utilities (ripgrep, jq, fzf)
    ├── 03_languages.sh      # Compilers and runtimes (Node.js via fnm, Python3, Rust, Java)
    ├── 04_ai_workloads.sh   # AI/ML workloads (Ollama, Docker, LM Studio, Claude, Gemini, AnythingLLM, Antigravity, Codex, OpenCode, Claude Code)
    ├── 05_editors_terminals.sh # IDEs & terminals (VS Code, Zed, iTerm2, Ghostty, JetBrains Toolbox, Antigravity IDE)
    ├── 06_browsers.sh       # Web browsers (Google Chrome + chromedriver, Brave, Firefox, Edge)
    ├── 07_communication.sh  # Desktop communication (Slack, Teams, WhatsApp, Signal)
    └── 08_utilities.sh      # System helpers (Rectangle, Macs Fan Control, Wireshark, Tailscale, Obsidian, VLC, Jiggler, Paseo)
```

---

## 🚀 One-Line Installation

On a fresh Mac, open Terminal and run the following command to bootstrap the entire setup:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/programmerpro19/mac-setup-script/main/bootstrap.sh)"
```

This script will automatically:
1. Ensure Xcode Command Line Tools are installed (prompts you if missing).
2. Clone this repository into `~/mac-setup-script`.
3. Launch the interactive setup wizard allowing you to choose which parts to install or skip.

---

## 💻 Manual Installation (Alternative)

If you prefer to run it manually, follow these steps:

1. Clone this repository:
   ```bash
   git clone https://github.com/programmerpro19/mac-setup-script.git
   cd mac-setup-script
   ```

2. Make the scripts executable:
   ```bash
   chmod +x setup.sh scripts/*.sh bootstrap.sh
   ```

3. Run the main orchestrator script:
   ```bash
   ./setup.sh
   ```

4. Choose components to skip by entering their numbers separated by commas or spaces when prompted (e.g. `4, 6`), or press `Enter` to run all installations.


---

## 🔧 Running Sub-scripts Independently

You can execute any script inside the `scripts/` folder on its own. For example:

```bash
bash scripts/03_languages.sh
```

* **Note on Dependencies**: If a sub-script has prerequisites (e.g., CLI Tools require Homebrew), it will automatically run the appropriate dependency script first. If run from `setup.sh` (orchestrated run), the sub-scripts will bypass redundant prerequisite checks for a cleaner terminal output.

---

## 🛠️ Components List

Here is what gets installed by each component index:

1. **Homebrew Setup**
   * Configures package paths for either Apple Silicon (`/opt/homebrew`) or Intel (`/usr/local`).
   * Configures shellenv inside `.zshrc` and `.zprofile`.
2. **Git Configuration**
   * Configures global user name and email (interactive prompts with defaults).
   * Sets default branch to `main`.
   * Sets macOS credentials helper (`osxkeychain`) and color UI.
3. **CLI Utilities**
   * Installs `ripgrep`, `jq`, and `fzf` via Homebrew.
   * Configures `fzf` command line auto-completion and keybindings.
4. **Languages & Runtimes**
   * `fnm` (Fast Node Manager) + installs latest Node LTS and sets it as default.
   * `python3` via Homebrew.
   * `rustup` + configures PATH for Cargo.
   * OpenJDK (Java JDK 21+).
5. **AI / ML Workloads**
   * Ollama Cask (local LLM runner).
   * Docker Desktop.
   * LM Studio (cask).
   * AnythingLLM (cask).
   * Claude Desktop (cask).
   * Google Gemini (cask).
   * Google Antigravity Desktop App (cask).
   * OpenAI Codex Desktop App (cask).
   * Claude Code CLI (cask).
   * Google Antigravity CLI (`agy`) (cask).
   * OpenAI Codex CLI (`codex`) (cask).
   * OpenCode CLI (formula).
6. **GUI Editors & Terminals**
   * Visual Studio Code + configures PATH symlink for `code` CLI.
   * Zed editor.
   * iTerm2 terminal.
   * Ghostty terminal.
   * JetBrains Toolbox.
   * Google Antigravity IDE (cask).
7. **Web Browsers**
   * Google Chrome + Chromedriver.
   * Brave Browser.
   * Firefox.
   * Microsoft Edge.
8. **Communication Tools**
   * Slack.
   * Microsoft Teams.
   * WhatsApp.
   * Signal.
9. **System Utilities & Extras**
   * Rectangle (window resizing utility).
   * Macs Fan Control.
   * Wireshark (packet analyzer).
   * Tailscale (Mesh VPN).
   * Obsidian (Markdown notes).
   * VLC media player.
   * Jiggler (prevents sleeping).
   * Paseo.

---

## 🧹 Post-Installation

After the script finishes successfully, restart your terminal or reload your shell profile to apply all path changes:

```bash
source ~/.zshrc
```
