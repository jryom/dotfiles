export BAT_STYLE="full"
export DARK_MODE_ACTIVE=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
export BAT_THEME="$([[ $DARK_MODE_ACTIVE = 1 ]] && echo "gruvbox" || echo "OneHalfLight")"
export EDITOR="$DOTDIR/nvim/nvim"
export FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}'"
export FZF_THEME_DARK='--color=16,bg+:0'
export FZF_THEME_LIGHT='--color=16,bg+:7'
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_DEFAULT_OPTS="--ansi $([[ "$DARK_MODE_ACTIVE" = 1 ]] && echo "$FZF_THEME_DARK" || echo "$FZF_THEME_LIGHT")"
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTTIMEFORMAT="[%F %T] "
export KEYTIMEOUT=1
export LC_ALL="en_US.UTF-8"
export PATH=$HOME/Library/Python/3.8/bin:/usr/local/lib/python3.8/site-packages/pip:/usr/local/bin:$PATH
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export VISUAL="$EDITOR"
