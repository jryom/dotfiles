# shellcheck shell=sh

if command -v brew >/dev/null 2>&1; then
	brew_prefix=$(brew --prefix)
	PATH="$brew_prefix/sbin:$brew_prefix/bin:$brew_prefix/opt/grep/libexec/gnubin:$PATH"
fi

PATH="$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:$PATH"

clean_path=
path_entries=$(printf '%s\n' "$PATH" | tr ':' '\n')
while IFS= read -r entry; do
	[ -n "$entry" ] || continue
	case ":$clean_path:" in
	*":$entry:"*) ;;
	*) clean_path="${clean_path:+$clean_path:}$entry" ;;
	esac
done <<EOF
$path_entries
EOF

PATH=$clean_path
export PATH
