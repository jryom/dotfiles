setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

source "$DOTDIR/zsh/functions.zsh"
source "$DOTDIR/zsh/aliases.zsh"
source "$DOTDIR/zsh/env.zsh"

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

eval "$(fnm env --multi)"

autoload -U promptinit; promptinit
prompt pure
