trap "test $status -ne 0 && terminal-notifier -group 'Upgrade script error' \
-title 'Upgrade script' -message 'Upgrade script encountered an error! Check the logs for details.'"

terminal-notifier -title "Upgrade script" -message "Running upgrade script" -group "Upgrade script"

printf     "\n\nRunning brew update...\n"        | ts
brew       update                                | ts

printf     "\n\nRunning brew upgrade...\n"       | ts
brew       upgrade --fetch-HEAD                  | ts

printf     "\n\nRunning brew cask upgrade...\n"  | ts
env        SUDO_ASKPASS="$HOME/.askpass" \
brew       cask upgrade --greedy --force         | ts

printf     "\n\nRunning brew cleanup...\n"       | ts
brew       cleanup                               | ts

printf     "\n\nRunning npm update..."\n         | ts
npm        update -g                             | ts

printf     "\n\nRunning fisher self-update...\n" | ts
fisher     self-update                           | ts

printf     "\n\nRunning pip-review...\n"         | ts
pip-review --auto                                | ts

terminal-notifier -title "Upgrade script" -message "Finished running upgrade script" -group "Upgrade script"
