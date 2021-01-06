alias -- -="cd -"
alias cp="cp -riv"
alias find="find ./ -name"
alias findd="find ./ -type d -name"
alias grep='grep --color=auto'
alias x="exit"
alias ls="exa --all --group-directories-first --long --git --header"
alias mkdir='mkdir -vp'
alias mv="mv -iv"

alias ejectall="osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'"
alias sz="source ~/.zshrc && clear"
alias up="zsh $DOTDIR/scripts/update.zsh"
alias v="$EDITOR"
alias vim="$EDITOR"
alias w="$EDITOR $HOME/Documents/vimwiki/index.wiki"

alias g="lazygit"
alias gs="git status --show-stash --verbose --untracked-files --column"
alias gd="git diff"
alias gf="git fetch"
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

alias ncup="ncu -t patch"
alias ncupu="ncu -t patch -u"
alias ncum="ncu -t minor"
alias ncumu="ncu -t minor -u"
