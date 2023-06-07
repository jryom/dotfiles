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
    python3 -m pip install --user --upgrade pynvim black pyright

misc:
    echo y | "$(brew --prefix)"/opt/fzf/install
    -yabai --start-service
    -skhd --start-service
    if [ ! -f /private/etc/sudoers.d/yabai ]; then sudo zsh -c "echo '$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa'  >> /private/etc/sudoers.d/yabai"; fi

fisher:
    fish -c 'fisher update'

fish-globals:
    #!/usr/bin/env fish
    set -U brew_prefix (brew --prefix)
    set -U PYENV_ROOT $HOME/.pyenv

    fish_add_path --prepend "$brew_prefix/opt" "$brew_prefix/sbin" "$brew_prefix/bin"
    fish_add_path --append 'node_modules/.bin'
    fish_add_path $PYENV_ROOT/bin

    set -U fish_key_bindings fish_vi_key_bindings
    set -U fish_cursor_default block
    set -U fish_cursor_insert line
    set -U fish_cursor_replace_one underscore
    set -U fish_cursor_visual block


    set -U fish_greeting
    set -Ux BAT_STYLE full
    set -Ux CLICOLOR 1
    set -Ux EDITOR nvim
    set -Ux ESCDELAY 0
    set -Ux FZF_COMPLETE 1
    set -Ux FZF_CTRL_T_COMMAND "rg --files"
    set -Ux FZF_CTRL_T_OPTS "--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}' --sceme path"
    set -Ux FZF_DEFAULT_COMMAND "rg --files"
    set -Ux FZF_THEME '--color fg:7,bg:0,hl:6,fg+:7,bg+:8,hl+:3,info:15,prompt:1,pointer:5,marker:2,spinner:3,header:6,gutter:0'
    set -Ux FZF_DEFAULT_OPTS "$FZF_THEME --no-separator --info hidden"
    set -Ux FZF_ENABLE_OPEN_PREVIEW 1
    set -Ux FZF_LEGACY_KEYBINDINGS 0
    set -Ux GIT_CONFIG_COUNT 1
    set -Ux GIT_CONFIG_KEY_0 "delta.syntax-theme"
    set -Ux INFOPATH $INFOPATH "$brew_prefix/share/info"
    set -Ux KEYTIMEOUT 1
    set -Ux MANPATH $MANPATH "$brew_prefix/share/man"
    set -Ux RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
    set -Ux VISUAL "$EDITOR"
    set -Ux fzf_fd_opts --color never

    # Colors
    set -U fish_color_autosuggestion brblack -d
    set -U fish_color_cancel red
    set -U fish_color_command white -o
    set -U fish_color_comment brblack
    set -U fish_color_end brwhite -b
    set -U fish_color_error brred
    set -U fish_color_escape yellow
    set -U fish_color_history_current --bold
    set -U fish_color_keyword brblack
    set -U fish_color_normal white
    set -U fish_color_operator white -b
    set -U fish_color_param white
    set -U fish_color_quote white -i -d
    set -U fish_color_redirection white -b
    set -U fish_color_search_match yellow
    set -U fish_color_selection --background=white -d
    set -U fish_color_status red
    set -U fish_color_valid_path --underline
    set -U fish_pager_color_completion normal -d
    set -U fish_pager_color_description normal -d
    set -U fish_pager_color_progress brblack
    set -U fish_pager_color_selected_background --background=brblack
    set -U fish_pager_color_selected_completion white
    set -U fish_pager_color_selected_description white
    set -U fish_pager_color_selected_prefix red
    exit 0

system-preferences:
    defaults write -g AppleSpacesSwitchOnActivate -bool false
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0.2
    defaults write com.apple.dock mru-spaces -bool false
    defaults write com.apple.dock show-recents -bool false
    defaults write com.apple.dock static-only -bool true
    defaults write com.apple.dock tilesize -int 48
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.finder CreateDesktop 0
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool YES
    defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
    defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
    defaults write com.apple.TextEdit RichText -bool false
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
