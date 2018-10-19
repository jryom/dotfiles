#!/bin/sh
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

unset NVM_DIR

trap 'ret=$?; test $ret -ne 0 && printf "Script failed, aborting\n\n" >&2; exit $ret' EXIT

set -e

echo "Checking command line tools installation"
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}" ; then
    echo "OK. Continuing"
else
   echo "Not installed. Finish installation and run script again"
   xcode-select --install
   EXIT
fi

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew"
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    export PATH="/usr/local/bin:$PATH"
fi

echo "Installing Homebrew updates"
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew upgrade
echo "Installing missing homebrew packages"
brew bundle --file=- <<EOF
brew "bash"
brew "coreutils"
brew "ruby"
brew "openssl"
brew "git"
brew "python"
brew "python@2"
brew "fd"
brew "fzf"
brew "neovim"
brew "the_silver_searcher"
EOF

brew link --overwrite python
brew tap caskroom/fonts
brew cask install font-mononoki-nerd-font

python -m pip install --upgrade setuptools
python -m pip install --upgrade pip
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim

gem install neovim

echo y | $(brew --prefix)/opt/fzf/install

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git pull https://github.com/zsh-users/zsh-autosuggestions
fi

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p ~/.config/kitty/
mkdir -p ~/.config/nvim/

ln -sfn "$script_path/git/gitconfig"        ~/.gitconfig
ln -sfn "$script_path/git/gitignore_global" ~/.gitignore_global
ln -sfn "$script_path/shell/aliases"        ~/.aliases
ln -sfn "$script_path/shell/zshrc"          ~/.zshrc
ln -sfn "$script_path/kitty/"*              ~/.config/kitty
ln -sfn "$script_path/nvim/"*               ~/.config/nvim

nvim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qall

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ln -sfn "$script_path"/npm/default-packages ~/.nvm/default-packages

set +e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts

