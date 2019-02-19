#!/bin/sh
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

unset NVM_DIR

trap 'ret=$?; test $ret -ne 0 && printf "Script failed, aborting\n\n" >&2; exit $ret' EXIT

set -e

echo "Checking command line tools installation..."
if ! type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}"; then
   echo "Not installed. Install and run script again."
   xcode-select --install
   EXIT
fi

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew..."
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    export PATH="/usr/local/bin:$PATH"
fi

echo "Homebrewing..."
brew update
brew upgrade
brew bundle --file=- <<EOF
  tap "heroku/brew"
  tap "jesseduffield/lazygit"
  brew "coreutils"
  brew "exa"
  brew "fd"
  brew "fzf"
  brew "git"
  brew "heroku/brew/heroku"
  brew "jq"
  brew "lazygit"
  brew "neovim"
  brew "nnn"
  brew "python"
  brew "python@2"
  brew "ruby"
  brew "stow"
  brew "the_silver_searcher"
  brew "tree"
  brew "universal-ctags/universal-ctags/universal-ctags", args: ["HEAD"]
  brew "yamllint"
  brew "zsh"
  cask "amethyst"
EOF

brew link --overwrite python
brew postinstall python3
echo y | $(brew --prefix)/opt/fzf/install

pip2 install --upgrade pynvim
pip3 install --upgrade pip setuptools pynvim vint

if ! cd ~/.zplug; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p ~/.config/kitty-base16-themes
curl https://codeload.github.com/kdrag0n/base16-kitty/tar.gz/master | tar -C ~/.config/kitty-base16-themes/ -xz --strip=2 base16-kitty-master/colors/
if ! cd ~/.config/nvim/pack/minpac/opt/minpac; then
  mkdir -p ~/.config/nvim/pack/minpac/opt/minpack
  git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
fi

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

stow -d "$script_path" -t ~/ stow && stow -d "$script_path" -t ~/ git kitty nvm nvim shell

nvim +PackUpdate +UpdateRemotePlugins +qall

set +e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts

if ! grep -q $(which zsh) "/etc/shells"; then
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s $(which zsh)
fi
