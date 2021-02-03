if string match -q -r '^\/dev\/tty' (tty)
    set -gx TERM xterm-256color
end

# ssh sock, make sure it's the same as `gpgconf --list-dirs agent-ssh-socket`
# if set in this file, the varible is availible for login shells, interactive shells, and the
# systemd user env via import-environment in sway config
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CURRENT_DESKTOP 'sway'
set -gx XDG_DATA_DIRS "/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$XDG_DATA_HOME/flatpak/exports/share"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_SESSION_TYPE 'wayland'

set -gx XDG_DESKTOP_DIR "$HOME/downloads"
set -gx XDG_DOCUMENTS_DIR "$HOME/documents"
set -gx XDG_DOWNLOAD_DIR "$HOME/downloads"
set -gx XDG_MUSIC_DIR "$HOME/downloads"
set -gx XDG_PICTURES_DIR "$HOME/pictures"
set -gx XDG_PUBLICSHARE_DIR "$HOME/downloads"
set -gx XDG_TEMPLATES_DIR "$HOME/downloads"
set -gx XDG_VIDEOS_DIR "$HOME/downloads"

# should be reflected in:
# - ~/.gtkrc-2.0
# - ~/.config/gtk-3.0/settings.ini
set -gx GTK_THEME "Arc:dark"

set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx CLUTTER_BACKEND 'wayland'
set -gx QT_QPA_PLATFORM 'wayland'
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
# set -gx GDK_BACKEND 'wayland'
