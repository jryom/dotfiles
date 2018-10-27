#!/bin/sh
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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

brew tap jesseduffield/lazygit
brew tap cjbassi/gotop
echo "Installing missing homebrew packages"
brew bundle --file=- <<EOF
  brew "python"
  brew "python@2"
  brew "ruby"
  brew "zsh"
  brew "coreutils"
  brew "openssl"
  brew "git"
  brew "antigen"
  brew "httpie"
  brew "jq"
  brew "ncurses"
  brew "the_silver_searcher"
  brew "fd"
  brew "fzf"
  brew "neovim"
  brew "gotop"
  brew "lazygit"
EOF

brew link --overwrite python
sudo chown -R `whoami` /usr/local/lib/python3.7/site-packages
brew postinstall python3
brew tap homebrew/cask-fonts
brew cask install font-fantasque-sans-mono
brew cask install amethyst

sudo pip3 install --upgrade pip setuptools haxor-news neovim Pillow ranger-fm
sudo pip2 install --upgrade neovim

gem install neovim

echo y | $(brew --prefix)/opt/fzf/install

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p ~/.config/kitty/
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/ranger/

ln -sfn "$script_path/git/gitconfig"        ~/.gitconfig
ln -sfn "$script_path/git/gitignore_global" ~/.gitignore_global
ln -sfn "$script_path/shell/aliases"        ~/.aliases
ln -sfn "$script_path/shell/antigenrc"      ~/.antigenrc
ln -sfn "$script_path/shell/zshrc"          ~/.zshrc
ln -sfn "$script_path/kitty/"*              ~/.config/kitty
ln -sfn "$script_path/nvim/"*               ~/.config/nvim
sudo ln -sfn "$script_path/ranger/"*        ~/.config/ranger

nvim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qall

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ln -sfn "$script_path"/npm/default-packages ~/.nvm/default-packages

set +e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
