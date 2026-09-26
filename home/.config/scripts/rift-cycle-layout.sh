#!/bin/sh
set -eu

current=$(rift-cli query workspace-layout | jq -er '.[] | select(.is_active) | .layout_mode')
case "$current" in
  bsp) next=stack ;;
  *) next=bsp ;;
esac

rift-cli execute workspace set-layout "$next"
