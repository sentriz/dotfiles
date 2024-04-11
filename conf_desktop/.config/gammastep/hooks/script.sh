#!/bin/sh

case $1 in
period-changed)
    case $3 in
    "night")
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        notify-send "switched to dark"
        ;;
    *)
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        notify-send "switched to light"
        ;;
    esac
    ;;
esac
