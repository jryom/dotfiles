#!/usr/bin/env zsh

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

set -o vi

source "$HOME/.config/zsh/env"

autoload -U compinit && compinit;

source $HOME/.zsh_plugins
source $(brew --prefix)/etc/profile.d/z.sh
eval "$(fnm env)"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

bindkey 'ç' fzf-cd-widget
bindkey '^l' autosuggest-accept
bindkey '^[[Z' reverse-menu-complete
bindkey '^Z' ctrl-z
enable-fzf-tab

source "$HOME/.config/zsh/aliases"
source "$HOME/Documents/Dotfiles/zsh"

zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
zstyle ':fzf-tab:*' default-color $'\033[30m'
zstyle ':fzf-tab:*' show-group full
zstyle ':fzf-tab:complete:*' fzf-bindings 'tab:toggle+down'

source "$HOME/.config/zsh/functions"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
