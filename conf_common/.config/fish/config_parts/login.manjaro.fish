test (tty) != '/dev/tty1'; and exit

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_DIRS (string join ':' \
    '/usr/local/share' \
    '/usr/share' \
    '/var/lib/flatpak/exports/share' \
    '/home/senan/.local/share/flatpak/exports/share'
)

exec start_sway
