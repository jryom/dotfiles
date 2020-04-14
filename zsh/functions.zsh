function l() {
  tmp="$(mktemp)"
  columns="$(tput cols)"
  if [ $columns -lt 70 ]; then
    lf -command "tiny" -last-dir-path="$tmp" "$@"
  elif [ $columns -lt 100 ]; then
    lf -command "small" -last-dir-path="$tmp" "$@"
  elif [ $columns -lt 200 ]; then
    lf -command "medium" -last-dir-path="$tmp" "$@"
  else
    lf -command "large" -last-dir-path="$tmp" "$@"
  fi

  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}

function kittyColors() {
  kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/base16-kitty/colors/$argv.conf
  cp -f ~/.config/base16-kitty/colors/$argv.conf ~/.config/kitty/theme.conf
}
