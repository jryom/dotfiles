SCRIPT_PATH=`dirname $(greadlink -f ${(%):-%x})`

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

source "$SCRIPT_PATH/functions.zsh"
source "$SCRIPT_PATH/aliases.zsh"
source "$SCRIPT_PATH/env.zsh"

bindkey -v
bindkey '^l' autosuggest-accept
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey 'ç' fzf-cd-widget

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh_plugins

if [ "$(dark-mode status)" = 'on' ]; then
  (kittyColors base16-material-palenight &)
else
  (kittyColors base16-solarized-light &)
fi

eval "$(fnm env --multi)"

autoload -U promptinit; promptinit
prompt pure
