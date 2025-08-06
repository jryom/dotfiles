#!/usr/bin/env bash
SCRIPT_PATH="$HOME/.config/scripts/manage-prevent-sleep.sh"
SYMBOL="☕"

print_menu() {
  local rem="$1" end="$2"
  local mins=$(((rem+59)/60))
  if [ "$mins" -ge 60 ]; then
    local h=$((mins/60)) m=$((mins%60))
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
[ "$st" = disabled ] && { exit 0; }

parse_status "$st"
[[ "$rem" =~ ^[0-9]+$ ]] && [[ "$end" =~ ^[0-9]+$ ]] || { exit 0; }

[ "$rem" -le 0 ] && { "$SCRIPT_PATH" disable >/dev/null 2>&1 & exit 0; }

print_menu "$rem" "$end"

if [ "$1" = extend ] && [[ "$2" =~ ^[0-9]+$ ]]; then
  new=$(( end + $2*60 ))
  if [ -x "$SCRIPT_PATH" ]; then
    now=$(date +%s)
    mins=$(( (new - now + 59)/60 ))
    "$SCRIPT_PATH" "$mins" >/dev/null 2>&1 || true
  else
    pkill -f "caffeinate -i -t" >/dev/null 2>&1 || true
    dur=$(( new - $(date +%s) ))
    if [ "$dur" -gt 0 ]; then
      caffeinate -i -t "$dur" & echo "$new" > /tmp/prevent-sleep.state
    fi
  fi
fi
