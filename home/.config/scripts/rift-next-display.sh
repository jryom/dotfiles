#!/bin/sh
set -eu

target=$(rift-cli query displays | jq -r --arg action "$1" 'map(.uuid) as $ids | (map(.is_active_context) | index(true)) as $current | if $current == null or ($ids | length) < 2 then empty elif $current + 1 < ($ids | length) then $ids[$current + 1] elif $action == "focus" then $ids[0] else empty end')
[ -n "$target" ] || exit 0

focus_target() {
  window=$(rift-cli query workspaces --display "$target" | jq -c '.[] | select(.is_active) | .windows | (map(select(.is_focused)) + .)[0].id // empty')
  [ -n "$window" ] || return 0
  rift-cli execute window focus --window-id "$window"
}

case "$1" in
  focus)
    focus_target
    ;;
  window)
    window=$(rift-cli query workspaces | jq -c '.[] | select(.is_active) | .windows[] | select(.is_focused) | .id')
    rift-cli execute display move-window --uuid "$target"
    if [ -n "$window" ]; then
      rift-cli execute window focus --window-id "$window"
    fi
    ;;
  workspace)
    rift-cli execute display move-workspace --uuid "$target"
    focus_target
    ;;
esac
