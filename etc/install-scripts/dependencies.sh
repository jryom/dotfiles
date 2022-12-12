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

echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
sudo dscl . -create /Users/$USER UserShell $(which fish)

fish -c 'fisher update'

brew services start koekeishiya/formulae/yabai
brew services start koekeishiya/formulae/skhd

rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
