#!/usr/bin/env bash
echo "running"
sleep 3

INPUT_DIR="$HOME/Downloads/splice"
OUTPUT_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Ableton/User Library/Sample Library/Splice"

if [ ! -d "$INPUT_DIR" ]; then
  exit 1
fi


if test $(find "$INPUT_DIR" -type f -iname "*.wav" | wc -c) -eq 0; then
  exit 0
fi

mkdir "$OUTPUT_DIR/kicks"
mkdir "$OUTPUT_DIR/snares"
mkdir "$OUTPUT_DIR/claps"
mkdir "$OUTPUT_DIR/rides"
mkdir "$OUTPUT_DIR/rimshots"
mkdir "$OUTPUT_DIR/cymbals"
mkdir "$OUTPUT_DIR/hihats"
mkdir "$OUTPUT_DIR/loops"
mkdir "$OUTPUT_DIR/snaps"
mkdir "$OUTPUT_DIR/toms"
mkdir "$OUTPUT_DIR/percussion"
mkdir "$OUTPUT_DIR/shakers"
mkdir "$OUTPUT_DIR/fills"
mkdir "$OUTPUT_DIR/unsorted"

find -E "$INPUT_DIR" -type f -iregex ".*\.wav" -exec mv "{}" "$INPUT_DIR/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(shaker|egg|tamb).*\.wav" -exec mv "{}" "$OUTPUT_DIR/shakers/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(loop).*\.wav" -exec mv {} "$OUTPUT_DIR/loops/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(crash|cymbal).*\.wav" -exec mv "{}" "$OUTPUT_DIR/cymbals/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(kick).*\.wav" -exec mv {} "$OUTPUT_DIR/kicks/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(snare).*\.wav" -exec mv "{}" "$OUTPUT_DIR/snares/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(rim).*\.wav" -exec mv "{}" "$OUTPUT_DIR/rimshots/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(snap|finger).*\.wav" -exec mv "{}" "$OUTPUT_DIR/snaps/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(tom).*\.wav" -exec mv "{}" "$OUTPUT_DIR/toms/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(clav|perc).*\.wav" -exec mv "{}" "$OUTPUT_DIR/percussion/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(clap|clp).*\.wav" -exec mv "{}" "$OUTPUT_DIR/claps/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(ride).*\.wav" -exec mv "{}" "$OUTPUT_DIR/rides/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(hat).*\.wav" -exec mv "{}" "$OUTPUT_DIR/hihats/" \;
find -E "$INPUT_DIR" -type f -iregex ".*(fills).*\.wav" -exec mv "{}" "$OUTPUT_DIR/fills/" \;
find -E "$INPUT_DIR" -type f -iregex ".*\.wav" -exec mv "{}" "$OUTPUT_DIR/unsorted/" \;
find "$INPUT_DIR" -type f -iname ".ds_store" -exec rm "{}" \;
find "$INPUT_DIR" -type d -empty -delete
