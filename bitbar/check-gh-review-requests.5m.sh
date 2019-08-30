#!/bin/bash

# <bitbar.title>Github notifications count</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Jesper Ryom</bitbar.author>
# <bitbar.author.github>jesperryom</bitbar.author.github>
# <bitbar.desc>Displays a simple icon with a count when there are Github notifications</bitbar.desc>
# <bitbar.dependencies>curl, bash</bitbar.dependencies>

reviewRequests=`curl -s -n https://api.github.com/search/issues\?q\=review-requested:jesperryom+type:pr+state:open`
length=`echo $reviewRequests | /usr/local/bin/jq '.total_count'`
if [ $length -gt 0 ]; then
    echo -e " | font='Iosevka Nerd Font' href=https://github.com/pulls/review-requested"
  else
    echo -e "\b"
  fi
