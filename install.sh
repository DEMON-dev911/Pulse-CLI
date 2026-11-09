#!/usr/bin/env bash
#
# Pulse — installer
#
# Builds the release binary and installs `pulse` so it can be run from any
# directory. Detects the active shell and wires the install directory into
# $PATH (rc-file edit) when required.
#
# Usage:
#   ./install.sh                 # build + install to ~/.local/bin
#   ./install.sh --system        # build + install to /usr/local/bin (may need sudo)
#   ./install.sh --dir <path>    # build + install to a custom directory
#   ./install.sh --no-path       # do not touch any shell rc file
#   ./install.sh --skip-build    # install an already-built target/release/pulse
#
set -euo pipefail

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  C_RESET=$'\033[0m'
  C_BOLD=$'\033[1m'
  C_DIM=$'\033[2m'
  C_RED=$'\033[1;31m'
  C_GREEN=$'\033[1;32m'
  C_YELLOW=$'\033[1;33m'
  C_CYAN=$'\033[1;36m'
else
  C_RESET=''; C_BOLD=''; C_DIM=''; C_RED=''; C_GREEN=''; C_YELLOW=''; C_CYAN=''
fi

info()  { printf '%s▸%s %s\n' "$C_CYAN"   "$C_RESET" "$*"; }
ok()    { printf '%s✓%s %s\n' "$C_GREEN"  "$C_RESET" "$*"; }
warn()  { printf '%s!%s %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }
err()   { printf '%s✗%s %s\n' "$C_RED"    "$C_RESET" "$*" >&2; }
die()   { err "$*"; exit 1; }
step()  { printf '\n%s%s%s\n' "$C_BOLD" "$*" "$C_RESET"; }

BIN_NAME="pulse"
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" >/dev/null 2>&1 && pwd)"

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
INSTALL_DIR=""
USE_SYSTEM=0
NO_PATH=0
SKIP_BUILD=0

while [ $# -gt 0 ]; do
  case "$1" in
    --system)     USE_SYSTEM=1 ;;
    --dir)        shift; [ $# -gt 0 ] || die "--dir requires a path"; INSTALL_DIR="$1" ;;
    --dir=*)      INSTALL_DIR="${1#*=}" ;;
    --no-path)    NO_PATH=1 ;;
    --skip-build) SKIP_BUILD=1 ;;
    -h|--help)
      sed -n '2,18p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) die "unknown option: $1 (try --help)" ;;
  esac
  shift
done

# ---------------------------------------------------------------------------
# 1. Toolchain check
# ---------------------------------------------------------------------------
step "1/5  Checking the Rust toolchain"
command -v cargo >/dev/null 2>&1 || die "cargo not found. Install Rust: https://rustup.rs"
ok "cargo $(cargo --version 2>/dev/null | awk '{print $2}')"

# ---------------------------------------------------------------------------
# 2. Build the release binary
# ---------------------------------------------------------------------------
cd -- "$SCRIPT_DIR"

if [ "$SKIP_BUILD" -eq 0 ]; then
  step "2/5  Building the release binary (cargo build --release)"
  info "this can take a minute on the first run (full LTO)..."
  if ! cargo build --release; then
    die "cargo build --release failed"
  fi
  ok "build finished"
else
  step "2/5  Skipping build (--skip-build)"
fi

SRC_BIN="$SCRIPT_DIR/target/release/$BIN_NAME"
[ -f "$SRC_BIN" ] || die "binary not found at $SRC_BIN (run without --skip-build)"
ok "binary: $SRC_BIN"

# ---------------------------------------------------------------------------
# 3. Choose the install directory
# ---------------------------------------------------------------------------
step "3/5  Selecting the install directory"

if [ -n "$INSTALL_DIR" ]; then
  : # explicit override
elif [ "$USE_SYSTEM" -eq 1 ]; then
  INSTALL_DIR="/usr/local/bin"
elif [ -d "$HOME/.local/bin" ]; then
  INSTALL_DIR="$HOME/.local/bin"
elif [ -d "$HOME/.cargo/bin" ]; then
  INSTALL_DIR="$HOME/.cargo/bin"
elif [ -d "/usr/local/bin" ]; then
  INSTALL_DIR="/usr/local/bin"
else
  INSTALL_DIR="$HOME/.local/bin"
  info "no standard bin directory found — creating $INSTALL_DIR"
fi

# Resolve the effective write strategy (sudo only when needed).
SUDO=""
if [ ! -d "$INSTALL_DIR" ]; then
  if mkdir -p "$INSTALL_DIR" 2>/dev/null; then
    ok "created $INSTALL_DIR"
  else
    warn "cannot create $INSTALL_DIR without elevated privileges"
    command -v sudo >/dev/null 2>&1 || die "sudo unavailable; re-run with: ./install.sh --dir \$HOME/.local/bin"
    SUDO="sudo"
    $SUDO mkdir -p "$INSTALL_DIR" || die "failed to create $INSTALL_DIR"
  fi
elif [ ! -w "$INSTALL_DIR" ]; then
  warn "$INSTALL_DIR is not writable by $(id -un)"
  command -v sudo >/dev/null 2>&1 || die "sudo unavailable; re-run with: ./install.sh --dir \$HOME/.local/bin"
  SUDO="sudo"
fi

ok "install dir: $INSTALL_DIR"

# ---------------------------------------------------------------------------
# 4. Copy the binary
# ---------------------------------------------------------------------------
step "4/5  Installing the binary"
DEST="$INSTALL_DIR/$BIN_NAME"

if [ -e "$DEST" ]; then
  info "replacing existing $DEST"
fi

# Copy to a temp name first, then move into place: avoids a partially written
# binary if the copy is interrupted.
TMP_DEST="$INSTALL_DIR/.${BIN_NAME}.new.$$"
$SUDO cp "$SRC_BIN" "$TMP_DEST" || die "failed to copy the binary"
$SUDO chmod 755 "$TMP_DEST" || die "failed to chmod the binary"
$SUDO mv -f "$TMP_DEST" "$DEST" || die "failed to move the binary into place"

if ! "$DEST" --version >/dev/null 2>&1; then
  warn "installed, but \`$BIN_NAME --version\` did not run cleanly"
fi
ok "installed: $DEST"

# ---------------------------------------------------------------------------
# 5. PATH wiring
# ---------------------------------------------------------------------------
step "5/5  Configuring \$PATH"

USER_SHELL=""
RC_FILE=""

case ":$PATH:" in
  *":$INSTALL_DIR:"*)
    ok "$INSTALL_DIR is already on \$PATH"
    PATH_READY=1
    ;;
  *)
    PATH_READY=0
    ;;
esac

if [ "$PATH_READY" -eq 0 ]; then
  if [ "$NO_PATH" -eq 1 ]; then
    warn "skipping rc-file edit (--no-path)"
  else
    # Detect the user's shell, and pick the matching rc file.
    USER_SHELL="$(basename -- "${SHELL:-sh}")"
    # zsh reads .zshrc for interactive shells; macOS Terminal is zsh by default.
    case "$USER_SHELL" in
      zsh)  RC_FILE="${ZDOTDIR:-$HOME}/.zshrc";        EXPORT_LINE="export PATH=\"$INSTALL_DIR:\$PATH\"" ;;
      bash)
        if [ -f "$HOME/.bashrc" ]; then RC_FILE="$HOME/.bashrc"; else RC_FILE="$HOME/.bash_profile"; fi
        EXPORT_LINE="export PATH=\"$INSTALL_DIR:\$PATH\""
        ;;
      fish)
        RC_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/fish/config.fish"
        EXPORT_LINE="fish_add_path \"$INSTALL_DIR\""
        ;;
      *)
        RC_FILE="$HOME/.profile"
        EXPORT_LINE="export PATH=\"$INSTALL_DIR:\$PATH\""
        warn "unrecognised shell '$USER_SHELL'; falling back to $RC_FILE"
        ;;
    esac

    info "detected shell: $USER_SHELL  →  $RC_FILE"

    mkdir -p -- "$(dirname -- "$RC_FILE")" 2>/dev/null || true
    touch -- "$RC_FILE" 2>/dev/null || die "cannot write to $RC_FILE"

    MARKER="# >>> pulse installer >>>"
    if grep -qF "$MARKER" "$RC_FILE" 2>/dev/null; then
      ok "$RC_FILE already patched by a previous run"
    else
      {
        printf '\n%s\n' "$MARKER"
        printf '%s\n' "$EXPORT_LINE"
        printf '%s\n' "# <<< pulse installer <<<"
      } >> "$RC_FILE" || die "failed to append to $RC_FILE"
      ok "appended the PATH export to $RC_FILE"
    fi
  fi
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
step "Done"
if [ "$PATH_READY" -eq 1 ]; then
  printf '  Run it from anywhere:  %spulse%s\n' "$C_CYAN$C_BOLD" "$C_RESET"
elif [ -n "$RC_FILE" ]; then
  printf '  %sActivate this session:%s\n' "$C_BOLD" "$C_RESET"
  printf '    %ssource %s%s\n' "$C_CYAN" "$RC_FILE" "$C_RESET"
  printf '  %s…then open a new terminal and run:%s  %spulse%s\n' "$C_DIM" "$C_RESET" "$C_CYAN$C_BOLD" "$C_RESET"
else
  printf '  %sAdd this to your shell rc file manually:%s\n' "$C_BOLD" "$C_RESET"
  printf '    %sexport PATH="%s:$PATH"%s\n' "$C_CYAN" "$INSTALL_DIR" "$C_RESET"
fi
printf '\n'
