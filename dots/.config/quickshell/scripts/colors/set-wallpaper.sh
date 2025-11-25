#!/usr/bin/env bash

STATE="$HOME/.local/state/m3"
CONF="$HOME/.config"
M3_COLORS_JSON="$STATE/colors/m3-colors.json"
M3_COLORS_SCSS="$STATE/colors/m3-colors.scss"
TERM_COLORS="$STATE/colors/terminal-colors.json"
TERM_BASE_COLORS="$STATE/colors/base-terminal-colors.json"
TOKENS="$STATE/tokens.conf"
HYPR_TEMPLATE="$STATE/templates/hyprland/colors.conf"
HYPR_OUT="$CONF/hypr/src/colors.conf"
GTK3_TEMPLATE="$STATE/templates/gtk-3.0/colors.css"
GTK3_OUT="$CONF/gtk-3.0/colors.css"
GTK4_TEMPLATE="$STATE/templates/gtk-4.0/colors.css"
GTK4_OUT="$CONF/gtk-4.0/colors.css"
ZED_TEMPLATE="$STATE/templates/zed/colors.json"
ZED_OUT="$CONF/zed/themes/m3-colors.json"
NVIM_TEMPLATE="$STATE/templates/nvim/colors.lua"
NVIM_OUT="$CONF/nvim/lua/themes/m3-colors.lua"
KITTY_OUT="$CONF/kitty/m3-colors.conf"
COLOR_SCRIPT="$CONF/quickshell/scripts/colors/get-colors.py"
CURRENT_WALLPAPER="$(grep '^curr_wallpaper=' "$TOKENS" | cut -d '=' -f2-)"
INTERVAL="$(grep '^interval=' "$TOKENS" | cut -d '=' -f2-)"
M3_SCHEME="$(grep '^scheme=' "$TOKENS" | cut -d '=' -f2-)"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

get_light_dark() {
  current_mode=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")
  if [[ "$current_mode" == "prefer-dark" ]]; then
    echo "dark"
  else
    echo "light"
  fi
}

parse_template() {
  local template="$1"
  local output="$2"
  local content regex key field raw value

  content=$(cat "$template")
  regex='\{\{colors\.([a-zA-Z0-9_]+)\.(hex|hex_stripped)\}\}'

  while [[ "$content" =~ $regex ]]; do
    key="${BASH_REMATCH[1]}"
    field="${BASH_REMATCH[2]}"

    raw=$(jq -r --arg k "$key" '.[$k]' "$M3_COLORS_JSON")
    [[ "$raw" == "null" ]] && raw=""

    if [[ "$field" == "hex" ]]; then
      value="$raw"
    else
      value="${raw#\#}"
    fi

    content="${content//\{\{colors.$key.$field\}\}/$value}"
  done

  echo "$content" >"$output"
}

generate_colors() {
  local wp="$1"
  local mode="$2"

  python3 "$COLOR_SCRIPT" \
    --path "$wp" \
    --m3_output "$M3_COLORS_JSON" \
    --term_base "$TERM_BASE_COLORS" \
    --term_output "$TERM_COLORS" \
    --scheme "$M3_SCHEME" \
    --mode "$mode"

  jq -r 'to_entries | .[] | "$" + .key + ": " + .value + ";"' "$M3_COLORS_JSON" >"$M3_COLORS_SCSS"
}

apply_theme_files() {
  parse_template "$HYPR_TEMPLATE" "$HYPR_OUT"
  parse_template "$GTK3_TEMPLATE" "$GTK3_OUT"
  parse_template "$GTK4_TEMPLATE" "$GTK4_OUT"
  parse_template "$ZED_TEMPLATE" "$ZED_OUT"
  parse_template "$NVIM_TEMPLATE" "$NVIM_OUT"

  jq -r 'to_entries | .[] | "\(.key) \(.value)"' "$TERM_COLORS" >"$KITTY_OUT"

  if pgrep -x kitty >/dev/null; then killall -SIGUSR1 kitty; fi
}

set_gtk_theme() {
  local mode="$1"
  local gtk3="$CONF/gtk-3.0/settings.ini"
  local gtk4="$CONF/gtk-4.0/settings.ini"

  if [[ "$mode" == "dark" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    sed -i 's/^gtk-theme-name=.*/gtk-theme-name=adw-gtk3-dark/' "$gtk3" "$gtk4"
    sed -i 's/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=1/' "$gtk3" "$gtk4"
  else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    sed -i 's/^gtk-theme-name=.*/gtk-theme-name=adw-gtk3/' "$gtk3" "$gtk4"
    sed -i 's/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=0/' "$gtk3" "$gtk4"
  fi
}

set_qt_theme() {
  local mode=$1
  if [ "$mode" = "light" ]; then
    cp "$HOME/Kvantum/Colloid/Colloid.kvconfig" "$HOME/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig"
    python "$HOME/.config/quickshell/scripts/colors/kvantum/adwsvg.py"

  else
    cp "$HOME/.config/Kvantum/Colloid/ColloidDark.kvconfig" "$HOME/.config/Kvantum/MaterialAdw/MaterialAdw.kvconfig"
    python "$HOME/.config/quickshell/scripts/colors/kvantum/adwsvgDark.py"
  fi
  python "$HOME/.config/quickshell/scripts/colors/kvantum/changeAdwColors.py"
}

save_wallpaper() {
  local wp="$1"
  sed -i "s|^curr_wallpaper=.*|curr_wallpaper=$wp|" "$TOKENS"
  CURRENT_WALLPAPER="$wp"
}

set_wallpaper() {
  local wp="$1"
  local mode
  mode="$(get_light_dark)"

  generate_colors "$wp" "$mode"
  apply_theme_files
  save_wallpaper "$wp"
  swww img "$wp"
  set_gtk_theme "$mode"
  set_qt_theme "$mode"
}

toggle_mode() {
  local current new
  current="$(get_light_dark)"

  if [[ "$current" == "dark" ]]; then
    new="light"
  else
    new="dark"
  fi

  generate_colors "$CURRENT_WALLPAPER" "$new"
  apply_theme_files
  set_gtk_theme "$new"
  set_qt_theme "$new"

}

slideshow() {
  while true; do
    sleep "$INTERVAL"

    local wp
    wp=$(find "$WALLPAPER_DIR" -type f -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" |
      grep -vx "$CURRENT_WALLPAPER" | shuf -n 1)

    set_wallpaper "$wp"
  done
}

case "$1" in
--set-wallpaper)
  if [[ -n "$2" ]]; then
    set_wallpaper "$2"
  else
    wp=$(find "$WALLPAPER_DIR" -type f -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" |
      grep -vx "$CURRENT_WALLPAPER" | shuf -n 1)
    set_wallpaper "$wp"
  fi
  ;;

--toggle-mode)
  toggle_mode
  ;;

--slideshow)
  slideshow
  ;;

*)
  echo "Usage:"
  echo "  $0 --set-wallpaper [file]"
  echo "  $0 --toggle-mode"
  echo "  $0 --slideshow"
  exit 1
  ;;
esac
