export PATH="$PATH:$HOME/.spicetify"

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if [ -r "$HOME/.config/shell/path.sh" ]; then
    . "$HOME/.config/shell/path.sh"
fi
