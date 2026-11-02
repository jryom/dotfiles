#!/bin/sh
set -eu

target=$(rift-cli query displays | jq -r 'map(.uuid) as $ids | (map(.is_active_context) | index(true)) as $current | if $current == null or ($ids | length) < 2 then empty else $ids[($current + 1) % ($ids | length)] end')
[ -n "$target" ] || exit 0

window=$(rift-cli query workspaces | jq -c '.[] | select(.is_active) | .windows[] | select(.is_focused) | .id')
[ -n "$window" ] || exit 0
rift-cli execute display move-window --uuid "$target" --window-id "$(printf '%s\n' "$window" | jq -r '.idx')"
rift-cli execute window focus --window-id "$window"
