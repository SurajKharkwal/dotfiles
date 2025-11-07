#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
MATERIAL_COLOR_JSON="$HOME/.config/quickshell/colors/material-colors.json"
KITTY_COLOR_CONF="$HOME/.config/kitty/material_colors.conf"
TEMP_TERMINAL_JSON="/tmp/terminal-colors.json"
COLOR_EXTRACT_SCRIPT="$HOME/.config/quickshell/scripts/get-colors.py"
BASE_TERMINAL_SCHEME="$HOME/.config/quickshell/colors/terminal-base.json"
CHANGE_INTERVAL="30m"

CURRENT_WALLPAPER=$(swww query | grep -oP 'image: \K.*' || true)

set_wallpaper() {
  local wallpaper="$1"

  swww img "$wallpaper" --transition-type any

  python3 "$COLOR_EXTRACT_SCRIPT" \
    --path "$wallpaper" \
    --material "$MATERIAL_COLOR_JSON" \
    --termscheme "$BASE_TERMINAL_SCHEME" \
    --terminal "$TEMP_TERMINAL_JSON"

  jq -r 'to_entries | .[] | "\(.key) \(.value)"' "$TEMP_TERMINAL_JSON" >"$KITTY_COLOR_CONF"

  killall -SIGUSR1 kitty

  CURRENT_WALLPAPER="$wallpaper"
}

slideshow() {
  while true; do
    NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
    set_wallpaper "$NEW_WALLPAPER"
    sleep "$CHANGE_INTERVAL"
  done
}

usage() {
  echo "Usage:"
  echo "  $0 --set <image-file>"
  echo "  $0 --slideshow"
  exit 1
}

# Argument parsing
case "$1" in
  --set)
    [[ -z "$2" ]] && usage
    set_wallpaper "$2"
    ;;
  --slideshow)
    slideshow
    ;;
  *)
    usage
    ;;
esac
