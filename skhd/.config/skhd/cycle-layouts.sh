#!/usr/bin/env bash

layout=$(yabai -m query --spaces --space | jq '.type')

if [[ $layout == *"bsp"* ]]; then
  yabai -m space --layout stack
elif [[ $layout == *"stack"* ]]; then
  yabai -m space --layout float
else
  yabai -m space --layout bsp
fi
