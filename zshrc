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

alias vim="nvim"
alias vi="nvim"
