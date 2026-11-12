<div align="center">

<!-- Animated SVG Header Banner -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1DA1F2,50:7B7CE6,100:D95B78&height=210&section=header&text=PULSE&fontSize=72&fontColor=ffffff&fontAlignY=38&desc=Autonomous%20Terminal%20Coding%20Agent%20and%20Vibe-Coding%20CLI&descAlignY=62&descSize=18&animation=fadeIn&fontFamily=Orbitron" width="100%" alt="PULSE Banner" />

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

## <kbd>01</kbd> `OVERVIEW`

> **<samp>PULSE</samp>** *is an autonomous, terminal-native developer agent engineered in Rust. Designed for high-speed local execution, it operates directly inside your working directory to read codebases, apply atomic unified diffs, run test suites, manage git workflows, and interface with Model Context Protocol (MCP) servers.*

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

## <kbd>02</kbd> `CORE ARCHITECTURE & FEATURES`

| Capability | Description |
| :--- | :--- |
| **`ZERO-CONFIG READY`** | Ships pre-configured with a built-in default API endpoint and credentials so you can launch and code immediately without initial setup. |
| **`BRING YOUR OWN KEY (BYOK)`** | Easily override the built-in defaults with your own Gemini, Groq, OpenAI, Anthropic, OpenRouter, or local Ollama API keys. |
| **`AUTONOMOUS TOOL LOOP`** | Reads files, previews color-coded unified diffs, applies atomic edits, and executes shell commands with live output streaming. |
| **`PROJECT CONTEXT (PULSE.md)`** | Automatically discovers `PULSE.md` or `.pulse.md` in the repository root to enforce project rules, architecture notes, and conventions. |
| **`SESSION PERSISTENCE`** | Records every turn locally in JSONL format. Pick up previous work instantly using `--continue` or `--resume`. |
| **`GRANULAR SAFETY CONTROLS`** | Interactive approval prompts (`[y]es / [n]o / [a]lways`), safe simulation via `--dry-run`, or full autonomy via `--yolo`. |
| **`HEADLESS & CI/CD PIPING`** | Process piped standard input (`cat error.log \| pulse -p`) and emit structured machine-readable output with `--json`. |
| **`CUSTOM SLASH COMMANDS`** | Drop reusable Markdown prompt templates inside `.pulse/commands/` or `~/.config/pulse/commands/` to register dynamic `/commands`. |
| **`MCP INTEGRATION`** | Connects to external `stdio` Model Context Protocol servers to extend tool capabilities dynamically. |
| **`ZERO-BLOAT BINARY`** | Compiles to a single standalone executable with sub-10ms startup time and minimal memory overhead. |

### <samp>HOW THE AUTONOMOUS LOOP WORKS</samp>

1. **Context Discovery:** *Scans the working directory for `PULSE.md`, active Git branch state, language stack markers (`Cargo.toml`, `package.json`, `pyproject.toml`, `go.mod`), and local `.env` overrides.*
2. **Streaming Inference:** *Dispatches prompts with full tool schemas to your active OpenAI-compatible gateway and streams reasoning tokens in real time.*
3. **Atomic Tool Execution:** *Parses structured tool calls (`read_file`, `write_file`, `apply_diff`, `delete_file`, `run_shell`, `search_files`), renders unified diffs, and enforces permission policies before mutating disk state.*
4. **Verification & Self-Correction:** *Captures compiler errors, linter warnings, or test failures from shell execution and iterates automatically until the task passes cleanly.*

---

## <kbd>03</kbd> `INSTALLATION`

<sub>Choose the installation method for your operating system below. All installers fetch pre-compiled native binaries directly from <a href="https://github.com/DEMON-dev911/Pulse-CLI/releases">GitHub Releases</a>.</sub>

### 1. macOS (`Apple Silicon & Intel`)

Run the automated shell installer to download the native macOS binary and install it to your local path:

```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh) | bash
```

**Manual Installation (`macOS`):**
```bash
curl -L [https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-macos-arm64.tar.gz](https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-macos-arm64.tar.gz) -o pulse.tar.gz
tar -xzf pulse.tar.gz
chmod +x pulse
sudo mv pulse /usr/local/bin/pulse
rm pulse.tar.gz
```

---

### 2. Linux (`Ubuntu, Debian, Fedora, Arch`)

The unified installer automatically detects Linux `x86_64` and installs the static `musl` binary into `~/.local/bin/pulse` without requiring root privileges:

```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh) | bash
```

> <sub><b>PATH NOTE:</b> Ensure <code>~/.local/bin</code> is included in your shell <code>PATH</code>. Add <code>export PATH="$HOME/.local/bin:$PATH"</code> to your <code>~/.bashrc</code> or <code>~/.zshrc</code> if needed.</sub>

**Manual Installation (`Linux`):**
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

**Option A — One-Line User-Space Install (`Recommended for Omarchy`):**
```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.sh) | bash
```

**Option B — Native Pacman Package via `PKGBUILD`:**
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

### 4. Windows (`Windows 10 / 11 x86_64`)

Open **PowerShell** and run the automated Windows installer to download `pulse.exe` and configure your User `PATH`:

```powershell
irm [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.ps1](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/install.ps1) | iex
```

**Manual Installation (`Windows PowerShell`):**
```powershell
New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\Pulse" | Out-Null
Invoke-WebRequest -Uri "[https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-windows-x86_64.zip](https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download/pulse-windows-x86_64.zip)" -OutFile "$env:TEMP\pulse.zip"
Expand-Archive -Path "$env:TEMP\pulse.zip" -DestinationPath "$env:LOCALAPPDATA\Pulse" -Force
Remove-Item "$env:TEMP\pulse.zip"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:LOCALAPPDATA\Pulse", "User")
```

> <sub><b>RESTART REQUIRED:</b> Restart your terminal window after installation so the updated <code>PATH</code> takes effect.</sub>

---

## <kbd>04</kbd> `CONFIGURATION & API KEYS`

Pulse works **immediately out of the box** using the pre-configured built-in API credentials—no manual configuration is required to start using it.

If you prefer to use your own API keys, personal rate limits, or a local LLM server, you can override the built-in defaults at any time.

### Option 1 — Use the Built-In API Key (`Zero Setup`)

Simply run `pulse` in your terminal right after installation. Pulse will automatically authenticate using its pre-packaged default gateway and fallback keys.

### Option 2 — Add Your Own API Keys (`Optional`)

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

> <sub><b>CONFIGURATION PRECEDENCE:</b> Shell environment variables take highest priority, followed by a local project <code>.env</code>, then <code>~/.config/pulse/.env</code>, and finally the built-in default API keys. You can also switch providers interactively at any time using the <code>/model</code> slash command.</sub>

---

## <kbd>05</kbd> `USAGE GUIDE`

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

## <kbd>06</kbd> `PROJECT CONTEXT & MCP SERVERS`

### Project Rules (`PULSE.md`)

Place a `PULSE.md` (or `.pulse.md`) file in your repository root so Pulse automatically loads project conventions, build commands, and architectural constraints at startup:

```markdown
# Project Rules
- Always run `cargo clippy -- -D warnings` after modifying Rust files.
- Prefer `thiserror` for library errors and `anyhow` in binary entrypoints.
- Never commit secrets or `.env` files.
```

### Model Context Protocol (`mcp.json`)

Connect external tools, databases, or browser automation servers by creating `~/.config/pulse/mcp.json` or `.pulse/mcp.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token"
      }
    }
  }
}
```

---

## <kbd>07</kbd> `EXTENDING PULSE WITH CUSTOM COMMANDS`

Create a Markdown file inside `.pulse/commands/` (project-scoped) or `~/.config/pulse/commands/` (global). Use `$ARGUMENTS` to capture trailing user input.

Example: `.pulse/commands/review.md`

```markdown
Perform a strict security, performance, and idiomatic code review on the following target: $ARGUMENTS.
Highlight potential edge cases, memory allocations, or unhandled errors, and propose concrete diffs.
```

Once saved, invoke `/review src/main.rs` directly inside the Pulse prompt.

---

## <kbd>08</kbd> `UNINSTALLATION`

<sub>Remove Pulse and its local configuration/session files completely using the instructions for your operating system.</sub>

### 1. macOS

**Using the Uninstall Script:**
```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.sh](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.sh) | bash
```

**Manual Removal (`Binary + Config/Sessions`):**
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

**Manual Removal (`Binary + Config/Sessions`):**
```bash
rm -f ~/.local/bin/pulse /usr/local/bin/pulse
rm -rf ~/.config/pulse ~/.local/share/pulse
```

---

### 3. Windows (`PowerShell`)

**Using the Uninstall Script:**
```powershell
irm [https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.ps1](https://raw.githubusercontent.com/DEMON-dev911/Pulse-CLI/main/uninstall.ps1) | iex
```

**Manual Removal (`Binary, Config & PATH Cleanup`):**
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
