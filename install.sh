#!/usr/bin/env bash

set -ex

# Ask for the sudo permission and keep valid until EOF
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

DOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

export DOT_DIR
source "$DOT_DIR/install-scripts/macos.sh"
source "$DOT_DIR/install-scripts/dependencies.sh"
