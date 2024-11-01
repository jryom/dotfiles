#!/usr/bin/env dash

yabai -m query --spaces |
  jq -re 'map(select(."is-native-fullscreen" == false and ."first-window" == 0 and ."last-window" == 0 and ."is-visible" == false) | .index) | reverse | join("\n")' |
  xargs -I % dash -c 'yabai -m space "%" --destroy'
