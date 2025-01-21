#!/bin/bash

USER_INPUT=$1
WALLPAPER_DIR=~/Wallpapers/
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))
ANIMATION_TYPES=("simple" "fade" "left" "right" "top" "bottom" "wipe" "grow" "center" "outer" "random" "wave")
HYPRLOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"

WallpaperSlideshow() {
  while true; do
    WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
    random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)
    swww img "$WALLPAPER" --transition-type "$random_animation" --transition-duration 1
    sleep 1200
  done
}

RandWallpaper() {
  WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
  random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)
  swww img "$WALLPAPER" --transition-type "$random_animation" --transition-duration 1
}

WallpaperSelector() {
  current_wallpaper_name=$(basename "$(swww query)")

  # Style and directory for Rofi theme

  # Generate the Rofi menu with icons
  rofi_list=""
  while IFS= read -r a; do
    filename=$(basename "$a")
    if [[ "$filename" == "$current_wallpaper_name" ]]; then
      rofi_list+="${filename} (current)\0icon\x1f$a\n"
    else
      rofi_list+="${filename}\0icon\x1f$a\n"
    fi
  done <<<"$WALLPAPERS"

  selected_wallpaper=$(echo -e "$rofi_list" | rofi -dmenu -p "Select Wallpaper:" -theme "/home/flyinghawk/.config/hypr//wallpaper.rasi" -markup-rows)

  # Check if a wallpaper was chosen
  if [[ -n "$selected_wallpaper" ]]; then
    final_wallpaper=$(echo "$selected_wallpaper" | sed "s/ (current)//")
    random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)
    swww img "$WALLPAPER_DIR/$final_wallpaper" --transition-type "$random_animation" --transition-duration 1
  fi
}

hyprlockWallpaper() {
  WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
  sed -i "s|^ *path *=.*|path = $WALLPAPER |" "$HYPRLOCK_CONFIG"
}

case $USER_INPUT in
  slideshow)
    WallpaperSlideshow
    ;;
  random)
    RandWallpaper
    ;;
  select)
    WallpaperSelector
    ;;
  hyprlock)
    hyprlockWallpaper
    ;;
  *)
    echo "Usage: $0 {slideshow|random|select|hyprlock}"
    ;;
esac
