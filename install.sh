#!/usr/bin/env bash

set -e

# Ask for the sudo permission upfront and keep valid until EOF
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

source "$script_path/zsh/.config/zsh/env"

set -x

# Disable Gatekeeper if active
if spctl --status > /dev/null; then
  sudo spctl --master-disable
fi

# Change some macOS default settings and restart dock
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

if ! type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}"; then
   echo "Command line tools not installed. Install and run script again."
   xcode-select --install
   EXIT
fi

if ! command -v brew >/dev/null; then
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
  export PATH="/usr/local/bin:$PATH"
fi

if ! brew bundle check --file="$script_path/bin/Brewfile" >/dev/null; then
  brew bundle install --file="$script_path/bin/Brewfile" --force --no-lock
fi

for file in $script_path/*; do
  if [ -d ${file} ]; then
    stow --verbose --no-folding --target $HOME --dir $script_path -R "$(basename $file)"
  fi
done

source $HOME/Documents/Dotfiles/install

if [ ! -f /private/etc/sudoers.d/yabai  ]; then
  sudo zsh -c "echo '$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa' >> /private/etc/sudoers.d/yabai"
fi

echo y | "$(brew --prefix)"/opt/fzf/install

python3 -m pip install --user --upgrade pip pynvim

# zsh completions
gh completion -s zsh > /usr/local/share/zsh/site-functions/_gh

eval "$(fnm env)"
fnm install --lts && fnm use lts-latest && fnm default lts-latest

npm install --no-progress -g $(cat $HOME/.config/npm/npm-global-packages | tr '\n' ' ')

# Use custom zsh install rather than bundled version
! [[ "$( which zsh )" = "/usr/local/bin/zsh" ]] && sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

for f in $(zsh -i -c compaudit)
do
  sudo chmod -R 755 $f
done

# Use touchID for sudo permission
cat /etc/pam.d/sudo | grep "pam_tid.so" || sudo gsed -i '3 i auth       sufficient     pam_tid.so' /etc/pam.d/sudo

antibody bundle < "$script_path/bin/zsh-plugins" > ~/.zsh_plugins

curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qa

brew services start koekeishiya/formulae/yabai
brew services start koekeishiya/formulae/skhd
