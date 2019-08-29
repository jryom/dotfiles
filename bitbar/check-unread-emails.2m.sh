#!/bin/bash

number=`curl -s -n imaps://imap.fastmail.com -X 'STATUS INBOX (UNSEEN)' | tr -d -c 0-9`
if [ $number -gt 0 ]; then
    echo -e "﫯 $number | font=Iosevka"
  else
    echo -e "\b"
  fi
