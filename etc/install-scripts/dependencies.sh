#!/usr/bin/env bash

if ! command -v brew >/dev/null; then
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
  export PATH="$(brew --prefix)/bin:$PATH"
fi

brew bundle install --file="$DOT_DIR/etc/Brewfile" --force --no-lock

stow --restow --no-folding --target $HOME --dir $DOT_DIR --ignore "\.DS_Store" home

if [ ! -f /private/etc/sudoers.d/yabai ]; then
  sudo zsh -c "echo '$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa' >> /private/etc/sudoers.d/yabai"
fi

echo y | "$(brew --prefix)"/opt/fzf/install

python3 -m pip install --user --upgrade pynvim black

eval "$(fnm env)"
fnm install --lts && fnm use lts-latest && fnm default lts-latest

npm install --no-progress --global $(cat ""$DOT_DIR/etc/npm-global-packages | tr '\n' ' ')

# Use custom zsh install rather than bundled version
! [[ "$(which zsh)" = "$(brew --prefix)/bin/zsh" ]] &&
  sudo dscl . -create /Users/$USER UserShell "$(brew --prefix)/bin/zsh"

brew services start koekeishiya/formulae/yabai
brew services start koekeishiya/formulae/skhd

rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
