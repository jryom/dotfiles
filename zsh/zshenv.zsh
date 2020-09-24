export \
  DOTDIR=`dirname $(dirname $(/usr/local/bin/greadlink -f ${(%):-%x}))` \
  THEME_DARK="edge-dark" \
  THEME_LIGHT="edge-light"
