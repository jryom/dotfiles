#!/bin/zsh
PATH="/usr/local/bin:$PATH"

isDark=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
riseUTC=$(/usr/libexec/corebrightnessdiag nightshift-internal | grep sunrise | grep -o '".*"' | sed 's/"//g')
setUTC=$(/usr/libexec/corebrightnessdiag nightshift-internal| grep sunset | grep -o '".*"' | sed 's/"//g')
riseLocal=$(gdate --date "$riseUTC"  +"%H%M")
setLocal=$(gdate --date "$setUTC"  +"%H%M")
now=$(gdate +"%H%M")

(( now > riseLocal && now < setLocal )) && isDaylight=1 || isDaylight=0

if (( isDaylight == 0 && isDark == 0 )); then
   osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
   kittyColors "$THEME_DARK"
elif (( isDaylight == 1 && isDark == 1 )); then
   osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
   kittyColors "$THEME_LIGHT"
fi
