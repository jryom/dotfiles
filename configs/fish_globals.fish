#!/usr/bin/env fish
set -U fish_key_bindings fish_vi_key_bindings
set -U fish_cursor_default block
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore
set -U fish_cursor_visual block

set -l brew_prefix (brew --prefix)
set -U fish_greeting
set -Ux BAT_STYLE full
set -Ux CLICOLOR 1
set -Ux EDITOR nvim
set -Ux ESCDELAY 0
set -Ux FZF_DEFAULT_COMMAND "rg --files"
set -Ux FZF_DEFAULT_OPTS '--color fg:7,bg:0,hl:6,fg+:7,bg+:8,hl+:3,info:15,prompt:1,pointer:5,marker:2,spinner:3,header:6,gutter:0 --no-separator --info hidden'
set -Ux INFOPATH "$brew_prefix/share/info" ""
set -Ux KEYTIMEOUT 1
set -Ux MANPATH "$brew_prefix/share/man" ""
set -Ux RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
set -Ux VIRTUAL_ENV_DISABLE_PROMPT 1
set -Ux VISUAL "$EDITOR"
set -Uu fzf_fd_opts --color never

set -Ux HOMEBREW_NO_ANALYTICS 1
set -Ux HOMEBREW_NO_ENV_HINTS 1
set -Ux HOMEBREW_NO_UPDATE_REPORT_NEW 1

set -l dev_vars CODE_HOME DEV_HOME DIRENV_CONFIG HOMEBREW_CACHE MISE_TRUSTED_CONFIG_PATHS \
    XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME npm_config_cache npm_config_devdir \
    pnpm_config_cache_dir pnpm_config_store_dir
for var in $dev_vars
    set -Ue $var
end
set -Ux MISE_TRUSTED_CONFIG_PATHS "$HOME/Code"

if test -s ~/.config/code-home
    set -Ux CODE_HOME (string trim < ~/.config/code-home)
    set -Ux DEV_HOME (dirname "$CODE_HOME")
    set -Ux DIRENV_CONFIG "$HOME/.config/direnv-work"
    set -Ux HOMEBREW_CACHE "$DEV_HOME/cache/homebrew"
    set -Ux MISE_TRUSTED_CONFIG_PATHS "$CODE_HOME"
    set -Ux XDG_CACHE_HOME "$DEV_HOME/cache"
    set -Ux XDG_DATA_HOME "$DEV_HOME"
    set -Ux XDG_STATE_HOME "$DEV_HOME/state"
    set -Ux npm_config_cache "$DEV_HOME/npm-cache"
    set -Ux npm_config_devdir "$DEV_HOME/node-gyp-cache"
    set -Ux pnpm_config_cache_dir "$DEV_HOME/pnpm-cache"
    set -Ux pnpm_config_store_dir "$DEV_HOME/pnpm-store"
end

set -l obsolete_tool_paths "$HOME/.pnpm/bin"
if set -q DEV_HOME
    set --append obsolete_tool_paths "$DEV_HOME/pnpm-global/bin" "$DEV_HOME/bin"
end
for path in $obsolete_tool_paths
    set -U fish_user_paths (string match -v -- "$path" $fish_user_paths)
end

fish_add_path --universal $(python3 -c "import site; print(site.USER_BASE)")/bin
fish_add_path --universal --prepend $brew_prefix/sbin $brew_prefix/bin $brew_prefix/opt/grep/libexec/gnubin
fish_add_path --universal /usr/local/bin
fish_add_path --universal $HOME/go/bin
fish_add_path --universal $HOME/.local/bin

# Colors
set -U fish_color_autosuggestion brblack -d
set -U fish_color_cancel red
set -U fish_color_command white -o
set -U fish_color_comment brblack
set -U fish_color_end brwhite -b
set -U fish_color_error brred
set -U fish_color_escape yellow
set -U fish_color_history_current --bold
set -U fish_color_keyword brblack
set -U fish_color_normal white
set -U fish_color_operator white -b
set -U fish_color_param white
set -U fish_color_quote white -i -d
set -U fish_color_redirection white -b
set -U fish_color_search_match yellow
set -U fish_color_selection --background=white -d
set -U fish_color_status red
set -U fish_color_valid_path --underline
set -U fish_pager_color_completion normal -d
set -U fish_pager_color_description normal -d
set -U fish_pager_color_progress brblack
set -U fish_pager_color_selected_background --background=brblack
set -U fish_pager_color_selected_completion white
set -U fish_pager_color_selected_description white
set -U fish_pager_color_selected_prefix red

exit 0
