#!/opt/homebrew/bin/dash

PATH=/opt/homebrew/bin:$HOME/.pnpm:$PATH

headphones_id=$(macos-audio-devices list | grep -i "external headphones" | awk '{print $1}')
current_volume=$(macos-audio-devices volume get "$headphones_id")

clamp() {
  if [ "$(echo "$1 < 0" | bc)" -ne 0 ]; then
    echo 0
  elif [ "$(echo "$1 > 1" | bc)" -ne 0 ]; then
    echo 1
  else
    echo "$1"
  fi
}

if [ "$1" = "inc" ]; then
  new_volume=$(echo "$current_volume + $2" | bc)
elif [ "$1" = "dec" ]; then
  new_volume=$(echo "$current_volume - $2" | bc)
fi

macos-audio-devices volume set "$headphones_id" "$(clamp "$new_volume")"
