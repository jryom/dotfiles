test -r ~/.config/fish/env.fish; and source ~/.config/fish/env.fish

if status is-interactive
    if defaults read -g AppleInterfaceStyle 2>/dev/null | string match -q Dark
        set -g _appearance dark
        set -gx BAT_THEME ansi
        set -gx DELTA_FEATURES dark-mode
    else
        set -g _appearance light
        set -gx BAT_THEME GitHub
        set -gx DELTA_FEATURES light-mode
    end
    ### Abbreviations

    abbr up "$HOME/.config/scripts/update"

    abbr delete_branch_workflow_runs 'gh run list --branch (git rev-parse --abbrev-ref HEAD) --json databaseId --jq \'.[].databaseId\' | xargs -IID -P10 env CI=true gh run delete ID'
    abbr delete_manual_workflow_runs 'CI=true gh run list --user=jryom --event=workflow_dispatch --limit 1000 --json databaseId --jq '.[].databaseId' | xargs -P 20 -I {} bash -c "CI=true gh run delete {}"'

    ### Init calls

    ssh-add -l &>/dev/null; or ssh-add 2>/dev/null

    zoxide init fish --cmd j | source
    mise activate fish | source
    for path in "$HOME/.pnpm" "$HOME/.pnpm/bin" "$DEV_HOME/pnpm-global/bin" \
            /Applications/Docker.app/Contents/Resources/bin /opt/homebrew/opt \
            /opt/homebrew/opt/mise/bin
        set -gx PATH (string match -v -- "$path" $PATH)
    end
    set -e PNPM_HOME
    direnv hook fish | source

    ### Functions

    function oas
        open http://localhost:8080 &
        podman run --rm -p 8080:8080 -e PERSIST_AUTHORIZATION=true -e SWAGGER_JSON=/spec/$argv[1] -v (pwd):/spec swaggerapi/swagger-ui
    end

    function j_and_launch
        set -l launcher $argv[1]
        set -l target $argv[2]
        set -l extra $argv[3..-1]

        if test -d "$target"; or test -f "$target"
            $launcher "$target" $extra
        else if test -z "$target"
            $launcher $extra
        else if j "$target"
            $launcher $extra
        else
            $launcher "$target" $extra
        end
    end

    function yazi_launcher
        set tmp (mktemp -t yazi-cwd.XXXXXX)
        yazi $argv --cwd-file="$tmp"

        set dir (string trim <"$tmp")
        rm -f "$tmp"
        if test -n "$dir"; and test "$dir" != "$PWD"
            cd "$dir"
        end
    end

    function l
        j_and_launch yazi_launcher $argv
    end

    function v
        j_and_launch $EDITOR $argv
    end

    function g
        set -lx LG_CONFIG_FILE ~/.config/lazygit/config-shared.yml

        if test "$_appearance" = dark
            set LG_CONFIG_FILE "$LG_CONFIG_FILE,$HOME/.config/lazygit/config-dark.yml"
        else
            set LG_CONFIG_FILE "$LG_CONFIG_FILE,$HOME/.config/lazygit/config-light.yml"
        end

        j_and_launch lazygit $argv
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

    function delta_sidebyside --on-signal WINCH
        if test "$COLUMNS" -ge 120; and ! contains side-by-side $DELTA_FEATURES
            set --global --export --append DELTA_FEATURES side-by-side
        else if test "$COLUMNS" -lt 120; and contains side-by-side $DELTA_FEATURES
            set --erase DELTA_FEATURES[(contains --index side-by-side $DELTA_FEATURES)]
        end
    end
    delta_sidebyside

    starship init fish | source
end
