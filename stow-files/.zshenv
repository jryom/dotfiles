#!/usr/bin/env zsh

export updateScreenHeight() {
  system_profiler SPDisplaysDataType | grep Resolution | awk '{print $4}' > /tmp/screen_height
  cat /tmp/screen_height
}

export \
  PATH=/opt/homebrew/bin:$PATH \
  KITTY_THEME_DARK="zenbones-dark" \
  KITTY_THEME_LIGHT="zenbones-light" \
  WM_SPACING=$(($(cat /tmp/screen_height || updateScreenHeight)/120)) \
  WM_OPACITY=0.75

