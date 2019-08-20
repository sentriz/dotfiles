set -gx CLUTTER_BACKEND wayland
set -gx GDK_BACKEND wayland
set -gx QT_QPA_PLATFORM wayland
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx XDG_SESSION_TYPE wayland

set -gx XDG_DESKTOP_DIR "$HOME"
set -gx XDG_DOWNLOAD_DIR "$HOME/downloads"
set -gx XDG_DOCUMENTS_DIR "$HOME/documents"
set -gx XDG_MUSIC_DIR "$HOME/music"
set -gx XDG_PICTURES_DIR "$HOME/pictures"
set -gx XDG_VIDEOS_DIR "$HOME/videos"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_DIRS (string join ':' \
    '/usr/local/share' \
    '/usr/share' \
    '/var/lib/flatpak/exports/share' \
    '/home/senan/.local/share/flatpak/exports/share'
)

exec sway 2> /tmp/sway_debug_log
