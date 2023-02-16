fish_add_path --prepend "$(brew --prefix)/opt" "$(brew --prefix)/sbin" "$(brew --prefix)/bin"
fish_add_path --append 'node_modules/.bin' $(find $HOME/Library/Python -maxdepth 2 -type d | tr '\n' ':') $(python3 -c "import sysconfig; print(sysconfig.get_path('purelib'))")

set -gx WM_OPACITY "0.85"

if status is-interactive
    set -U fish_greeting

    ### Variables

    set -gx BAT_STYLE full
    set -gx DARK_MODE_ACTIVE $(defaults read -g AppleInterfaceStyle &>/dev/null && echo 1 || echo 0)
    if [ $DARK_MODE_ACTIVE = 1 ]
        set -gx BAT_THEME ansi
    else
        set -gx BAT_THEME GitHub
    end
    set -gx CLICOLOR 1
    set -gx EDITOR nvim
    set -gx ESCDELAY 0
    set -gx FZF_CTRL_T_COMMAND "rg --files"
    set -gx FZF_CTRL_T_OPTS "--delimiter '/' --nth '-1' --preview '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat {}) || echo {}' --sceme path"
    set -gx FZF_DEFAULT_COMMAND "rg --files"
    set -gx FZF_THEME '--color fg:7,bg:0,hl:6,fg+:7,bg+:8,hl+:3,info:15,prompt:1,pointer:5,marker:2,spinner:3,header:6,gutter:0'
    set -gx FZF_DEFAULT_OPTS "$FZF_THEME --no-separator --info hidden"
    set -gx FZF_COMPLETE 1
    set -gx FZF_LEGACY_KEYBINDINGS 0
    set -gx FZF_ENABLE_OPEN_PREVIEW 1
    set -gx GIT_CONFIG_COUNT 1
    set -gx GIT_CONFIG_KEY_0 "delta.syntax-theme"
    set -gx GIT_CONFIG_VALUE_0 "$BAT_THEME"
    set -gx INFOPATH $INFOPATH "$(brew --prefix)/share/info"
    set -gx KEYTIMEOUT 1
    set -gx MANPATH $MANPATH "$(brew --prefix)/share/man"
    set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
    set -gx VISUAL "$EDITOR"
    set -gx fzf_fd_opts --color never

    ### Abbreviations

    abbr ggrep "git rev-list --all | xargs git grep --break"
    abbr ll "exa -lagh --git --group-directories-first"
    abbr n cd '~/Documents/Notes && nvim -c Explore'
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
    starship init fish | source

    ### Functions

    function updateWindowManagerSpacing
        begin
            system_profiler SPDisplaysDataType | grep "Looks like" | awk '{print int($6/60)}'
            system_profiler SPDisplaysDataType | grep Resolution | awk '{print int($4/120)}'
        end | tee /tmp/screen_height
    end

    function j_and_launch
        if test -d "$argv[2]"; or test -f "$argv[2]"
            $argv[1] "$argv[2]"
        else if test -z "$argv[2]"
            "$argv[1]"
        else
            j "$argv[2]" && "$argv[1]"
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

    set -g fish_key_bindings fish_vi_key_bindings

    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

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

    ### Colors

    set -gx fish_color_autosuggestion brblack -d
    set -gx fish_color_cancel red
    set -gx fish_color_command white -o
    set -gx fish_color_comment brblack
    set -gx fish_color_end brwhite -b
    set -gx fish_color_error brred
    set -gx fish_color_escape yellow
    set -gx fish_color_history_current --bold
    set -gx fish_color_keyword brblack
    set -gx fish_color_normal white
    set -gx fish_color_operator white -b
    set -gx fish_color_param white
    set -gx fish_color_quote white -i -d
    set -gx fish_color_redirection white -b
    set -gx fish_color_search_match yellow
    set -gx fish_color_selection --background=white -d
    set -gx fish_color_status red
    set -gx fish_color_valid_path --underline
    set -gx fish_pager_color_completion normal -d
    set -gx fish_pager_color_description normal -d
    set -gx fish_pager_color_progress brblack
    set -gx fish_pager_color_selected_background --background=brblack
    set -gx fish_pager_color_selected_completion white
    set -gx fish_pager_color_selected_description white
    set -gx fish_pager_color_selected_prefix red
end
