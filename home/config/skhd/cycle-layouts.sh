#!/bin/sh

layout=$(yabai -m query --spaces --space | jq '.type')

case "$layout" in
*"bsp"*)
  yabai -m space --layout stack
  ;;
*"stack"*)
  yabai -m space --layout float
  ;;
*"float"*)
  yabai -m space --layout bsp
  ;;
esac
