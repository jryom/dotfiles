#!/bin/bash

# <bitbar.title>Fastmail unread messages</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Jesper Ryom</bitbar.author>
# <bitbar.author.github>jesperryom</bitbar.author.github>
# <bitbar.desc>Plugin to display a simple count of unread messages in Fastmail (or any other IMAP server). Reads from .netrc</bitbar.desc>
# <bitbar.dependencies>curl, bash</bitbar.dependencies>


number=`curl -s -n imaps://imap.fastmail.com -X 'STATUS INBOX (UNSEEN)' | tr -d -c 0-9`
if [ $number -gt 0 ]; then
    echo -e "﫯 | font=Iosevka bash=/bin/bash param1=-c param2='/usr/bin/open /applications/mail.app' terminal=false"
fi
