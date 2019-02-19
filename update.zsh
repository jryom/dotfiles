#!/bin/zsh
brew update && brew upgrade && brew cask upgrade && brew reinstall fzf
pip2 install --upgrade pynvim
pip3 install --upgrade pip setuptools pynvim

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvim +PackUpdate +UpdateRemotePlugins +qall

nvm install --lts
