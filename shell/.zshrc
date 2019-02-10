export LANG="en_US.UTF-8"
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="fd --hidden --type f -E .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --hidden --type d -E .git"

DEFAULT_USER=$USER

source /usr/local/share/antigen/antigen.zsh
antigen init ~/.antigenrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^ ' autosuggest-accept
source ~/.aliases

autoload -U promptinit; promptinit
prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"
PURE_PROMPT_SYMBOL='→'
