#!/usr/bin/env bash

set -ex

# Ask for the sudo permission and keep valid until EOF
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export SCRIPT_PATH
source "$SCRIPT_PATH/install-scripts/macos.sh"
source "$SCRIPT_PATH/install-scripts/dependencies.sh"

stow --no-folding --target $HOME --dir $SCRIPT_PATH --restow --ignore "\.DS_Store" files
