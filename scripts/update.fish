trap "test $status -ne 0 && terminal-notifier -group 'Upgrade script error' \
-title 'Upgrade script' -message 'Upgrade script encountered an error! Check the logs for details.'"

terminal-notifier -title "Upgrade script" -message "Running upgrade script" -group "Upgrade script"

printf     "Running brew update...\n"        | ts
brew       update
printf     "\n\n\n"

printf     "Running brew upgrade...\n"       | ts
brew       upgrade --fetch-HEAD
printf     "\n\n\n"

printf     "Running brew cask upgrade...\n"  | ts
env        SUDO_ASKPASS="$HOME/.askpass" \
brew       cask upgrade --force
printf     "\n\n\n"

printf     "Running brew cleanup...\n"       | ts
brew       cleanup
printf     "\n\n\n"

printf     "Running npm update..."\n         | ts
npm        update -g
printf     "\n\n\n"

printf     "Running fisher self-update...\n" | ts
fisher     self-update
printf     "\n\n\n"

printf     "Running pip-review...\n"         | ts
pip-review --auto

terminal-notifier -title "Upgrade script" -message "Finished running upgrade script" -group "Upgrade script"
printf     "\n\n\n"
