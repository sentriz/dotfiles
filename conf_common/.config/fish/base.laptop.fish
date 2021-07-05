if string match -q -r '^\/dev\/tty' (tty)
    set -gx TERM xterm-256color
end

# import user-dirs as env vars
sed -nE 's/^([^=#]+)=(.*)/set -gx \1 \2/gp' <"$XDG_CONFIG_HOME/user-dirs.dirs" | source

# ssh sock, make sure it's the same as `gpgconf --list-dirs agent-ssh-socket`
# if set in this file, the varible is availible for login shells, interactive shells, and the
# systemd user env via import-environment in sway config
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

set -gx LIBSEAT_BACKEND 'logind'
set -gx XDG_CURRENT_DESKTOP 'sway'
set -gx XDG_SESSION_TYPE 'wayland'
set -gx --path XDG_DATA_DIRS \
    '/usr/local/share' \
    '/usr/share' \
    '/var/lib/flatpak/exports/share' \
    "$XDG_DATA_HOME/flatpak/exports/share"

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

set -gx ANDROID_SDK_ROOT '/opt/android-sdk'
set -gx ANDROID_HOME '/opt/android-sdk'
set -gx JAVA_HOME '/usr/lib/jvm/java-8-openjdk/'
set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
set -gx PYLINTHOME "$XDG_DATA_HOME/pylint"
set -gx WINEPREFIX "$XDG_DATA_HOME/wine"
set -gx PYTHONHISTFILE "$XDG_CACHE_HOME/python_history"

set -gx --path VST_PATH \
    '/usr/lib/vst/' \
    '/usr/local/lib/vst/' \
    "$HOME/.local/lib/vst" \
    "$WINEPREFIX/drive_c/Program Files (x86)/Steinberg/VstPlugins" \
    "$WINEPREFIX/drive_c/Program Files/Common Files/Steinberg/VST2" \
    "$WINEPREFIX/drive_c/Program Files/Common Files/VST2" \
    "$WINEPREFIX/drive_c/Program Files/Steinberg/VSTPlugins" \
    "$WINEPREFIX/drive_c/Program Files/VSTPlugins"
set -gx --path VST3_PATH \
    '/usr/lib/vst3/' \
    '/usr/local/lib/vst3/' \
    "$HOME/.local/lib/vst3" \
    "$WINEPREFIX/drive_c/Program Files (x86)/Common Files/VST3" \
    "$WINEPREFIX/drive_c/Program Files/Common Files/VST3"

# gtk2/gtk3 theme
# also, gsettings commands parse these vars
set -gx GTK_THEME 'Arc-Dark'
set -gx GTK_FONT_NAME 'DejaVu Sans 10'
set -gx GTK_DARK 1
set -gx GTK2_RC_FILES /usr/share/themes/Arc-Dark/gtk-2.0/gtkrc

set -gx TERMINAL footclient
