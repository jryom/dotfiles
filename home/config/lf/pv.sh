#!/bin/sh

case $(file --mime-type "$1" -b) in
text/* | */json) bat -pp --italic-text=always --color=always "$1" ;;
inode/directory | application/x-directory) tree --dirsfirst -I ".DS_Store" -D -pha -C -L 1 "$1" ;;
*) mediainfo "$1" ;;
esac
