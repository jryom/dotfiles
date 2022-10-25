#!/usr/bin/env zsh

setopt always_to_end
setopt auto_cd
setopt auto_pushd
setopt complete_in_word
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt menu_complete
setopt pushd_ignore_dups

set -o vi

source "$HOME/.config/zsh/env"

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' fzf-search-display true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' verbose true
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' default-color $'\033[37m'
zstyle ':fzf-tab:complete:*' fzf-bindings 'tab:toggle+down'
zstyle ':fzf-tab:*' fzf-flags '--color=hl:cyan'

# https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

eval "$(zoxide init zsh --cmd j)"
eval "$(fnm env)"
eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.zsh_plugins

enable-fzf-tab

zmodload zsh/complist

bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey 'ç' fzf-cd-widget
bindkey '^l' autosuggest-accept
bindkey '^[[Z' reverse-menu-complete
bindkey '^Z' ctrl-z

source "$HOME/.config/zsh/aliases"
source "$HOME/.config/zsh/functions"

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; then source "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION

eval "$(starship init zsh)"
