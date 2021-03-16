alias -- -="cd -"
alias cp="cp -riv"
alias find="gfind"
alias grep='grep --color=auto'
alias x="exit"
alias j="z"
alias ls="gls --color=auto"
alias ll="ls -AlFh --group-directories-first"
alias mkdir="mkdir -vp"
alias mv="mv -iv"
alias reset="tput reset"
alias clear="reset"
alias dush="du -sh ./*"

alias ejectall="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)'"
alias n="$EDITOR $HOME/Documents/Notes"
alias sz="source ~/.zshrc && clear"
alias up="zsh $DOTDIR/scripts/update.zsh"
alias vim="$EDITOR"

alias gs="git status --show-stash --verbose --untracked-files --column"
alias gd="git diff"
alias gf="git fetch --all"
alias gl="git pull"
alias gp="git push"

alias nci="npm clean-install"
alias ni="npm install"
alias nise="npm install --save-exact"
alias nrb="npm run build"
alias nrd="npm run dev"
alias ns="npm start"
alias nt="npm test"
alias nu="npm uninstall"

alias y="yarn"
alias ya="yarn add"
alias yad="yarn add -D"

alias ncup="ncu -t patch"
alias ncupu="ncu -t patch -u"
alias ncum="ncu -t minor"
alias ncumu="ncu -t minor -u"
