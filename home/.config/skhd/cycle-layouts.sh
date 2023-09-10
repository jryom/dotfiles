#!/bin/sh

layout=$(yabai -m query --spaces --space | jq '.type')

case "$layout" in
  *"float"*)
    yabai -m space --layout stack
    ;;
  *"stack"*)
    yabai -m space --layout bsp
    ;;
  *)
    yabai -m space --layout float
    ;;
esac
