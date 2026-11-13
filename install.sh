#!/usr/bin/env bash
set -euo pipefail

RELEASE_URL="https://github.com/DEMON-dev911/Pulse-CLI/releases/latest/download"
OS="$(uname -s)"
ARCH="$(uname -m)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

case "$OS" in
  Darwin)
    case "$ARCH" in
      arm64|aarch64) ASSET="pulse-macos-arm64.tar.gz" ;;
      *) printf 'Pulse currently provides a macOS Apple Silicon release, not %s.\n' "$ARCH" >&2; exit 1 ;;
    esac
    ;;
  Linux)
    case "$ARCH" in
      x86_64|amd64) ASSET="pulse-linux-x86_64.tar.gz" ;;
      *) printf 'Pulse currently provides a Linux x86_64 release, not %s.\n' "$ARCH" >&2; exit 1 ;;
    esac
    ;;
  *)
    printf 'Unsupported operating system: %s\n' "$OS" >&2
    exit 1
    ;;
esac

printf 'Downloading %s...\n' "$ASSET"
curl --fail --location --silent --show-error "$RELEASE_URL/$ASSET" -o "$TMP_DIR/$ASSET"
tar -xzf "$TMP_DIR/$ASSET" -C "$TMP_DIR" pulse
test -f "$TMP_DIR/pulse" || { printf 'Archive did not contain pulse at its root.\n' >&2; exit 1; }

if [ "$OS" = Darwin ]; then
  sudo rm -f /usr/local/bin/pulse
  sudo mv "$TMP_DIR/pulse" /usr/local/bin/pulse
  sudo chmod +x /usr/local/bin/pulse
  sudo codesign --force --deep --sign - /usr/local/bin/pulse
else
  mkdir -p "$HOME/.local/bin"
  rm -f "$HOME/.local/bin/pulse"
  mv "$TMP_DIR/pulse" "$HOME/.local/bin/pulse"
  chmod +x "$HOME/.local/bin/pulse"
  case ":${PATH:-}:" in
    *":$HOME/.local/bin:"*) ;;
    *) printf 'Note: %s is not in your PATH. Add it with: export PATH="$HOME/.local/bin:$PATH"\n' "$HOME/.local/bin" ;;
  esac
fi

printf '\033[1;36m\n  PULSE installed successfully!\n  Run it with: pulse\n\033[0m'
