#!/usr/bin/env bash

STATE="$HOME/.local/state/m3"
COLOR_SCRIPT="$HOME/.config/quickshell/scripts/get-colors.py"
KITTY_OUT="$HOME/.config/kitty/m3-colors.conf"
M3_COLORS_JSON="$STATE/colors/m3-colors.json"
TERM_BASE_COLORS="$STATE/colors/base-terminal-colors.json"
TERM_COLORS="$STATE/colors/terminal-colors.json"
M3_SCHEME="scheme-neutral"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

get_light_dark_mode() {
  gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | grep -q 'dark' &&
    echo "dark" ||
    echo "light"
}

set_wallpaper() {
  set_wall="$1"
  swww img "$set_wall" --transition-type grow --transition-duration 1
  gen_colors "$set_wall"
}

gen_colors() {
  img="$1"
  mode=$(get_light_dark_mode)

  matugen image "$img" --mode "$mode"

  python3 "$COLOR_SCRIPT" \
    --path "$img" \
    --m3_output "$M3_COLORS_JSON" \
    --term_base "$TERM_BASE_COLORS" \
    --term_output "$TERM_COLORS" \
    --scheme "$M3_SCHEME" \
    --mode "$mode"

  jq -r 'to_entries | .[] | "\(.key) \(.value)"' "$TERM_COLORS" >"$KITTY_OUT"
  if pgrep -x kitty >/dev/null; then killall -SIGUSR1 kitty; fi

}

slideshow() {
  interval="$2"

  while true; do
    for img in "$WALLPAPER_DIR"/*; do
      set_wallpaper "$img"
      sleep "$interval"
    done
  done
}

toggle_theme() {
  mode=$(get_light_dark_mode)

  if [ "$mode" = "dark" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi

  # use last used wallpaper
  last_wall=$(ls -t "$WALLPAPER_DIR"/* | head -n1)
  gen_colors "$last_wall"
}

case "$1" in
wallpaper)
  set_wallpaper "$2"
  ;;
slideshow)
  slideshow "$2" "$3"
  ;;
toggle)
  toggle_theme
  ;;
*)
  echo "usage: $0 {wallpaper <file>|slideshow <sec>|toggle}"
  exit 1
  ;;
esac
