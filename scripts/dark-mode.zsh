#!/bin/zsh

theme=$([[ "$argv" = "light" ]] && echo "$THEME_LIGHT" || echo "$THEME_DARK")
kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/kitty/themes/$theme.conf
ln -sf ~/.config/kitty/themes/$theme.conf ~/.config/kitty/theme.conf
mkdir -p "$HOME/Library/Application Support/jesseduffield/lazygit"
ln -sf $DOTDIR/lazygit/config-$argv.yml "$HOME/Library/Application Support/jesseduffield/lazygit/config.yml"
