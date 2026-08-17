#!/usr/bin/env bash

if [ -x /opt/homebrew/bin/mise ]; then
	eval "$(/opt/homebrew/bin/mise activate bash)"
fi

# shellcheck disable=SC1091
if [ -r "$HOME/.config/shell/path.sh" ]; then . "$HOME/.config/shell/path.sh"; fi

if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init bash --cmd j)"; fi

alias ll="ls -lah --color=never"
alias ..="cd .."

set -o vi
