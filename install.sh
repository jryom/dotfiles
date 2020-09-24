#!/bin/bash
trap 'ret=$?; test $ret -ne 0 && printf "Failed!\n" >&2; exit $ret' EXIT
set -e

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
defaults write com.apple.finder _FXSortFoldersFirst -bool YES
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
if ! brew bundle check --file="$script_path/brewfile" >/dev/null; then
  echo "Dependencies missing! Brewing..."
  brew bundle install --file="$script_path/brewfile" --force --no-lock
  brew services start yabai
  brew services start skhd
fi
echo "Done!"

echo -n "Installing fzf... "
echo y | $(brew --prefix)/opt/fzf/install >/dev/null && echo "Done!"

echo -n "Installing pip packages... "
pip3 install --user --upgrade jedi pynvim dotbot docutils pip pip-review >/dev/null && echo "Done!"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"

echo -n "Symlinking files... "
dotbot -c "$script_path/install.conf.yaml" >/dev/null
echo "Done!"

echo -n "Installing node... "
eval "$(fnm env --multi)"
fnm install "latest" && fnm use "latest" && fnm default $(fnm current) >/dev/null

echo -n "Installing global NPM packages... "
npm install --loglevel silent --no-progress -g \
  $(cat "$script_path/npm-global-packages" | tr '\n' ' ') >/dev/null
echo "Done!"

! [[ "$SHELL" = "$(which zsh)" ]] && chsh -s $(which zsh)
if ! grep -q $(which zsh) "/etc/shells"; then
  sudo sh -c "echo $(which zsh) >> /etc/shells"
fi

antibody bundle < "$script_path/zsh/zsh_plugins" > ~/.zsh_plugins

loginitems -a "Bartender 3"
loginitems -a "Flux"
loginitems -a "Itsycal"
loginitems -a "Mail"
loginitems -a "SpaceId"

echo "Installation finished!"
