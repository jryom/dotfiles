#!/usr/bin/env zsh

set -o pipefail

export updateWMSpacing() {
  ( system_profiler SPDisplaysDataType | grep "Looks like" | awk '{print int($6/60)}' || \
    system_profiler SPDisplaysDataType | grep "Resolution" | awk '{print int($4/120)}' ) | > /tmp/screen_height
  cat /tmp/screen_height
}

export \
  PATH=/opt/homebrew/bin:$PATH \
  KITTY_THEME_DARK="zenbones-dark" \
  KITTY_THEME_LIGHT="zenbones-light" \
  WM_SPACING=$(cat /tmp/screen_height) \
  WM_OPACITY=0.8

