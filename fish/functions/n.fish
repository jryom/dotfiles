export NNN_TMPFILE="/tmp/nnn"

function n --description 'support nnn quit and change directory'
        nnn -d $argv

        if test -e $NNN_TMPFILE
                source $NNN_TMPFILE
                rm $NNN_TMPFILE
        end
end
