#!/bin/bash

# <bitbar.title>Github notifications count</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Jesper Ryom</bitbar.author>
# <bitbar.author.github>jesperryom</bitbar.author.github>
# <bitbar.desc>Displays a simple icon with a count when there are Github notifications</bitbar.desc>
# <bitbar.dependencies>curl, bash</bitbar.dependencies>

notifications=`curl -s -n https://api.github.com/notifications`
length=`echo $notifications | /usr/local/bin/jq length`
if [ $length -gt 0 ]; then
    echo -e " | font='Iosevka Nerd Font' href=https://github.com/notifications trim=true"
fi
