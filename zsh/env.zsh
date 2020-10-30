export BAT_STYLE="full"
export DARK_MODE_ACTIVE=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
export BAT_THEME="$([[ $DARK_MODE_ACTIVE = 1 ]] && echo "gruvbox" || echo "OneHalfLight")"
export EDITOR="$DOTDIR/nvim/nvim"
export FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}'"
export FZF_THEME_DARK='--color=16,bg+:0'
export FZF_THEME_LIGHT='--color=16,bg+:7'
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_DEFAULT_OPTS="--ansi $([[ "$DARK_MODE_ACTIVE" = 1 ]] && echo "$FZF_THEME_DARK" || echo "$FZF_THEME_LIGHT")"
export HISTFILE=~/Documents/.config/zsh-history
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTTIMEFORMAT="[%F %T] "
export KEYTIMEOUT=1
export NODE_VERSION=15
export LC_ALL="en_US.UTF-8"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export VISUAL="$EDITOR"

PATH=$PATH
PATH+=:/usr/local/bin
PATH+=:$( find $HOME/Library/Python -maxdepth 2 -type d | tr '\n' ':' )
PATH+=$( python3 -c "import sysconfig; print(sysconfig.get_path('purelib'))" )

export PATH
