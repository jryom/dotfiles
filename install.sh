#!/bin/bash

trap 'ret=$?; test $ret -ne 0 && printf "Failed!\n" >&2; exit $ret' EXIT
set -e

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

source "$script_path/zsh/env.zsh"

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.finder _FXSortFoldersFirst -bool YES
defaults write com.apple.finder CreateDesktop 0
defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
killall Dock

# Disable Gatekeeper if active
if spctl --status > /dev/null; then
  echo "Gatekeeper enabled, enter password to disable..."
  sudo spctl --master-disable
  echo "Gatekeeper disabled."
fi

echo -n "Checking command line tools installation..."
if ! type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}"; then
   echo " Not installed. Install and run script again."
   xcode-select --install
   EXIT
fi
echo " OK!"

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew..."
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
  export PATH="/usr/local/bin:$PATH"
fi

echo -n "Looking for missing brew packages... "
if ! brew bundle check --file="$script_path/Brewfile" >/dev/null; then
  echo "Dependencies missing! Brewing..."
  brew bundle install --file="$script_path/Brewfile" --force --no-lock
  if [ ! -f /private/etc/sudoers.d/yabai  ]; then
    echo "Adding yabai to sudoers..."
    sudo zsh -c "echo '$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa' >> /private/etc/sudoers.d/yabai"
  fi
fi
echo "Done!"

echo -n "Installing fzf... "
echo y | $(brew --prefix)/opt/fzf/install
echo "Done!"

echo -n "Installing pip packages... "
python3 -m pip install --user --upgrade $(cat "$script_path/pip-packages" | tr '\n' ' ')
echo "Done!"

echo -n "Symlinking files... "
sudo python3 -m dotbot -c "$script_path/install.conf.yaml"
echo "Done!"

echo -n "Installing node... "
eval "$(fnm env)"
fnm install --lts && fnm use lts-latest && fnm default lts-latest

echo -n "Installing global NPM packages... "
npm install --loglevel silent --no-progress -g \
  $(cat "$script_path/npm-global-packages" | tr '\n' ' ')
echo "Done!"

! [[ "$( which zsh )" = "/usr/local/bin/zsh" ]] && sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

for f in $(zsh -i -c compaudit)
do
  sudo chmod -R 755 $f
done

antibody bundle < "$script_path/zsh/zsh_plugins" > ~/.zsh_plugins

loginitems -a "Bartender 3"
loginitems -a "Itsycal"
loginitems -a "SpaceId"

brew services start koekeishiya/formulae/yabai
brew services start koekeishiya/formulae/skhd

echo "Installation finished!"
