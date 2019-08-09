# Defined in /tmp/fish.MAtCKx/select_x_session.fish @ line 2
function select_x_session
    set -l option (dialog \
        --stdout \
        --colors \
        --ok-label "run" \
        --cancel-label "logout" \
        --menu "select session" \
        0 0 0 \
        "sway" "" \
        "fish" "" \
        "shutdown" ""
    )
    if test ! $status -eq 0
        kill %self
    end
    clear
    switch "$option"
        case sway
            # set -gx XDG_SESSION_TYPE wayland
            # set -gx QT_QPA_PLATFORM wayland
            # set -gx GDK_BACKEND wayland
            # set -gx CLUTTER_BACKEND wayland
            set -gx GTK2_RC_FILES /usr/share/themes/Adwaita/gtk-2.0/gtkrc # gtk2
            set -gx GTK_THEME Adwaita                                     # gtk2
            set -gx QT_STYLE_OVERRIDE adwaita                             # qt5
            set -gx XDG_DESKTOP_DIR "$HOME"
            set -gx XDG_DOWNLOAD_DIR "$HOME/downloads"
            set -gx XDG_DOCUMENTS_DIR "$HOME/documents"
            set -gx XDG_MUSIC_DIR "$HOME/music"
            set -gx XDG_PICTURES_DIR "$HOME/pictures"
            set -gx XDG_VIDEOS_DIR "$HOME/videos"
            exec sway 2> /tmp/sway_debug_log
        case fish
            exit
        case shutdown
            exec shutdown -h now
    end
end
