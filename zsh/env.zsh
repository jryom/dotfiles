BAT_STYLE="full"
DARK_MODE_ACTIVE=$(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
BAT_THEME="$([[ $DARK_MODE_ACTIVE = 1 ]] && echo "gruvbox-dark" || echo "OneHalfLight")"
EDITOR="nvim"
FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}'"
FZF_THEME_DARK='--color=fg:#c5cdd9,bg:#262729,hl:#6cb6eb
--color=fg+:#c5cdd9,bg+:#262729,hl+:#5dbbc1
--color=info:#88909f,prompt:#ec7279,pointer:#d38aea
--color=marker:#a0c980,spinner:#ec7279,header:#5dbbc1'
FZF_THEME_LIGHT='--color=fg:#4b505b,bg:#fafafa,hl:#5079be
--color=fg+:#4b505b,bg+:#fafafa,hl+:#3a8b84
--color=info:#88909f,prompt:#d05858,pointer:#b05ccc
--color=marker:#608e32,spinner:#d05858,header:#3a8b84'
FZF_DEFAULT_COMMAND="rg --files --hidden"
FZF_DEFAULT_OPTS="--ansi $([[ "$DARK_MODE_ACTIVE" = 1 ]] && echo "$FZF_THEME_DARK" || echo "$FZF_THEME_LIGHT")"
HISTFILE=~/Documents/.config/zsh-history
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT="[%F %T] "
KEYTIMEOUT=1
LC_ALL="en_US.UTF-8"
RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
VISUAL="$EDITOR"

PATH=/usr/local/bin:$PATH
PATH+=:$( find $HOME/Library/Python -maxdepth 2 -type d | tr '\n' ':' )
PATH+=$( python3 -c "import sysconfig; print(sysconfig.get_path('purelib'))" )
