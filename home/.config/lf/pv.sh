#!/bin/sh

case $(file --mime-type "$1" -b) in
  text/* | */json) bat -pp --italic-text=always --color=always "$1" ;;
  inode/directory | application/x-directory) exa --color=always --level 1 --all --group-directories-first --tree "$1";;
  * ) mediainfo "$1";;
esac
