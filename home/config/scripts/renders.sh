#!/usr/bin/env bash

EXPORT_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Ableton/Exports"
IMPORT_DIR="$HOME/Music/Music/Media.localized/Automatically Add to Music.localized"
RENDERS_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Renders"

cd "$EXPORT_DIR" || exit 1

if test $(find . -name "*.mp3" | wc -c) -eq 0; then
  exit 0
fi

TIME=$(date +%y-%m-%dT%H-%M)

for f in *.mp3; do
  mv "$f" "${TIME} $f"
done

find "$EXPORT_DIR" -name '*.mp3' -exec cp {} "$IMPORT_DIR" \; -exec mv {} "$RENDERS_DIR" \;
