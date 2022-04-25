#!/usr/bin/env bash

# Disable Gatekeeper if active
if spctl --status >/dev/null; then
  sudo spctl --master-disable
fi

# Change some macOS default settings and restart dock
defaults write -g AppleSpacesSwitchOnActivate -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.finder CreateDesktop 0
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool YES
defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
killall Dock

if ! type xcode-select >&- &&
  XPATH="$(xcode-select --print-path)" &&
  test -d "$XPATH" && test -x "$XPATH"; then
  echo "Command line tools not installed. Install and run script again."
  xcode-select --install
  exit
fi

# Use touchID for sudo permission
cat /etc/pam.d/sudo | grep "pam_tid.so" || sudo gsed -i '3 i auth       sufficient     pam_tid.so' /etc/pam.d/sudo

# Install custom keyboard layout and CLI tool
cp -r "$DOT_DIR/bin/da-no-dead-keys.bundle" "$HOME/Library/Keyboard Layouts"
sudo ln -sf "$DOT_DIR/bin/keyboardSwitcher" "/usr/local/bin/keyboardSwitcher"
