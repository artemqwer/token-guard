#!/usr/bin/env sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CONFIG=${XDG_CONFIG_HOME:-"$HOME/.config"}/opencode
DEST="$CONFIG/skills/token-guard"

mkdir -p "$CONFIG/skills"

if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  if [ "$(readlink -f "$DEST")" = "$ROOT" ]; then
    printf 'Token Guard is already installed.\n'
  else
    printf 'Destination already exists: %s\nMove it aside or install manually.\n' "$DEST" >&2
    exit 1
  fi
else
  ln -s "$ROOT" "$DEST"
  printf 'Installed Token Guard at %s\n' "$DEST"
fi

if [ "${1:-}" = "--auto" ]; then
  INSTRUCTIONS="$CONFIG/AGENTS.md"
  LINE='- For every nontrivial task (coding, debugging, research, configuration, or multiple steps), load and follow `token-guard` first. Simple stable answers need neither skills nor tools.'
  touch "$INSTRUCTIONS"
  if ! grep -Fqx -- "$LINE" "$INSTRUCTIONS"; then
    printf '\n%s\n' "$LINE" >> "$INSTRUCTIONS"
    printf 'Enabled automatic activation in %s\n' "$INSTRUCTIONS"
  fi
elif [ "$#" -gt 0 ]; then
  printf 'Unknown option: %s\nUsage: ./install.sh [--auto]\n' "$1" >&2
  exit 2
fi
