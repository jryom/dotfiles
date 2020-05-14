export \
  THEME_DARK="material-palenight" \
  THEME_LIGHT="solarized-light"

function kittyColors() {
  kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/base16-kitty/colors/base16-$argv-256.conf
  ln -sf ~/.config/base16-kitty/colors/base16-$argv-256.conf ~/.config/kitty/theme.conf
}
