#!/bin/bash
# add the following to /etc/sudoers (sudo visudo):
# # allow speedy_tm to set throttle
# user ALL=(root) NOPASSWD: /usr/sbin/sysctl debug.lowpri_throttle_enabled=1
# user ALL=(root) NOPASSWD: /usr/sbin/sysctl debug.lowpri_throttle_enabled=0

export PATH="/usr/local/bin:$PATH"

while ! diskutil list | grep timemachine ;
do
  sleep 120
done

trap 'ret=$?; test $ret -ne 0 && terminal-notifier -group "Backup error" -title "Timemachine" -message "Backup script encountered an error!"; exit $ret' EXIT
set -e

set_throttle() {
   CURRENT_VAL=$(sysctl debug.lowpri_throttle_enabled | awk '{ print $2 }')
   if [[ $1 != $CURRENT_VAL ]]; then
      sudo sysctl debug.lowpri_throttle_enabled=$1
   fi
}

terminal-notifier -title "Timemachine" -message "Starting backup..." -group "Timemachine"

set_throttle 0

diskutil mount timemachine

caffeinate -s tmutil startbackup -b; diskutil eject timemachine

set_throttle 1

terminal-notifier -title "Timemachine" -message "Backup finished! Drive ejected." -group "Timemachine"
