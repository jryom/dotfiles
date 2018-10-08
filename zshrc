export ZSH="$HOME/.oh-my-zsh"
DEFAULT_USER=$USER
ZSH_THEME="agnoster"

plugins=(
  git
  npm
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

alias vim="nvim"
alias vi="nvim"
alias cslate="rm -R node_modules/ package-lock.json; gfa; gl; npm i;"
alias ls="ls -a -lh -F"