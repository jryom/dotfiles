#!/usr/bin/env bash

if ! command -v brew >/dev/null; then
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
  export PATH="/opt/homebrew/bin:$PATH"
fi

brew bundle install --file="$DOT_DIR/bin/Brewfile" --force --no-lock

stow --restow --no-folding --target $HOME --dir $DOT_DIR --ignore "\.DS_Store" stow-files

if [ ! -f /private/etc/sudoers.d/yabai ]; then
  sudo zsh -c "echo '$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa' >> /private/etc/sudoers.d/yabai"
fi

echo y | "$(brew --prefix)"/opt/fzf/install

python3 -m pip install --user --upgrade pip pynvim

eval "$(fnm env)"
fnm install --lts && fnm use lts-latest && fnm default lts-latest

npm install --no-progress --global $(cat $DOT_DIR/bin/npm-global-packages | tr '\n' ' ')

# Use custom zsh install rather than bundled version
! [[ "$(which zsh)" = "/opt/homebrew/bin/zsh" ]] &&
  sudo dscl . -create /Users/$USER UserShell /opt/homebrew/bin/zsh

antibody bundle <"$DOT_DIR/bin/zsh-plugins" >~/.zsh_plugins

rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

brew services start koekeishiya/formulae/yabai
brew services start koekeishiya/formulae/skhd

curl -fsSl https://raw.githubusercontent.com/tridactyl/native_messenger/master/installers/install.sh -o /tmp/trinativeinstall.sh && sh /tmp/trinativeinstall.sh
