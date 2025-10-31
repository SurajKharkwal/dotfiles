#!/usr/bin/env bash

while true; do
  query=$(hyprctl -j monitors)
  eval $(hyprctl -j cursorpos | jq -r '"X=\(.x)\nY=\(.y)"')

  # Find which monitor the cursor is currently on
  ACTIVE_MONITOR=$(echo "$query" | jq -r --argjson X "$X" --argjson Y "$Y" '
    .[] | select($X >= .x and $X < (.x + .width) and $Y >= .y and $Y < (.y + .height))
  ')

  # If no monitor matched (rare), skip
  if [ -z "$ACTIVE_MONITOR" ]; then
    sleep 0.1
    continue
  fi

  # Extract monitor details
  ACTIVE_MONITOR_NAME=$(echo "$ACTIVE_MONITOR" | jq -r '.name')
  ACTIVE_MONITOR_WIDTH=$(echo "$ACTIVE_MONITOR" | jq -r '.width')
  ACTIVE_MONITOR_HEIGHT=$(echo "$ACTIVE_MONITOR" | jq -r '.height')
  ACTIVE_MONITOR_ID=$(echo "$ACTIVE_MONITOR" | jq -r '.id')
  ACTIVE_MONITOR_X=$(echo "$ACTIVE_MONITOR" | jq -r '.x')
  ACTIVE_MONITOR_Y=$(echo "$ACTIVE_MONITOR" | jq -r '.y')

  # Define regions
  BAR_WIDTH=800
  BAR_HEIGHT=100
  SYSOSD_WIDTH=232
  SYSOSD_HEIGHT=300

  BAR_X_MAX=$(($ACTIVE_MONITOR_X + $ACTIVE_MONITOR_WIDTH/2 + $BAR_WIDTH/2))
  BAR_X_MIN=$(($ACTIVE_MONITOR_X + $ACTIVE_MONITOR_WIDTH/2 - $BAR_WIDTH/2))
  BAR_Y_MAX=$(($ACTIVE_MONITOR_Y + $BAR_HEIGHT))
  BAR_Y_MIN=$(($ACTIVE_MONITOR_Y))

  SYSOSD_X_MIN=$(($ACTIVE_MONITOR_X + $ACTIVE_MONITOR_WIDTH - $SYSOSD_WIDTH))
  SYSOSD_X_MAX=$(($ACTIVE_MONITOR_X + $ACTIVE_MONITOR_WIDTH))
  SYSOSD_Y_CENTER=$(($ACTIVE_MONITOR_Y + $ACTIVE_MONITOR_HEIGHT/2))
  SYSOSD_Y_MIN=$(($SYSOSD_Y_CENTER - $SYSOSD_HEIGHT/2))
  SYSOSD_Y_MAX=$(($SYSOSD_Y_CENTER + $SYSOSD_HEIGHT/2))

  # --- Bar logic ---
  if [[ $Y -le $(($ACTIVE_MONITOR_Y + 1)) && $X -le $BAR_X_MAX && $X -ge $BAR_X_MIN ]]; then
    echo "expand bar"
    qs ipc call bar expand "$ACTIVE_MONITOR_ID"
  elif [[ $Y -ge $BAR_Y_MAX || $X -ge $BAR_X_MAX || $X -le $BAR_X_MIN ]]; then
    echo "collapse bar"
    qs ipc call bar collapse "$ACTIVE_MONITOR_ID"
  fi

  # --- OSD logic ---
  if [[ $X -ge $(($ACTIVE_MONITOR_X + $ACTIVE_MONITOR_WIDTH - 2)) && \
        $Y -le $SYSOSD_Y_MAX && $Y -ge $SYSOSD_Y_MIN ]]; then
    echo "expand osd"
    qs ipc call osd expand "$ACTIVE_MONITOR_ID"
  fi

  # clear
  # echo "Active Monitor: $ACTIVE_MONITOR_NAME"
  # echo "Monitor Pos: X=$ACTIVE_MONITOR_X Y=$ACTIVE_MONITOR_Y"
  # echo "Monitor Size: ${ACTIVE_MONITOR_WIDTH}x${ACTIVE_MONITOR_HEIGHT}"
  # echo "Monitor ID: $ACTIVE_MONITOR_ID"
  # echo "Cursor: X=$X Y=$Y"
  # echo "Bar X Range: $BAR_X_MIN - $BAR_X_MAX"
  # echo "Bar Y Range: $BAR_Y_MIN - $BAR_Y_MAX"
  # echo "SysOSD X Range: $SYSOSD_X_MIN - $SYSOSD_X_MAX"
  # echo "SysOSD Y Range: $SYSOSD_Y_MIN - $SYSOSD_Y_MAX"
  #
  sleep 0.05
done
