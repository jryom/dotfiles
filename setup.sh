#!/bin/sh
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

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
if ! brew bundle check; then
  brew bundle install
fi

echo y | $(brew --prefix)/opt/fzf/install

brew link --overwrite python
brew postinstall python3

pip2 install --upgrade pynvim
pip3 install --upgrade pip dotbot setuptools pynvim vint

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

if ! cd ~/.config/base16-shell; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  cd .config/base16-shell
  git fetch origin pull/154/head:fix-syntax-for-profile_helper.fish
  git checkout fix-syntax-for-profile_helper.fish
fi
mkdir -p ~/.config/kitty-base16-themes
curl https://codeload.github.com/kdrag0n/base16-kitty/tar.gz/master | tar -C ~/.config/kitty-base16-themes/ -xz --strip=2 base16-kitty-master/colors/
if ! cd ~/.config/nvim/pack/minpac/opt/minpac; then
  mkdir -p ~/.config/nvim/pack/minpac/opt/minpack
  git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
fi

dotbot -c "$script_path/install.conf.yaml"

nvim +PackUpdate +UpdateRemotePlugins +qall

fnm install 10 && fnm use 10
npm i -g $(cat "$script_path/npm-global-packages" | tr '\n' ' ')

if ! grep -q $(which fish) "/etc/shells"; then
  sudo sh -c "echo $(which fish) >> /etc/shells"
  chsh -s $(which fish)
fi
