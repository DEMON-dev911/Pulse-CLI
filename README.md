# ⚡ PULSE

> Autonomous, ultra-fast terminal vibe-coding agent written in Rust.

Pulse is an autonomous CLI developer agent inspired by Claude Code. It runs directly inside your terminal, connects to local or remote OpenAI-compatible endpoints (like FreeLLMAPI, Ollama, Groq, or OpenRouter), and autonomously reads, writes, edits, and verifies your codebase while you steer the vibes.

---

## ✨ Features

- **Autonomous Tool-Calling Loop**: Reads files, applies atomic unified diff edits, deletes files, runs tests, and executes shell commands.
- **Claude Code-Inspired Cyan UI**: Reverse-video highlighted input prompt, dynamic `Thought for Xs` ticker, and clean bulleted stream responses.
- **Model Context Protocol (MCP)**: Extensible stdio-based MCP integration for third-party tools and databases.
- **Built-in Power Commands**: Interactive slash commands (`/commit`, `/diff`, `/clear`, `/model`, `/planning`, `/skills`, `/mcp`).
- **Zero Heavy Dependencies**: Pure compiled Rust binary with fast startup and low memory footprint.

---

## 🚀 Quick Install

### Method 1: One-Line Install (Recommended)

Run this command in your terminal to automatically download the compiled release binary and install it globally to your `$PATH`:

```bash
curl -fsSL [https://raw.githubusercontent.com/DEMON-dev911/pulse/main/install.sh](https://raw.githubusercontent.com/DEMON-dev911/pulse/main/install.sh) | bash
