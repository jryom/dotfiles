#!/bin/zsh

spaces=$(yabai -m query --spaces --display)
multiplespaces=$(echo "$spaces" | jq -re 'map(select(."native-fullscreen" == 0)) | length > 1')

if [[ "$multiplespaces" = "true" ]]; then
  destroyable=$(echo "$spaces" | jq -re 'map(select(."windows" == [] and ."visible" == 0)) | .[] | .index ')
  if [[ "$destroyable" != "" ]]; then
    yabai -m space "$destroyable" --destroy
  fi
fi
