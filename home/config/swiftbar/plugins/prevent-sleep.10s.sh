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

if ! st=$("$SCRIPT_PATH" status 2>/dev/null); then
  exit 0
fi

read -r rem end <<<"$st"
rem=${rem#remaining=}
end=${end#end=}
[[ "$rem" =~ ^[0-9]+$ ]] && [[ "$end" =~ ^[0-9]+$ ]] || { exit 0; }

jiggle_if_idle

print_menu "$rem" "$end"
