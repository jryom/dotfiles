#!/bin/zsh
echo "Installing Homebrew updates"
brew update && brew upgrade && brew cask upgrade
pip2 install --upgrade pynvim
pip3 install --upgrade pip setuptools pynvim

echo y | $(brew --prefix)/opt/fzf/install

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
cd ~/.config/nvim/pack/minpac/opt/minpac && git fetch && git pull

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvim +PackUpdate +UpdateRemotePlugins +qall

nvm install --lts
