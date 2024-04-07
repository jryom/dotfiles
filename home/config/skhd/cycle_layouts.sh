#!/usr/bin/env dash

layout=$(yabai -m query --spaces --space | jq -r '.type')

notify() {
  terminal-notifier -title "Yabai" -message "$1" -group "yabai"
  sleep 5
  terminal-notifier -remove "yabai"
}

if [ "$layout" = "bsp" ]; then
  yabai -m space --layout stack
  notify "stack"
elif [ "$layout" = "stack" ]; then
  yabai -m space --layout float
  notify "float"
elif [ "$layout" = "float" ]; then
  yabai -m space --layout bsp
  notify "bsp"
fi
