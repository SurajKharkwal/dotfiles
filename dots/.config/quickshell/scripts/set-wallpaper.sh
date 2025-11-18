#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
MATERIAL_COLOR_JSON="$HOME/.config/quickshell/colors/material-colors.json"
KITTY_COLOR_CONF="$HOME/.config/kitty/material_colors.conf"
TEMP_TERMINAL_JSON="/tmp/terminal-colors.json"
COLOR_EXTRACT_SCRIPT="$HOME/.config/quickshell/scripts/get-colors.py"
BASE_TERMINAL_SCHEME="$HOME/.config/quickshell/colors/terminal-base.json"
CHANGE_INTERVAL="30m"

# Ensure required tools exist
for cmd in swww jq python3; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "Error: Required command '$cmd' not found." >&2
    exit 1
  }
done

# Get current wallpaper safely
CURRENT_WALLPAPER=$(swww query 2>/dev/null | grep -oP 'image: \K.*' || true)

set_wallpaper() {
  local wallpaper="$1"

  if [[ ! -f "$wallpaper" ]]; then
    echo "Error: Wallpaper '$wallpaper' not found." >&2
    exit 1
  fi

  echo "Setting wallpaper: $wallpaper"
  swww img "$wallpaper" --transition-type any || {
    echo "Error: Failed to set wallpaper with swww." >&2
    exit 1
  }

  python3 "$COLOR_EXTRACT_SCRIPT" \
    --path "$wallpaper" \
    --material "$MATERIAL_COLOR_JSON" \
    --termscheme "$BASE_TERMINAL_SCHEME" \
    --terminal "$TEMP_TERMINAL_JSON"

  jq -r 'to_entries | .[] | "\(.key) \(.value)"' "$TEMP_TERMINAL_JSON" >"$KITTY_COLOR_CONF"

  # Reload kitty colors if running
  if pgrep -x kitty >/dev/null; then
    killall -SIGUSR1 kitty
  fi

  CURRENT_WALLPAPER="$wallpaper"
}

slideshow() {
  trap 'echo "Slideshow terminated."; exit 0' SIGINT SIGTERM
  echo "Starting wallpaper slideshow. Interval: $CHANGE_INTERVAL"

  while true; do
    sleep "$CHANGE_INTERVAL"
    local new_wallpaper
    new_wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

    if [[ -z "$new_wallpaper" ]]; then
      echo "Error: No wallpapers found in $WALLPAPER_DIR" >&2
      exit 1
    fi

    set_wallpaper "$new_wallpaper"
  done
}

usage() {
  echo "Usage:"
  echo "  $0 --set <image-file>"
  echo "  $0 --slideshow"
  exit 1
}

# Argument parsing
case "${1:-}" in
  --set)
    [[ -z "${2:-}" ]] && usage
    set_wallpaper "$2"
    ;;
  --slideshow)
    slideshow
    ;;
  *)
    usage
    ;;
esac
