#!/usr/bin/env bash

STATE_FILE="/tmp/prevent-sleep.state"
IDLE_THRESHOLD_SECONDS=60
INVALID_INPUT_MSG="Invalid input. Enter HH:MM or minutes."

now_epoch() { date +%s; }

format_epoch_hhmm() { date -r "$1" +%H:%M; }

notify() { terminal-notifier -title "Prevent Sleep" -message "$1" -group "prevent-sleep"; }

disable() {
  pkill -f "caffeinate -i -t" >/dev/null 2>&1 || true
  rm -f "$STATE_FILE"
  notify "Disabled"
  exit 0
}

parse_input_to_epoch() {
  local input="$1" now epoch
  if [[ "$input" =~ ^[0-9]+$ ]] && [ "$input" -gt 0 ]; then
    now=$(now_epoch)
    epoch=$((now + input * 60))
  elif [[ "$input" =~ ^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ ]]; then
    local today
    today=$(date +%F)
    epoch=$(date -j -f "%Y-%m-%d %H:%M" "$today $input" +%s 2>/dev/null) || {
      notify "$INVALID_INPUT_MSG"
      return 1
    }
    now=$(now_epoch)
    if [ "$epoch" -le "$now" ]; then
      epoch=$(date -j -f "%Y-%m-%d %H:%M" "$(date -v+1d +%F) $input" +%s)
    fi
  else
    notify "$INVALID_INPUT_MSG"
    return 1
  fi
  printf '%s\n' "$epoch"
}

start_prevent_sleep_until_epoch() {
  local epoch="$1" now
  now=$(now_epoch)
  [ "$epoch" -gt "$now" ] || {
    notify "Time already passed."
    return 1
  }
  pkill -f "caffeinate -i -t" >/dev/null 2>&1 || true
  caffeinate -i -t "$((epoch - now))" &
  printf '%s\n' "$epoch" >"$STATE_FILE"
  notify "Enabled until $(format_epoch_hhmm "$epoch")"
}

if [ "$1" = "toggle" ]; then
  time_input=$(osascript -e 'display dialog "Enter time (HH:MM or minutes; empty disables):" default answer ""' -e 'text returned of result' 2>/dev/null) || disable
  [ -z "$time_input" ] && disable
  epoch=$(parse_input_to_epoch "$time_input") || disable
  start_prevent_sleep_until_epoch "$epoch" || disable
  exit 0
fi

[ -f "$STATE_FILE" ] && ioreg -n Root -d1 | grep -m1 -q 'CGSSessionScreenIsLocked' && disable

end_time=$(cat "$STATE_FILE" 2>/dev/null)
[[ "$end_time" =~ ^[0-9]+$ ]] || exit 0

[ "$(date +%s)" -gt "$end_time" ] && disable

idle_time_s=$(($(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print $NF; exit}') / 1000000000))
[ "$idle_time_s" -gt "$IDLE_THRESHOLD_SECONDS" ] && osascript -e 'tell application "System Events" to key code 113'
