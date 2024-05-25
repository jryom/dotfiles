#!/usr/bin/env just --justfile

default: install

install: gatekeeper system-preferences mise brew pip fish-globals dotbot fisher virtualfish pnpm misc gh

dotbot:
    #!/usr/bin/env fish
    dotbot --config-file "{{ justfile_directory() }}/configs/dotbot.yaml" --base-directory "{{ justfile_directory() }}" --quiet
    set dotfiles_private "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/dotfiles-private"
    brctl download "$dotfiles_private"
    dotbot --config-file "$dotfiles_private/configs/dotbot.yaml" --base-directory "$dotfiles_private" --quiet

brew:
    brew bundle install --file="{{ justfile_directory() }}/configs/brewfile" --force --no-lock

brew-personal:
    brew bundle install --file="{{ justfile_directory() }}/configs/brewfile_personal" --force --no-lock

gh:
    #!/usr/bin/env bash
    while IFS= read -r line; do
        echo $line
        gh extension install --force "$line"
    done < "{{ justfile_directory() }}/configs/gh_extensions"

mise:
    #!/usr/bin/env bash
    mkdir -p "$HOME/.config/mise"
    cp "{{ justfile_directory() }}/home/config/mise/config.toml" "$HOME/.config/mise/config.toml"
    brew install mise
    mise install --yes

pnpm:
    #!/usr/bin/env fish
    pnpm add --global (cat "{{ justfile_directory() }}/configs/global_node_modules")

pip:
    #!/usr/bin/env fish
    pip install --upgrade --requirement "{{ justfile_directory() }}/configs/requirements.txt"

misc:
    echo y | "$(brew --prefix)"/opt/fzf/install --no-bash --no-zsh
    sudo bash -c "echo '$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa'  > /private/etc/sudoers.d/yabai"
    -yabai --start-service
    -skhd --start-service

fisher:
    #!/usr/bin/env fish
    fisher update

virtualfish:
    #!/usr/bin/env fish
    vf install auto_activation
    vf addplugins global_requirements

fish-globals:
    #!/usr/bin/env fish
    set -U fish_key_bindings fish_vi_key_bindings
    set -U fish_cursor_default block
    set -U fish_cursor_insert line
    set -U fish_cursor_replace_one underscore
    set -U fish_cursor_visual block

    set -U brew_prefix (brew --prefix)
    set -U fish_greeting
    set -Ux fzf_fd_opts --color never
    set -Ux BAT_STYLE full
    set -Ux CLICOLOR 1
    set -Ux DFT_COLOR always
    set -Ux DFT_TAB_WIDTH 2
    set -Ux EDITOR nvim
    set -Ux ESCDELAY 0
    set -Ux FZF_COMPLETE 1
    set -Ux FZF_CTRL_T_COMMAND "rg --files"
    set -Ux FZF_CTRL_T_OPTS "--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}' --sceme path"
    set -Ux FZF_DEFAULT_COMMAND "rg --files"
    set -Ux FZF_DEFAULT_OPTS "$FZF_THEME --no-separator --info hidden"
    set -Ux FZF_ENABLE_OPEN_PREVIEW 1
    set -Ux FZF_LEGACY_KEYBINDINGS 0
    set -Ux FZF_THEME '--color fg:7,bg:0,hl:6,fg+:7,bg+:8,hl+:3,info:15,prompt:1,pointer:5,marker:2,spinner:3,header:6,gutter:0'
    set -Ux INFOPATH $INFOPATH "$brew_prefix/share/info"
    set -Ux KEYTIMEOUT 1
    set -Ux MANPATH $MANPATH "$brew_prefix/share/man"
    set -Ux PNPM_HOME "$HOME/.pnpm"
    set -Ux RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
    set -Ux VISUAL "$EDITOR"

    fish_add_path $(python3 -c "import site; print(site.USER_BASE)")/bin
    fish_add_path --prepend $brew_prefix/opt $brew_prefix/sbin $brew_prefix/bin
    fish_add_path ./node_modules/.bin
    fish_add_path $HOME/.pnpm
    fish_add_path $HOME/go/bin
    fish_add_path $brew_prefix/opt/postgresql@16/bin

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

    # Prompt
    ### General
    set -U tide_prompt_add_newline_before true
    set -U tide_prompt_color_frame_and_connection brblack
    set -U tide_prompt_color_separator_same_color brblack
    set -U tide_prompt_icon_connection '─'

    set -U tide_prompt_transient_enabled true

    ### Icons
    set -U tide_character_icon ❱
    set -U tide_character_vi_icon_default ❰
    set -U tide_character_vi_icon_replace ▶
    set -U tide_character_vi_icon_visual v
    set -U tide_cmd_duration_icon
    set -U tide_direnv_icon " "
    set -U tide_git_icon 
    set -U tide_jobs_icon +
    set -U tide_node_icon 󰎙
    set -U tide_pwd_icon
    set -U tide_pwd_icon_home
    set -U tide_pwd_icon_unwritable 
    set -U tide_python_icon 󰌠
    set -U tide_ruby_icon 
    set -U tide_shlvl_icon 
    set -U tide_status_icon ✔
    set -U tide_status_icon_failure ✘
    set -U tide_terraform_icon 󱁢
    set -U tide_vi_mode_icon_default d
    set -U tide_vi_mode_icon_insert i
    set -U tide_vi_mode_icon_replace r
    set -U tide_vi_mode_icon_visual v

    ### Left
    set -U tide_left_prompt_items pwd direnv git node python ruby go terraform newline jobs character
    set -U tide_character_color brwhite
    set -U tide_character_color_failure brred
    set -U tide_left_prompt_frame_enabled false

    set -U tide_git_color_branch brblack
    set -U tide_git_color_conflicted brred
    set -U tide_git_color_dirty bryellow
    set -U tide_git_color_operation brred
    set -U tide_git_color_staged bryellow
    set -U tide_git_color_stash brgreen
    set -U tide_git_color_untracked brblue
    set -U tide_git_color_upstream brgreen
    set -U tide_go_color brblack
    set -U tide_jobs_color yellow --bold
    set -U tide_node_color brblack
    set -U tide_pwd_color_anchors brwhite --bold
    set -U tide_pwd_color_dirs brwhite
    set -U tide_pwd_color_truncated_dirs brwhite
    set -U tide_python_color brblack
    set -U tide_shlvl_color yellow
    set -U tide_terraform_color brblack
    set -U tide_vi_mode_color_default white
    set -U tide_vi_mode_color_insert cyan
    set -U tide_vi_mode_color_replace green
    set -U tide_vi_mode_color_visual yellow


    ### Right
    set -U tide_right_prompt_items status cmd_duration context toolbox time

    set -U tide_cmd_duration_color brblack
    set -U tide_context_color_default yellow
    set -U tide_context_color_root bryellow
    set -U tide_context_color_ssh yellow
    set -U tide_direnv_color white
    set -U tide_direnv_color_denied brred
    set -U tide_status_color green
    set -U tide_status_color_failure red
    set -U tide_time_color brwhite

    exit 0

system-preferences:
    defaults write -g AppleSpacesSwitchOnActivate -bool false
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    defaults write com.apple.TextEdit RichText -bool false
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0.2
    defaults write com.apple.dock mru-spaces -bool false
    defaults write com.apple.dock show-recents -bool false
    defaults write com.apple.dock static-only -bool true
    defaults write com.apple.dock tilesize -int 48
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool YES
    defaults write com.apple.mail DisableInlineAttachmentViewing -bool yes
    defaults write com.apple.menuextra.clock "DateFormat" -string "HH:mm"
    killall Dock

gatekeeper:
    if spctl --status >/dev/null; then sudo spctl --master-disable; fi

shell:
    cat /etc/shells | grep $(which fish) &>/dev/null || echo $(which fish) | sudo tee -a /etc/shells
    cat /etc/shells | grep $(which bash) &>/dev/null || echo $(which bash) | sudo tee -a /etc/shells
    cat /etc/shells | grep $(which dash) &>/dev/null || echo $(which dash) | sudo tee -a /etc/shells
    chsh -s $(which dash)

init-dotfiles:
    mkdir "{{ justfile_directory() }}/.git"
    touch "{{ justfile_directory() }}/.git/.nosync"
    git init
    git remote add origin https://github.com/jryom/dotfiles.git
    git fetch origin
    git commit --allow-empty -m "init"
    git add -A
    git stash
    git checkout -b main origin/main
    git stash pop
