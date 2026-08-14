# shellcheck shell=sh

if command -v fish >/dev/null 2>&1; then
	# shellcheck disable=SC2016
	fish_user_paths=$(fish -c 'string join : $fish_user_paths')
	[ -n "$fish_user_paths" ] && PATH="$fish_user_paths:$PATH"
fi

clean_path=
path_entries=$(printf '%s\n' "$PATH" | tr ':' '\n')
while IFS= read -r entry; do
	[ -n "$entry" ] || continue
	case "$entry" in
	"$HOME/.pnpm" | "$HOME/.pnpm/bin" | "$HOME/Library/Application Support/Code/pnpm-global/bin" | \
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
