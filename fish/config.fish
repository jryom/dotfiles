set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND "rg --files"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS "--color=bg+:10,bg:0,spinner:6,hl:4,fg:12,header:4,info:3,pointer:6,marker:6,fg+:13,prompt:3,hl+:4"
set -gx FZF_CTRL_T_OPTS "--delimiter '/' --nth '-1' --preview 'bat --color=always --line-range :500 {}'"
set -gx BAT_THEME "base16"
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

fish_vi_key_bindings

function kittyColors
  kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/kitty-base16-themes/$argv.conf
end

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
  if [ (dark-mode status) = 'on' ]
    base16-ocean
    kittyColors base16-ocean
  else
    base16-solarized-light
    kittyColors base16-solarized-light
  end
  source ~/.config/fish/abbreviations.fish
end

# fnm
set PATH $HOME/.fnm $PATH
fnm env --multi | source
