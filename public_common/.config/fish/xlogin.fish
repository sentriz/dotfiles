dialog --colors --ok-label "run" --cancel-label "logout" --menu "select session" \
    0 0 0 "i3wm" "" "chromium" "" "fish" "" "ncmpcpp" "" "kodi" "" "shutdown" "" 2> /tmp/loginoption

if test ! $status -eq 0
    kill %self
end
clear

switch (cat /tmp/loginoption)
    case i3wm
        eval "exec startx $HOME/.xinitrc_iii -- -keeptty -nolisten tcp 2> /dev/null 1>&2"
    case chromium
        eval "exec startx $HOME/.xinitrc_chr -- -keeptty -nolisten tcp 2> /dev/null 1>&2"
    case kodi
        eval "exec startx $HOME/.xinitrc_kodi -- -keeptty -nolisten tcp 2> /dev/null 1>&2"
    case fish
        exit
    case shutdown
        exec shutdown -h now
end
