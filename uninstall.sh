#!/usr/bin/env bash
set -euo pipefail

rm -f "$HOME/.local/bin/pulse"
rm -f "$HOME/.cargo/bin/pulse"
if [ -e /usr/local/bin/pulse ]; then
  if [ -w /usr/local/bin/pulse ] || [ -w /usr/local/bin ]; then
    rm -f /usr/local/bin/pulse
  else
    sudo rm -f /usr/local/bin/pulse
  fi
fi

printf 'Removed the Pulse binary if it was installed in a standard location.\n'

answer=""
if [ -r /dev/tty ]; then
  printf 'Remove Pulse configuration and data in ~/.pulse and ~/.config/pulse? [y/N] ' >/dev/tty
  if ! IFS= read -r answer </dev/tty; then
    answer=""
  fi
else
  printf 'No interactive terminal; keeping Pulse configuration and data.\n'
fi
case "$answer" in
  y|Y|yes|YES)
    rm -rf "$HOME/.pulse" "$HOME/.config/pulse"
    printf 'Removed Pulse configuration and data.\n'
    ;;
  *)
    printf 'Kept Pulse configuration and data.\n'
    ;;
esac

printf 'Pulse uninstallation complete.\n'
