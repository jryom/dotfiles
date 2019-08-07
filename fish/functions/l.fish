function l
    set tmp (mktemp)
    set columns (tput cols)
    if test $columns -lt 70 
        lf -command "tiny" -last-dir-path=$tmp $argv
    else if test $columns -lt 100
        lf -command "small" -last-dir-path=$tmp $argv
    else if test $columns -lt 200
        lf -command "medium" -last-dir-path=$tmp $argv
    else
        lf -command "large" -last-dir-path=$tmp $argv
    end 
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end
