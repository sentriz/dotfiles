#!/bin/sh

if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
    for file in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [[ -x "$file" ]] && . "$file"
    done
    unset file
fi

setxkbmap ie
xmodmap ~/.Xmodmap
xset r rate 200 80
xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 0.75

export QT_QPA_PLATFORMTHEME=qt5ct
unset QT_STYLE_OVERRIDE

exec i3
