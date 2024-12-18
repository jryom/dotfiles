#!/usr/bin/env dash

file=$1
w=$2
h=$3
x=$4
y=$5

case $(file -Lb --mime-type "$1") in
image*) kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" </dev/null >/dev/tty && exit 1 ;;
text/* | */json) bat -pp --italic-text=always --color=always "$1" ;;
inode/directory | application/x-directory) eza --all --tree --group-directories-first -I ".DS_Store" --color=always -L 1 "$1" ;;
esac
