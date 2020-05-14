export \
  BAT_THEME="base16" \
  EDITOR="vim" \
  FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview 'bat --color=always --line-range :500 {}'" \
  FZF_DEFAULT_COMMAND="rg --files" \
  FZF_DEFAULT_OPTS="--color=fg:7,bg:0,hl:8,fg+:7,bg+:18,hl+:1,info:3,border:18,prompt:8,pointer:1,marker:5,spinner:3,header:8" \
  FZF_ENABLE_OPEN_PREVIEW=1 \
  FZF_FIND_FILE_COMMAND="$FZF_DEFAULT_COMMAND" \
  FZF_FIND_FILE_OPTS="--reverse --inline-info" \
  KEYTIMEOUT=1 \
  LC_ALL="en_US.UTF-8" \
  PATH=$HOME/Library/Python/3.7/bin:/usr/local/lib/python3.7/site-packages/pip:/usr/local/bin:$PATH \
  RIPGREP_CONFIG_PATH="$HOME/.ripgreprc" \
  VISUAL="vim"
