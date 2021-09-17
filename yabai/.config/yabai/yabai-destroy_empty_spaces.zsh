#!/usr/bin/env zsh

yabai -m query --spaces | \
  jq -re 'map(select(."native-fullscreen" == 0 and ."windows" == [] and ."visible" == 0) | .index) | reverse | join("\n")' | \
  xargs -I % sh -c 'yabai -m space "%" --destroy'
