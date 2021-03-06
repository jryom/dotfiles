lfwrapper () {
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

zAndLaunch() {
  if [ -d "$2" ] || [ -f "$2" ]; then
    print -Pn "\e]0;%~: $1\a" && $1 "$2"
  elif [ -z "$2" ]; then
    print -Pn "\e]0;%~: $1\a" && $1
  else
    z "$2" && print -Pn "\e]0;%~: $1\a" && $1
  fi
}

l() {
  zAndLaunch lfwrapper $1
}

v() {
  zAndLaunch $EDITOR $1
}

g() {
  zAndLaunch lazygit $1
}

b() {
  btm --color $( defaults read -g AppleInterfaceStyle &>/dev/null && echo 'default' || echo 'default-light' )
}
