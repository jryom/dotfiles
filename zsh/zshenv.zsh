export \
  DOTDIR=`dirname $(dirname $(/usr/local/bin/greadlink -f ${(%):-%x}))` \
  THEME_DARK="material-palenight" \
  THEME_LIGHT="solarized-light"

function kittyColors() {
  kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/kitty/base16-kitty/colors/base16-$argv-256.conf
  ln -sf ~/.config/kitty/base16-kitty/colors/base16-$argv-256.conf ~/.config/kitty/theme.conf
}
