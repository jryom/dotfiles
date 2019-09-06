alias python "/usr/local/bin/python3"
alias pip "/usr/local/bin/pip3"

set -gx EDITOR nvim
set -U FZF_LEGACY_KEYBINDINGS 0
set -gx BAT_THEME "base16"
set -gx FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND"
set -U FZF_FIND_FILE_OPTS "--reverse --inline-info"
set -U FZF_ENABLE_OPEN_PREVIEW 1
set -gx FZF_CTRL_T_OPTS "--delimiter '/' --nth '-1' --preview 'bat --color=always --line-range :500 {}'"
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--color=bg+:10,bg:0,spinner:6,hl:4,fg:12,header:4,info:3,pointer:6,marker:6,fg+:13,prompt:3,hl+:4"
set -gx LC_ALL "en_US.UTF-8"
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

function kittyColors
  kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/base16-kitty/colors/$argv.conf
  cp -f ~/.config/base16-kitty/colors/$argv.conf ~/.config/kitty/theme.conf
end

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

if status --is-interactive
  fish_vi_key_bindings
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
  if [ (dark-mode status) = 'on' ]
    base16-solarized-dark
    kittyColors base16-solarized-dark
  else
    base16-solarized-light
    kittyColors base16-solarized-light
  end
  source ~/.config/fish/abbreviations.fish
end

set -g fish_color_autosuggestion yellow
set -g fish_color_command blue
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_error red
set -g fish_color_escape cyan
set -g fish_color_history_current cyan
set -g fish_color_match cyan
set -g fish_color_normal normal
set -g fish_color_operator cyan
set -g fish_color_param cyan
set -g fish_color_quote brown
set -g fish_color_redirection normal
set -g fish_color_search_match --background purple
set -g fish_color_valid_path --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow
set -g fish_pager_color_prefic cyan
set -g fish_pager_color_progress cyan

# fnm
set PATH $HOME/.fnm $PATH
fnm env --multi | source
