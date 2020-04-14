SCRIPT_PATH=`dirname $(greadlink -f ${(%):-%x})`

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

[ -f "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh_plugins

async_init
async_start_worker theme_worker

if [ "$(dark-mode status)" = 'on' ]; then
  base16_material-palenight
  async_job theme_worker kittyColors base16-material-palenight
else
  base16_solarized-light
  async_job theme_worker kittyColors base16-solarized-light
fi

async_stop_worker theme_worker

eval "$(fnm env --multi)"

autoload -U promptinit; promptinit
prompt pure

