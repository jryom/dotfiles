#!/bin/zsh

source "$DOTDIR/zsh/env.zsh"
PATH="/usr/local/bin/:$PATH"
SUDO_ASKPASS="$HOME/.askpass" \

eval "$(fnm env)"

trap 'ret=$?; test $ret -ne 0 && terminal-notifier -group "Upgrade script" -title "Upgrade script" -message "Encountered an error! Check the logs for details."; exit $ret' EXIT
set -ev

terminal-notifier -title "Upgrade script" -message "Running..." -group "Upgrade script"

brew update
brew upgrade --fetch-HEAD --greedy
HOMEBREW_CLEANUP_MAX_AGE_DAYS=60
brew cleanup

fnm install --lts && fnm use lts-latest && fnm default lts-latest

installed="$(npm ls --global --json --depth 0 | jq '.dependencies | length')"
required="$(wc -l < $DOTDIR/npm-global-packages | xargs)"
if (( $installed < $required )); then npm install -g $(cat "$DOTDIR/npm-global-packages" | tr '\n' ' '); fi

for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
do
	npm -g install "$package"
done

tldr --update

antibody bundle < "$DOTDIR/zsh/zsh_plugins" > ~/.zsh_plugins

python3 -m pip install --user --upgrade $(cat "$DOTDIR/pip-packages" | tr '\n' ' ')

terminal-notifier -title "Upgrade script" -message "Finished!" -group "Upgrade script"

date +'%s' > "/tmp/lastupdatesys"
