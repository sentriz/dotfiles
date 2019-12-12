set -gx CLUTTER_BACKEND wayland
set -gx GDK_BACKEND wayland
set -gx QT_QPA_PLATFORM wayland
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx XDG_SESSION_TYPE wayland

# see ~/.config/user-dirs.dirs for the rest
# and `systemctl --user enable --now xdg-user-dirs-update`
set -gx XDG_CURRENT_DESKTOP 'sway'
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_DIRS (string join ':' \
    '/usr/local/share' \
    '/usr/share' \
    '/var/lib/flatpak/exports/share' \
    '/home/senan/.local/share/flatpak/exports/share'
)

exec sway 2> /tmp/sway_debug_log
