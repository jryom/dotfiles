l () {
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

ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N ctrl-z
bindkey '^Z' ctrl-z

# Allow passing dir/filename to cd
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
}

v() {
  if [ -d "$1" ] || [ -f "$1" ]; then
    print -Pn "\e]0;%~: $EDITOR\a" && $EDITOR "$1"
  elif [ -z "$1" ]; then
    print -Pn "\e]0;%~: $EDITOR\a" && $EDITOR
  else
    z "$1" && print -Pn "\e]0;%~: $EDITOR\a" && $EDITOR
  fi
}

precmd () {
  print -Pn "\e]0;%~\a"
}
