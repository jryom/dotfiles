setopt \
  auto_cd \
  auto_pushd \
  pushd_ignore_dups \
  pushd_minus \
  inc_append_history \
  extended_history \
  hist_find_no_dups \
  hist_ignore_all_dups

source "$DOTDIR/zsh/functions.zsh"
source "$DOTDIR/zsh/env.zsh"
source "$DOTDIR/zsh/aliases.zsh"

bindkey -v
bindkey '^l' autosuggest-accept
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey 'ç' fzf-cd-widget

autoload -U compinit && compinit;
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh_plugins

eval "$(fnm env --multi)"

autoload -U promptinit; promptinit
prompt pure
