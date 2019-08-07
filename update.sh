#!/bin/bash
/usr/local/bin/brew update
/usr/local/bin/brew upgrade
/usr/local/bin/nvim "+silent! PackUpdate" "+silent! UpdateRemotePlugins" +qall
/urs/local/bin/npm update -g
cd ~/.tmux/base16-tmux && git fetch && git pull
