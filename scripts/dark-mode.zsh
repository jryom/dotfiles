#!/bin/zsh
PATH="/usr/local/bin:$PATH"

isDark=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
isDaylight=$(/usr/libexec/corebrightnessdiag nightshift-internal | grep isDaylight | grep -Eo '[[:digit:]]')

if (( isDaylight == 0 && isDark == 0 )); then
   osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
   kittyColors "$THEME_DARK"
elif (( isDaylight == 1 && isDark == 1 )); then
   osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
   kittyColors "$THEME_LIGHT"
fi
