#!/usr/bin/env dash

yabai -m query --spaces |
  jq -re 'map(select(."is-native-fullscreen" == false and ."windows" == [] and ."is-visible" == false) | .index) | reverse | join("\n")' |
  xargs -I % dash -c 'yabai -m space "%" --destroy'
