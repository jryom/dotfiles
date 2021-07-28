#!/bin/zsh

source "$DOTDIR/zsh/env.zsh"
PATH="/usr/local/bin/:$PATH"
SUDO_ASKPASS="$HOME/.askpass" \

eval "$(fnm env)"

set -ev

brew update
brew upgrade --greedy
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
