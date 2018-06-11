# Defined in /tmp/fish.MAtCKx/select_x_session.fish @ line 2
function select_x_session
	set -l option \
           (dialog \
               --stdout \
               --colors \
               --ok-label "run" \
               --cancel-label "logout" \
               --menu "select session" \
               0 0 0 \
               "i3wm"     "" \
               "fish"     "" \
               "shutdown" ""
           )
    if test ! $status -eq 0
        kill %self
    end
    clear
    switch "$option"
        case i3wm
            eval "exec startx $HOME/.xinitrc -- -keeptty -nolisten tcp 2> /dev/null 1>&2"
        case fish
            exit
        case shutdown
            exec shutdown -h now
    end
end
