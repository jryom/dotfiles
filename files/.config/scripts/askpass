#!/usr/bin/env bash

read -r -d '' applescriptCode <<'EOF'
   set dialogText to text returned of (display dialog "Enter root password for brew cask upgrades" default answer "" with icon stop with hidden answer)
   return dialogText
EOF

osascript -e "$applescriptCode"
