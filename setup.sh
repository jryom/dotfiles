#!/bin/sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

unset NVM_DIR
script_path=$(dirname "$0")

trap 'ret=$?; test $ret -ne 0 && printf "Script failed, aborting\n\n" >&2; exit $ret' EXIT

set -e

if ! command -v brew >/dev/null; then
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    export PATH="/usr/local/bin:$PATH"
fi

brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=- <<EOF
brew "bash"
brew "git"
brew "reattach-to-user-namespace"
brew "neovim"
brew "the_silver_searcher"
brew "fzf"
brew "fd"
brew "coreutils"
brew "ruby"
brew "python"
brew "python@2"
EOF

brew tap caskroom/fonts
brew cask install font-mononoki-nerd-font
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo y | $(brew --prefix)/opt/fzf/install

python -m pip install --upgrade setuptools
python -m pip install --upgrade pip
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p ~/.config/kitty/
mkdir -p ~/.config/nvim/

ln -sfn "$script_path"/zshrc ~/.zshrc
ln -sfn "$script_path"/init.vim ~/.config/nvim/init.vim
ln -sfn "$script_path"/gitconfig ~/.gitconfig
ln -sfn "$script_path"/gitignore_global ~/.gitignore_global
ln -sfn "$script_path"/kitty.conf ~/.config/kitty
ln -sfn "$script_path"/jsconfig.json ~/jsconfig.json

git config --global core.excludesfile ~/.gitignore_global

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

ln -sfn "$script_path"/default-packages ~/.nvm/default-packages

set +e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install --lts
