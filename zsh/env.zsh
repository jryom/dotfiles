BAT_STYLE="full"
DARK_MODE_ACTIVE=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
BAT_THEME="$([[ $DARK_MODE_ACTIVE = 1 ]] && echo "gruvbox" || echo "OneHalfLight")"
EDITOR="nvim"
FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}'"
FZF_THEME_DARK='--color=16,bg+:0'
FZF_THEME_LIGHT='--color=16,bg+:7'
FZF_DEFAULT_COMMAND="rg --files --hidden"
FZF_DEFAULT_OPTS="--ansi $([[ "$DARK_MODE_ACTIVE" = 1 ]] && echo "$FZF_THEME_DARK" || echo "$FZF_THEME_LIGHT")"
HISTFILE=~/Documents/.config/zsh-history
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT="[%F %T] "
KEYTIMEOUT=1
NODE_VERSION=15
LC_ALL="en_US.UTF-8"
RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
VISUAL="$EDITOR"

PATH=/usr/local/bin:$PATH
PATH+=:$( find $HOME/Library/Python -maxdepth 2 -type d | tr '\n' ':' )
PATH+=$( python3 -c "import sysconfig; print(sysconfig.get_path('purelib'))" )
