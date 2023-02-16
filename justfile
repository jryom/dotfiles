#!/usr/bin/env just --justfile

default: install

install: gatekeeper system-preferences keyboard-layout touch-id brew stow node npm pip fisher misc

stow:
    stow --restow --target $HOME --dir {{ justfile_directory() }} --ignore "\.DS_Store" home

brew:
    brew bundle install --file="{{ justfile_directory() }}/etc/Brewfile" --force --no-lock

node:
    fnm install --lts 
    fnm use lts-latest
    fnm default lts-latest

npm:
    npm install -g $(cat "{{ justfile_directory() }}/etc/global_node_modules" | tr "\n" " ")

pip:
    python3 -m pip install --user --upgrade pynvim black

misc:
    echo y | "$(brew --prefix)"/opt/fzf/install
    -brew services start koekeishiya/formulae/yabai
    -brew services start koekeishiya/formulae/skhd
    if [ ! -f /private/etc/sudoers.d/yabai ]; then sudo zsh -c "echo '$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa' >> /private/etc/sudoers.d/yabai"; fi 

fisher:
    fish -c 'fisher update'

system-preferences:
    defaults write -g AppleSpacesSwitchOnActivate -bool false
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock mru-spaces -bool false
    defaults write com.apple.dock show-recents -bool false
    defaults write com.apple.dock static-only -bool true
    defaults write com.apple.dock tilesize -int 48
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.finder CreateDesktop 0
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool YES
    defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
    defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
    killall Dock

touch-id:
    cat /etc/pam.d/sudo | grep "pam_tid.so" || sudo gsed -i '3 i auth       sufficient     pam_tid.so' /etc/pam.d/sudo

gatekeeper:
    if spctl --status >/dev/null; then sudo spctl --master-disable; fi

keyboard-layout:
    cp -r "{{ justfile_directory() }}/etc/da-no-dead-keys.bundle" "$HOME/Library/Keyboard Layouts"
    sudo ln -sf "{{ justfile_directory() }}/bin/keyboardSwitcher" "/usr/local/bin/keyboardSwitcher"

shell:
    cat /etc/shells | grep $(which fish) &>/dev/null || echo $(which fish) | sudo tee -a /etc/shells
    chsh -s $(which fish)
    sudo dscl . -create /Users/$USER UserShell $(which fish)
