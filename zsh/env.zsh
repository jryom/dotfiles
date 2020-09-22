export  BAT_STYLE="full"
export  DARK_MODE_ACTIVE=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
export  EDITOR="$DOTDIR/nvim/nvim"
export  FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}'"
export  FZF_THEME_LIGHT='--color=fg:#4b505b,bg:#fafafa,hl:#5079be
--color=fg+:#4b505b,bg+:#fafafa,hl+:#3a8b84
--color=info:#88909f,prompt:#d05858,pointer:#b05ccc
--color=marker:#608e32,spinner:#d05858,header:#3a8b84'
export  FZF_THEME_DARK='--color=fg:#c5cdd9,bg:#2b2d3a,hl:#6cb6eb
--color=fg+:#c5cdd9,bg+:#2b2d3a,hl+:#5dbbc1
--color=info:#88909f,prompt:#ec7279,pointer:#d38aea
--color=marker:#a0c980,spinner:#ec7279,header:#5dbbc1'
export  FZF_DEFAULT_COMMAND="rg --files --hidden"
export  HISTFILESIZE=1000000
export  HISTSIZE=1000000
export  HISTTIMEFORMAT="[%F %T] "
export  KEYTIMEOUT=1
export  LC_ALL="en_US.UTF-8"
export  NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export  PATH=$HOME/Library/Python/3.8/bin:/usr/local/lib/python3.8/site-packages/pip:/usr/local/bin:$PATH
export  RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export  VISUAL="$EDITOR"

export  FZF_DEFAULT_OPTS="--ansi $([[ "$DARK_MODE_ACTIVE" = 1 ]] && echo "$FZF_THEME_DARK" || echo "$FZF_THEME_LIGHT")"
export  BAT_THEME="$([[ $DARK_MODE_ACTIVE = 1 ]] && echo "OneHalfDark" || echo "OneHalfLight")"
