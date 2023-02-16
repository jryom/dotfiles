#!/usr/bin/env bash

if ! command -v brew >/dev/null; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  export PATH="/opt/homebrew/bin:$PATH"
fi

brew install just

just install
