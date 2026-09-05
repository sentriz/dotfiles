set -gx fish_colour_host brgreen

set -gx SCREENSHOTS_DIR "$XDG_PICTURES_DIR/screenshots"
set -gx RECORDINGS_DIR "$XDG_PICTURES_DIR/recordings"
set -gx RADIO_DIR "$HOME/radio"
set -gx NOTES_DIR "$HOME/notes"

set -gx LIBSEAT_BACKEND logind
set -gx XDG_CURRENT_DESKTOP sway
set -gx XDG_SESSION_TYPE wayland

set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"
set -gx SECRETS_SOCK "$XDG_RUNTIME_DIR/secrets-socket"

set -gx --path XDG_DATA_DIRS \
    /usr/local/share \
    /usr/share \
    /var/lib/flatpak/exports/share \
    "$XDG_DATA_HOME/flatpak/exports/share" \
    "$XDG_DATA_HOME"

set -a fish_user_paths \
    /var/lib/flatpak/exports/bin \
    "$XDG_DATA_HOME/flatpak/exports/bin" \
    /opt/Etcher \
    /opt/balenaEtcher \
    /opt/flutter/bin/

set -gx TERMINAL foot
set -gx TERMINAL_LIGHT foot -o initial-color-theme=light

# set -gx GDK_BACKEND 'wayland'
set -gx CLUTTER_BACKEND wayland
set -gx ECORE_EVAS_ENGINE wayland-egl
set -gx ELM_ENGINE wayland_egl
set -gx MOZ_ENABLE_WAYLAND 1
set -gx NO_AT_BRIDGE 1
set -gx QT_QPA_PLATFORM wayland-egl
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx SDL_VIDEODRIVER wayland
set -gx WLR_NO_HARDWARE_CURSORS 1
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx ELECTRON_OZONE_PLATFORM_HINT auto

set -gx JAVA_HOME /usr/lib/jvm/default-runtime
set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
set -gx JDTLS_HOME /usr/share/java/jdtls
set -gx PYLINTHOME "$XDG_DATA_HOME/pylint"
set -gx PYTHONHISTFILE "$XDG_CACHE_HOME/python_history"

set -gx YABRIDGE_TEMP_DIR "$XDG_RUNTIME_DIR/yabridge"
set -gx YABRIDGE_DEBUG_LEVEL ''

if status is-login
    dbus-update-activation-environment --systemd SSH_AUTH_SOCK SECRETS_SOCK XDG_DATA_DIRS PATH

    switch (tty)
        case /dev/tty1
            exec sway >"$XDG_RUNTIME_DIR/sway_log" 2>&1
        case /dev/tty2
            exec htop
    end
end
