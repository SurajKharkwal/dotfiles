#!/usr/bin/env bash

APP_PATH1="/usr/share/applications"
APP_PATH2="$HOME/.local/share/applications"

resolve_icon() {
    local icon="$1"

    [[ "$icon" == /* ]] && { echo "$icon"; return; }

    local path
    path=$(xdg-icon-resource lookup "$icon" 2>/dev/null)
    if [[ -n "$path" ]]; then
        echo "$path"
        return
    fi

    local candidates=(
        "$HOME/.icons"
        "$HOME/.local/share/icons"
        "/usr/local/share/icons"
        "/usr/share/icons"
        "/usr/share/pixmaps"
    )

    for dir in "${candidates[@]}"; do
        [[ -d "$dir" ]] || continue

        local match
        match=$(find "$dir" -type f \( -name "$icon.png" -o -name "$icon.svg" -o -name "$icon.xpm" \) 2>/dev/null | head -n1)
        if [[ -n "$match" ]]; then
            echo "$match"
            return
        fi
    done

    echo "$icon"
}

find "$APP_PATH1" "$APP_PATH2" -type f -name "*.desktop" | while read -r desktop; do
    name=$(grep -m1 '^Name=' "$desktop" | cut -d'=' -f2-)
    icon=$(grep -m1 '^Icon=' "$desktop" | cut -d'=' -f2-)
    exec=$(grep -m1 '^Exec=' "$desktop" | cut -d'=' -f2- | sed 's/%[UuFf]//g' | sed 's/[[:space:]]*$//')
    comment=$(grep -m1 '^Comment=' "$desktop" | cut -d'=' -f2-)

    icon=$(resolve_icon "$icon")

    printf '%s#%s#%s#%s\n' "$name" "$icon" "$exec" "$comment"
done
