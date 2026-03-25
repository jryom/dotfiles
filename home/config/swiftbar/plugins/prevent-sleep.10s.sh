#!/usr/bin/env bash
SCRIPT_PATH="$HOME/.config/scripts/manage-prevent-sleep.sh"
JIGGLE_PATH="$HOME/.config/scripts/mouse-jiggle.swift"
SYMBOL="☕"
IDLE_THRESHOLD=60

jiggle_if_idle() {
  local ns idle
  ns=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print $NF; exit}')
  idle=$((ns / 1000000000))
  [ "$idle" -gt "$IDLE_THRESHOLD" ] && swift "$JIGGLE_PATH" >/dev/null 2>&1 &
}

print_menu() {
  local rem="$1" end="$2"
  local mins=$(((rem + 59) / 60))
  if [ "$mins" -ge 60 ]; then
    local h=$((mins / 60)) m=$((mins % 60))
    echo "$SYMBOL ${h}h ${m}m"
  else
    echo "$SYMBOL ${mins}m"
  fi
  echo "---"
  echo "Until: $(date -r "$end" +%H:%M)"
}

parse_status() {
  local st="$1"
  rem=$(echo "$st" | awk -F '[ =]' '{for(i=1;i<=NF;i++){if($i~"remaining"){print $(i+1);exit}}}')
  end=$(echo "$st" | awk -F '[ =]' '{for(i=1;i<=NF;i++){if($i~"end"){print $(i+1);exit}}}')
}

if ! st=$("$SCRIPT_PATH" status 2>/dev/null); then
  exit 0
fi
[ "$st" = disabled ] && exit 0

parse_status "$st"
[[ "$rem" =~ ^[0-9]+$ ]] && [[ "$end" =~ ^[0-9]+$ ]] || { exit 0; }

[ "$rem" -le 0 ] && {
  "$SCRIPT_PATH" disable >/dev/null 2>&1 &
  exit 0
}

jiggle_if_idle

print_menu "$rem" "$end"
