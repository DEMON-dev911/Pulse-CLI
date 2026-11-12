<div align="center">

<!-- Animated SVG Header Banner -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1DA1F2,50:7B7CE6,100:D95B78&height=210&section=header&text=PULSE&fontSize=72&fontColor=ffffff&fontAlignY=38&desc=Autonomous%20Terminal%20Coding%20Agent%20and%20Vibe-Coding%20CLI&descAlignY=62&descSize=18&animation=fadeIn" width="100%" alt="PULSE Banner" />

<!-- Animated Typing Tagline -->
<a href="https://github.com/DEMON-dev911/Pulse-CLI">
  <img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=600&size=17&duration=3000&pause=1000&color=1DA1F2&center=true&vCenter=true&width=820&lines=Ultra-fast+compiled+Rust+runtime+with+zero+heavy+dependencies;Autonomous+file+editing%2C+unified+diffs%2C+and+shell+execution;Native+support+for+macOS%2C+Windows%2C+Linux%2C+and+Omarchy;Works+out+of+the+box+with+built-in+credentials+or+your+own+API+keys" alt="Typing SVG" />
</a>

<br/>

<!-- Live GitHub Repository Badges -->
<p>
  <a href="https://github.com/DEMON-dev911/Pulse-CLI/stargazers">
    <img src="https://img.shields.io/github/stars/DEMON-dev911/Pulse-CLI?style=for-the-badge&logo=github&color=1DA1F2&labelColor=0D1117" alt="GitHub Stars" />
  </a>
  <a href="https://github.com/DEMON-dev911/Pulse-CLI/releases/latest">
    <img src="https://img.shields.io/github/v/release/DEMON-dev911/Pulse-CLI?style=for-the-badge&logo=semanticrelease&color=7B7CE6&labelColor=0D1117" alt="Latest Release" />
  </a>
  <a href="https://github.com/DEMON-dev911/Pulse-CLI/releases">
    <img src="https://img.shields.io/github/downloads/DEMON-dev911/Pulse-CLI/total?style=for-the-badge&logo=icloud&color=D95B78&labelColor=0D1117" alt="Total Downloads" />
  </a>
  <a href="https://github.com/DEMON-dev911/Pulse-CLI/network/members">
    <img src="https://img.shields.io/github/forks/DEMON-dev911/Pulse-CLI?style=for-the-badge&logo=git&color=38BDF8&labelColor=0D1117" alt="Forks" />
  </a>
</p>

<p>
  <img src="https://img.shields.io/badge/Built_With-Rust-000000?style=flat-square&logo=rust&logoColor=white" alt="Rust" />
  <img src="https://img.shields.io/badge/Platform-macOS_%7C_Linux_%7C_Windows-111827?style=flat-square" alt="Platforms" />
  <img src="https://img.shields.io/badge/Arch_%2F_Omarchy-Ready-1793D1?style=flat-square&logo=archlinux&logoColor=white" alt="Arch Linux" />
  <img src="https://img.shields.io/badge/MCP-Compatible-7B7CE6?style=flat-square&logo=protocol&logoColor=white" alt="MCP" />
</p>

</div>

---

## Overview

**Pulse** is an autonomous, terminal-native developer agent engineered in Rust. Designed for high-speed local execution, it operates directly inside your working directory to read codebases, apply atomic unified diffs, run test suites, manage git workflows, and interface with Model Context Protocol (MCP) servers.

```text
  ██╗      ██████╗ ██╗   ██╗██╗     ███████╗███████╗
  ╚██╗     ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
   ╚██╗    ██████╔╝██║   ██║██║     ███████╗█████╗  
   ██╔╝    ██╔═══╝ ██║   ██║██║     ╚════██║██╔══╝  
  ██╔╝     ██║     ╚██████╔╝███████╗███████║███████╗
  ╚═╝      ╚═╝      ╚═════╝ ╚══════╝╚══════╝╚══════╝

  PULSE · Autonomous Coding Runtime
  gateway  [http://127.0.0.1:31415/v1](http://127.0.0.1:31415/v1) [online]
  context  ~/project · branch main · stack Rust
```

---

## Core Architecture & Features

| Capability | Description |
| :--- | :--- |
| **Zero-Config Ready** | Ships pre-configured with a built-in default API endpoint and credentials so you can launch and code immediately without initial setup. |
| **Bring Your Own Key (BYOK)** | Easily override the built-in defaults with your own Gemini, Groq, OpenAI, Anthropic, OpenRouter, or local Ollama API keys. |
| **Autonomous Tool Loop** | Reads files, previews color-coded unified diffs, applies atomic edits, and executes shell commands with live output streaming. |
| **Project Context (`PULSE.md`)** | Automatically discovers `PULSE.md` or `.pulse.md` in the repository root to enforce project rules, architecture notes, and conventions. |
| **Session Persistence** | Records every turn locally in JSONL format. Pick up previous work instantly using `--continue` or `--resume`. |
| **Granular Safety Controls** | Interactive approval prompts (`[y]es / [n]o / [a]lways`), safe simulation via `--dry-run`, or full autonomy via `--yolo`. |
| **Headless & CI/CD Piping** | Process piped standard input (`cat error.log \| pulse -p`) and emit structured machine-readable output with `--json`. |
| **Custom Slash Commands** | Drop reusable Markdown prompt templates inside `.pulse/commands/` or `~/.config/pulse/commands/` to register dynamic `/commands`. |
| **MCP Integration** | Connects to external `stdio` Model Context Protocol servers to extend tool capabilities dynamically. |
| **Zero-Bloat Binary** | Compiles to a single standalone executable with sub-10ms startup time and minimal memory overhead. |

---

## Installation

Choose the installation method for your operating system below. All installers fetch pre-compiled native binaries directly from [GitHub Releases](https://github.com/DEMON-dev911/Pulse-CLI/releases).

### 1. macOS (Apple Silicon & Intel)

Run the automated shell installer to download the native macOS binary and install it to your local path:

```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh) | bash
```

**Manual Installation (macOS):**
```bash
curl -L [https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-macos-arm64.tar.gz](https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-macos-arm64.tar.gz) -o pulse.tar.gz
tar -xzf pulse.tar.gz
chmod +x pulse
sudo mv pulse /usr/local/bin/pulse
rm pulse.tar.gz
```

---

### 2. Linux (Ubuntu, Debian, Fedora, Arch)

The unified installer automatically detects Linux x86_64 and installs the static `musl` binary into `~/.local/bin/pulse` without requiring root privileges:

```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh) | bash
```

> **Note:** Ensure `~/.local/bin` is included in your shell `PATH`. Add `export PATH="$HOME/.local/bin:$PATH"` to your `~/.bashrc` or `~/.zshrc` if needed.

**Manual Installation (Linux):**
```bash
mkdir -p ~/.local/bin
curl -L [https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-linux-x86_64.tar.gz](https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-linux-x86_64.tar.gz) -o pulse.tar.gz
tar -xzf pulse.tar.gz -C ~/.local/bin
chmod +x ~/.local/bin/pulse
rm pulse.tar.gz
```

---

### 3. Omarchy & Arch Linux (`PKGBUILD`)

Pulse is optimized for Wayland terminal emulators (`foot`, `ghostty`, `kitty`, `alacritty`) and Omarchy's user-space agent architecture.

**Option A: One-Line User-Space Install (Recommended for Omarchy):**
```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh) | bash
```

**Option B: Native Pacman Package via `PKGBUILD`:**
```bash
git clone [https://github.com/DEMON-dev911/Pulse-CLI.git](https://github.com/DEMON-dev911/Pulse-CLI.git)
cd Pulse-CLI
makepkg -si
```

**Optional Hyprland Keybinding (`~/.config/hypr/hyprland.conf`):**
```ini
bind = $mainMod, P, exec, foot --title="Pulse CLI" -e pulse
```

---

### 4. Windows (Windows 10 / 11 x86_64)

Open **PowerShell** and run the automated Windows installer to download `pulse.exe` and configure your User `PATH`:

```powershell
irm [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.ps1](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.ps1) | iex
```

**Manual Installation (Windows PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\Pulse" | Out-Null
Invoke-WebRequest -Uri "[https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-windows-x86_64.zip](https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-windows-x86_64.zip)" -OutFile "$env:TEMP\pulse.zip"
Expand-Archive -Path "$env:TEMP\pulse.zip" -DestinationPath "$env:LOCALAPPDATA\Pulse" -Force
Remove-Item "$env:TEMP\pulse.zip"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:LOCALAPPDATA\Pulse", "User")
```

> Restart your terminal window after installation so the updated `PATH` takes effect.

---

## Configuration & API Keys

Pulse works **immediately out of the box** using the pre-configured built-in API credentials—no manual configuration is required to start using it.

If you prefer to use your own API keys, personal rate limits, or a local LLM server, you can override the built-in defaults at any time.

### Option 1: Use the Built-In API Key (Zero Setup)

Simply run `pulse` in your terminal right after installation. Pulse will automatically authenticate using its pre-packaged default gateway and fallback keys.

### Option 2: Add Your Own API Keys (Optional)

To override the default credentials with your own keys, create a `.env` file at `~/.config/pulse/.env` (Linux/macOS), `%USERPROFILE%\.config\pulse\.env` (Windows), or inside your project root:

```env
# Optional: Override with your own OpenAI-compatible local or cloud endpoint
FREELLMAPI_URL="[http://127.0.0.1:31415/v1](http://127.0.0.1:31415/v1)"
FREELLMAPI_KEY=""

# Optional: Add your personal API keys (Priority order from top to bottom)
GEMINI_API_KEY="your-gemini-api-key"
GROQ_API_KEY="your-groq-api-key"
ANTHROPIC_API_KEY="your-anthropic-api-key"
OPENAI_API_KEY="your-openai-api-key"
OPENROUTER_API_KEY="your-openrouter-api-key"

# Runtime Preferences
PULSE_DEFAULT_TIMEOUT_SECS="30"
PULSE_AUTO_FALLBACK="true"
```

> **Configuration Precedence:** Shell environment variables take highest priority, followed by a local project `.env`, then `~/.config/pulse/.env`, and finally the built-in default API keys. You can also switch providers interactively at any time using the `/model` slash command.

---

## Usage Guide

### 1. Interactive Terminal REPL

Launch Pulse inside any project directory to start an interactive coding session:

```bash
pulse
```

### 2. Single-Turn & Headless Execution (`-p`)

Execute a direct instruction or pipe logs/files directly into Pulse for automated workflows and CI/CD pipelines:

```bash
# Direct task execution
pulse "Add exponential backoff retry logic to src/client.rs"

# Pipe input in headless print mode
cargo test 2>&1 | pulse -p "Analyze the failing test output and patch the root cause"

# Emit structured JSON for scripting
pulse -p --json "Summarize the repository architecture"
```

### 3. CLI Flags Reference

| Flag | Alias | Description |
| :--- | :--- | :--- |
| `--print` | `-p` | Run non-interactively, print response to `stdout`, and exit. |
| `--json` | | Output structured JSON (`response`, `tool_calls`, `tokens`, `session_id`). |
| `--continue` | `-c` | Resume the most recent session for the current working directory. |
| `--resume [ID]` | `-r` | Resume a specific session ID or open the interactive session picker. |
| `--dry-run` | | Preview diffs and shell commands without writing to disk or executing. |
| `--yolo` | `--yes` | Bypass interactive confirmation prompts for trusted autonomous runs. |
| `--model <NAME>` | `-m` | Override the active model for the current session. |

### 4. Interactive Slash Commands

Inside the interactive REPL, type `/` to access built-in and custom commands:

| Command | Action |
| :--- | :--- |
| `/diff` | Display unstaged git changes across the workspace. |
| `/commit` | Generate a conventional commit message from staged/unstaged changes and commit. |
| `/compact` | Summarize older conversation history to free up context window tokens. |
| `/clear` | Wipe the current conversation context and reset token counters. |
| `/model` | Switch between the built-in API key and your custom configured LLM providers. |
| `/mcp` | Inspect connected Model Context Protocol servers and available tools. |
| `/skills` | List custom Markdown slash commands loaded from `.pulse/commands/`. |

---

## Extending Pulse with Custom Commands

Create a Markdown file inside `.pulse/commands/` (project-scoped) or `~/.config/pulse/commands/` (global). Use `$ARGUMENTS` to capture trailing user input.

Example: `.pulse/commands/review.md`

```markdown
Perform a strict security, performance, and idiomatic code review on the following target: $ARGUMENTS.
Highlight potential edge cases, memory allocations, or unhandled errors, and propose concrete diffs.
```

Once saved, invoke `/review src/main.rs` directly inside the Pulse prompt.

---

## Uninstallation

Remove Pulse and its local configuration/session files completely using the instructions for your operating system.

### 1. macOS

**Using the Uninstall Script:**
```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.sh) | bash
```

**Manual Removal (Binary + Config/Sessions):**
```bash
rm -f /usr/local/bin/pulse ~/.local/bin/pulse
rm -rf ~/.config/pulse ~/.local/share/pulse
```

---

### 2. Linux & Omarchy

**Using the Uninstall Script:**
```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.sh) | bash
```

**If Installed via Arch `PKGBUILD` / `pacman`:**
```bash
sudo pacman -Rns pulse-bin
```

**Manual Removal (Binary + Config/Sessions):**
```bash
rm -f ~/.local/bin/pulse /usr/local/bin/pulse
rm -rf ~/.config/pulse ~/.local/share/pulse
```

---

### 3. Windows (PowerShell)

**Using the Uninstall Script:**
```powershell
irm [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.ps1](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.ps1) | iex
```

**Manual Removal (Binary, Config & PATH Cleanup):**
```powershell
# Remove binary and local application data
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Pulse" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.config\pulse" -ErrorAction SilentlyContinue

# Remove Pulse from User PATH
$pulseDir = "$env:LOCALAPPDATA\Pulse"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = ($currentPath -split ';' \vert{} Where-Object {$_ -ne $pulseDir -and$_ -ne '' }) -join ';'
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")
```

---

<div align="center">

<!-- Animated Footer Wave -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:D95B78,50:7B7CE6,100:1DA1F2&height=110&section=footer" width="100%" alt="Footer" />

</div>
