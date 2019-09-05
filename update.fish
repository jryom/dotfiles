echo ''
echo 'Running brew update'
brew update
echo ''
echo 'Running brew upgrade'
brew upgrade
echo ''
echo 'Running brew cask upgrade'
brew cask upgrade --greedy --force
echo ''
echo 'Running brew cleanup'
brew cleanup
echo ''
echo 'Running npm update'
npm update -g
echo ''
echo 'Running fisher self-update'
fisher self-update
echo ''
echo 'Running pip-review'
pip-review --auto
