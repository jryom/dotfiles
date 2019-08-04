#!/bin/bash
echo "`date`: RUNNING: brew update"
/usr/local/bin/brew update
echo "`date`: FINISHED: brew update"
echo "`date`: RUNNING: brew upgrade"
/usr/local/bin/brew upgrade
echo "`date`: FINISHED: brew upgrade"
echo "RUNNING: nvim updates"
/usr/local/bin/nvim "+silent! PackUpdate" "+silent! UpdateRemotePlugins" +qall
echo "FINISHED: nvim updates"
echo "RUNNING: npm update -g"
/urs/local/bin/npm update -g
echo "FINISHED: npm update -g"
