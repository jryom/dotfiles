# shellcheck shell=sh

if command -v brew >/dev/null 2>&1; then
	brew_prefix=$(brew --prefix)
	PATH="$brew_prefix/sbin:$brew_prefix/bin:$brew_prefix/opt/grep/libexec/gnubin:$PATH"
fi

if command -v python3 >/dev/null 2>&1; then
	python_user_bin=$(python3 -c 'import site; print(site.USER_BASE)')/bin
	PATH="$python_user_bin:$PATH"
fi

PATH="$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:$PATH"

clean_path=
path_entries=$(printf '%s\n' "$PATH" | tr ':' '\n')
while IFS= read -r entry; do
	[ -n "$entry" ] || continue
	if [ -n "${DEV_HOME:-}" ] && [ "$entry" = "$DEV_HOME/pnpm-global/bin" ]; then
		continue
	fi
	case "$entry" in
	"$HOME/.pnpm" | "$HOME/.pnpm/bin" | \
		/Applications/Docker.app/Contents/Resources/bin | /opt/homebrew/opt | /opt/homebrew/opt/mise/bin)
		continue
		;;
	esac
	case ":$clean_path:" in
	*":$entry:"*) ;;
	*) clean_path="${clean_path:+$clean_path:}$entry" ;;
	esac
done <<EOF
$path_entries
EOF

PATH=$clean_path
export PATH
