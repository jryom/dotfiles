#!/bin/bash
trap 'ret=$?; test $ret -ne 0 && printf "Failed!\n" >&2; exit $ret' EXIT
set -e

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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

echo -n "Fetching submodules... "
git submodule --quiet init
git submodule --quiet update --remote
echo "Done!"

echo -n "Installing fzf... "
echo y | $(brew --prefix)/opt/fzf/install >/dev/null && echo "Done!"

echo -n "Installing pip packages... "
pip3 install --user --upgrade jedi pynvim dotbot docutils pip pip-review >/dev/null && echo "Done!"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

echo -n "Symlinking files... "
dotbot -c "$script_path/install.conf.yaml" >/dev/null
echo "Done!"

if [ ! -d ~/.config/nvim/pack/minpac/opt/minpac ]; then
  echo -n "Pulling minpac repo... "
  mkdir -p ~/.config/nvim/pack/minpac/opt/minpack
  git clone --quiet https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac >/dev/null
  echo "Done!"
fi

echo -n "Installing node... "
fnm install 12 >/dev/null && fnm use 12 >/dev/null

echo -n "Installing global NPM packages... "
npm install --loglevel silent --no-progress -g \
  $(cat "$script_path/npm-global-packages" | tr '\n' ' ') >/dev/null
echo "Done!"

echo "Installation finished!"

if ! grep -q $(which fish) "/etc/shells"; then
  sudo sh -c "echo $(which fish) >> /etc/shells"
  chsh -s $(which fish)
fi
