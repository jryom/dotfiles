#!/bin/sh
set -eu

display=$(rift-cli query displays | jq -er '.[] | select(.is_active_context) | .uuid')
current=$(rift-cli query workspace-layout --display "$display" | jq -er '.[] | select(.is_active) | .layout_mode')
case "$current" in
  bsp) next=stack ;;
  stack) next=master_stack ;;
  master_stack) next=scrolling ;;
  scrolling) next=traditional ;;
  traditional) next=floating ;;
  *) next=bsp ;;
esac

rift-cli execute workspace set-layout "$next"
terminal-notifier -group rift-layout -title "Rift Layout" -message "$next"
