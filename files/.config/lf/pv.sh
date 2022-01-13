#!/bin/sh

case $(file --mime-type "$1" -b) in
  text/* | */json) bat -pp --italic-text=always --color=always "$1";;
  video/*) mediainfo "$1";;
  archive/*) atool "$1";;
esac
