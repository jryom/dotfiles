if status is-interactive
    set -gx DARK_MODE_ACTIVE $(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
    if [ $DARK_MODE_ACTIVE = 1 ]
        set -gx BAT_THEME ansi
    else
        set -gx BAT_THEME GitHub
    end
    set -gx GIT_CONFIG_VALUE_0 "$BAT_THEME"

    ### Abbreviations

    abbr ggrep "git rev-list --all | xargs git grep --break"
    abbr ll "exa -lagh --git --group-directories-first"
    abbr n cd '~/Documents/Notes && nvim -c "Oil"'
    abbr s "kitty +kitten ssh"
    abbr up "$HOME/.config/scripts/update"
    abbr y yarn
    abbr ya yarn add
    abbr yad yarn add -D
    abbr gcn git commit --no-verify
    abbr sc "source ~/.config/fish/config.fish"

    ### Init calls

    ssh-add -l &>/dev/null || ssh-add 2>/dev/null
    zoxide init fish --cmd j | source
    direnv hook fish | source

    ### Functions

    function j_and_launch
        if test -d "$argv[2]"; or test -f "$argv[2]"
            $argv[1] "$argv[2]"
        else if test -z "$argv[2]"
            "$argv[1]"
        else
            j "$argv[2]" && "$argv[1]" || $argv[1] "$argv[2]"
        end
    end

    function lf_launcher
        set tmp "$(mktemp)"
        set columns "$(tput cols)"
        set size small

        if [ $columns -gt 200 ]
            set size large
        else if [ $columns -gt 100 ]
            set size medium
        end

        lf -command "$size" -last-dir-path="$tmp"

        if [ -f "$tmp" ]
            set dir "$(cat "$tmp")"
            rm -f "$tmp"
            if [ -d "$dir" ]
                if [ "$dir" != "$(pwd)" ]
                    cd "$dir"
                end
            end
        end
    end

    function l
        j_and_launch lf_launcher "$argv[1]"
    end

    function v
        j_and_launch $EDITOR "$argv[1]"
    end

    function g
        set LG_CONFIG_FILE ~/.config/lazygit/config-shared.yml

        if [ "$DARK_MODE_ACTIVE" = 1 ]
            set -gx LG_CONFIG_FILE "$LG_CONFIG_FILE,$HOME/.config/lazygit/config-dark.yml"
        else
            set -gx LG_CONFIG_FILE "$LG_CONFIG_FILE,$HOME/.config/lazygit/config-light.yml"
        end

        if test (tput cols) -ge 150
            set -gx DELTA_FEATURES "+side-by-side"
        else
            set -gx DELTA_FEATURES -side-by-side
        end

        j_and_launch lazygit "$argv[1]"
    end

    ### Bindings

    function fish_user_key_bindings
        bind -M default \cS "if command -q sudo; fish_commandline_prepend sudo; else if command -q doas; fish_commandline_prepend doas; end"
        bind -M insert \cS "if command -q sudo; fish_commandline_prepend sudo; else if command -q doas; fish_commandline_prepend doas; end"
        bind -M default \cE edit_command_buffer
        bind -M insert \cE edit_command_buffer
        bind -M insert \cZ 'fg 2>/dev/null; commandline -f repaint'
        bind -M default \cZ 'fg 2>/dev/null; commandline -f repaint'
        bind -M insert \cc kill-whole-line repaint
        bind -M default \cc kill-whole-line repaint
        bind -M insert \cl accept-autosuggestion
        bind -M insert \cp history-search-backward
        bind -M insert \cn history-search-forward
        bind -M default \cp history-search-backward
        bind -M default \cn history-search-forward
    end

    fzf_configure_bindings --directory=\ct --variables=\e\cv
end

starship init fish | source
