#!/bin/zsh
PATH="/usr/local/bin:$PATH"

USER=$(git config user.email)
TOKEN=$(security find-generic-password -a github_token -w)

curl -s -u $USER:$TOKEN  https://api.github.com/notifications \
   | jq -r '.[] | select(.unread) | [.subject.type, .reason, .subject.title, .repository.owner.avatar_url] | @sh' \
   | xargs -n 4 sh -c \
   'terminal-notifier -group "$2" -title "GitHub Notification" -subtitle "$0 $1" -message "$2" -open "https://github.com/notifications" -appIcon "https://github.com/fluidicon.png" -contentImage "$3"'
