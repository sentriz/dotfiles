if string match -q -r '^\/dev\/tty' (tty)
    set -gx TERM xterm-256color
end

# import user-dirs as env vars
sed -nE 's/^([^=#]+)=(.*)/set -gx \1 \2/gp' <"$XDG_CONFIG_HOME/user-dirs.dirs" | source

# ssh sock, make sure it's the same as `gpgconf --list-dirs agent-ssh-socket`
# if set in this file, the varible is availible for login shells, interactive shells, and the
# systemd user env via import-environment in sway config
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

set -gx XDG_CURRENT_DESKTOP 'sway'
set -gx XDG_DATA_DIRS "/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$XDG_DATA_HOME/flatpak/exports/share"
set -gx XDG_SESSION_TYPE 'wayland'

# should be reflected in:
# - ~/.gtkrc-2.0
# - ~/.config/gtk-3.0/settings.ini
set -gx GTK_THEME "Arc:dark"

# set -gx GDK_BACKEND 'wayland'
set -gx CLUTTER_BACKEND 'wayland'
set -gx ECORE_EVAS_ENGINE 'wayland-egl'
set -gx ELM_ENGINE 'wayland_egl'
set -gx MOZ_ENABLE_WAYLAND 1
set -gx NO_AT_BRIDGE 1
set -gx QT_QPA_PLATFORM 'wayland-egl'
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx SDL_VIDEODRIVER 'wayland'
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx _JAVA_AWT_WM_NONREPARENTING 1
