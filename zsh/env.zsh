export \
  BAT_STYLE="numbers,changes" \
  BAT_THEME="base16" \
  EDITOR="vim" \
  FZF_CTRL_T_OPTS="--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --color=always {}) || echo {}'" \
  FZF_DEFAULT_COMMAND="rg --files --hidden" \
  FZF_DEFAULT_OPTS="--ansi --color=fg:8,bg:0,preview-fg:8,preview-bg:0,hl:16,fg+:20,bg+:18,gutter:18,hl+:16,info:3,border:18,prompt:8,pointer:1,marker:5,spinner:3,header:8" \
  HISTFILESIZE=1000000 \
  HISTSIZE=1000000 \
  HISTTIMEFORMAT="[%F %T] " \
  KEYTIMEOUT=1 \
  LC_ALL="en_US.UTF-8" \
  PATH=$HOME/Library/Python/3.8/bin:/usr/local/lib/python3.8/site-packages/pip:/usr/local/bin:$PATH \
  RIPGREP_CONFIG_PATH="$HOME/.ripgreprc" \
  THEME_DARK="material-palenight" \
  THEME_LIGHT="solarized-light" \
  VISUAL="$EDITOR"
