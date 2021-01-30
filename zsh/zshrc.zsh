setopt ALL_EXPORT
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS

source "$DOTDIR/zsh/functions.zsh"
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
bindkey '^Z' ctrl-z

autoload -U compinit && compinit;
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh_plugins

source "$DOTDIR/zsh/aliases.zsh"

zstyle ':completion:*' fzf-search-display true

source $(brew --prefix)/etc/profile.d/z.sh
eval "$(fnm env)"


autoload -U promptinit; promptinit
prompt pure
