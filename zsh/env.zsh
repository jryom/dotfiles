export \
  BASE16_SHELL="$HOME/.config/base16-shell/" \
  BAT_THEME="base16" \
  EDITOR="vim" \
  FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview 'bat --color=always --line-range :500 {}'" \
  FZF_DEFAULT_COMMAND="rg --files" \
  FZF_DEFAULT_OPTS="--color=bg+:10,bg:0,spinner:6,hl:4,fg:12,header:4,info:3,pointer:6,marker:6,fg+:13,prompt:3,hl+:4" \
  FZF_ENABLE_OPEN_PREVIEW=1 \
  FZF_FIND_FILE_COMMAND="$FZF_DEFAULT_COMMAND" \
  FZF_FIND_FILE_OPTS="--reverse --inline-info" \
  KEYTIMEOUT=1 \
  LC_ALL="en_US.UTF-8" \
  PATH=$HOME/Library/Python/3.7/bin:/usr/local/lib/python3.7/site-packages/pip:/usr/local/bin:$PATH \
  RIPGREP_CONFIG_PATH="$HOME/.ripgreprc" \
  VISUAL="vim"
