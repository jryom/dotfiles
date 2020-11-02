function l() {
  tmp="$(mktemp)"
  columns="$(tput cols)"
  size="tiny"

  if [ $columns -gt 200 ]; then
    size="large"
  elif [ $columns -gt 120 ]; then
    size="medium"
  elif [ $columns -gt 80 ]; then
    size="small"
  fi

  lf -command "$size" -last-dir-path="$tmp"

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
