set -gx fish_colour_host brgreen

set -gx LIBSEAT_BACKEND logind
set -gx XDG_CURRENT_DESKTOP sway
set -gx XDG_SESSION_TYPE wayland

set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/bw-ssh-agent"

set -gx --path XDG_DATA_DIRS \
    /usr/local/share \
    /usr/share \
    /var/lib/flatpak/exports/share \
    "$XDG_DATA_HOME/flatpak/exports/share" \
    "$XDG_DATA_HOME"

set -gx TERMINAL foot

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

set -gx ANDROID_SDK_ROOT /opt/android-sdk
set -gx ANDROID_HOME /opt/android-sdk
set -gx JAVA_HOME /usr/lib/jvm/default-runtime
set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
set -gx JDTLS_HOME /usr/share/java/jdtls
set -gx PYLINTHOME "$XDG_DATA_HOME/pylint"
set -gx PYTHONHISTFILE "$XDG_CACHE_HOME/python_history"

set -gx YABRIDGE_TEMP_DIR "$XDG_RUNTIME_DIR/yabridge"
set -gx YABRIDGE_DEBUG_LEVEL ''

abbr docker-compose "docker compose"

function p --argument project
    cd "$DOTS_PROJECTS_DIR/$project"
end

complete -x --command p --arguments ( \
    find "$DOTS_PROJECTS_DIR" \
        -maxdepth 1 -mindepth 1 \
        -type d \
        -printf '%P ' \
)

if status is-login
    pkill -f bw-ssh-agent
    bw-do bw-ssh-agent &

    switch (tty)
        case /dev/tty1
            exec sway >/tmp/sway_log 2>&1
        case /dev/tty2
            exec htop
    end
end

if status is-interactive
    theme dark
end
