#!/bin/sh
trap 'ret=$?; test $ret -ne 0 && printf "Failed!\n" >&2; exit $ret' EXIT
set -e

read -p 'Is this your personal computer? [y/n] ' personal

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

if ! brew bundle check --file="$script_path/homebrew/brewfile"; then
  echo "Homebrewing..."
  brew bundle install --file="$script_path/homebrew/brewfile" --force
  brew services start yabai
  brew services start skhd
fi

if [ "$personal" == "y" ]; then
  if ! brew bundle check --file="$script_path/homebrew/personal"; then
    brew bundle install --file="$script_path/homebrew/personal" --force
  fi
fi

echo y | $(brew --prefix)/opt/fzf/install

pip2 install --upgrade pynvim
pip3 install --upgrade pynvim dotbot pip 
dotbot -c "$script_path/install.conf.yaml"

if ! cd ~/.config/nvim/pack/minpac/opt/minpac; then
  mkdir -p ~/.config/nvim/pack/minpac/opt/minpack
  git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
fi

if ! cd ~/.tmux/plugins/tpm; then
  mkdir -p ~/.tmux/plugins/tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! cd ~/.tmux/base16-tmux; then
  git clone https://github.com/jesperryom/base16-tmux ~/.tmux/base16-tmux
fi

if ! cd ~/.config/base16-shell; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
else
  cd ~/.config/base16-shell && git fetch && git pull
fi
mkdir -p ~/.config/kitty-base16-themes
curl https://codeload.github.com/kdrag0n/base16-kitty/tar.gz/master | tar -C ~/.config/kitty-base16-themes/ -xz --strip=2 base16-kitty-master/colors/

if ! cd ~/.config/kitty-base16-themes; then
  mkdir -p ~/.config/kitty-base16-themes
  curl https://codeload.github.com/kdrag0n/base16-kitty/tar.gz/master | tar -C ~/.config/kitty-base16-themes/ -xz --strip=2 base16-kitty-master/colors/
fi

tic -x "$script_path/terminfo/xterm-256color-italic.terminfo"
tic -x "$script_path/terminfo/tmux-256color.terminfo"

fnm install 10 && fnm use 10
npm i -g $(cat "$script_path/npm-global-packages" | tr '\n' ' ')

if ! grep -q $(which fish) "/etc/shells"; then
  sudo sh -c "echo $(which fish) >> /etc/shells"
  chsh -s $(which fish)
fi
