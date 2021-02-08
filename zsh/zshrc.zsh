

precmd () {
  print -Pn "\e]0;%~\a"
}
setopt ALL_EXPORT
setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt MENU_COMPLETE
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

source "$DOTDIR/zsh/env.zsh"

bindkey -v
bindkey '^l' autosuggest-accept
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^[[Z' reverse-menu-complete
bindkey '^e' end-of-line
bindkey 'ç' fzf-cd-widget

autoload -U compinit && compinit;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh_plugins
source $(brew --prefix)/etc/profile.d/z.sh
eval "$(fnm env)"

# prompt_pure_set_title() {}

source "$DOTDIR/zsh/aliases.zsh"

zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
zstyle ':fzf-tab:*' default-color $'\033[30m'
zstyle ':fzf-tab:*' show-group full

source "$DOTDIR/zsh/functions.zsh"
bindkey '^Z' ctrl-z
