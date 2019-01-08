set -xg fish_color_host brmagenta

if status --is-login
    start_keychain > /dev/null 2>&1
    fish -c 'start_tunnels' > /dev/null 2>&1 &
end

if status --is-interactive
    activate_virtualfish
    activate_keychain
end

# aliases
alias work_paste "curl -sF c=@- pb | grep -Po --color=never 'url:\s\K(.*)'"

# env
set -xg ANDROID_NDK /opt/android-ndk
set -xg ANDROID_NDK_HOME /opt/android-ndk
set -xg ANDROID_HOME /opt/android-sdk
set -xg QT_DIR $HOME/qt
set -xg N_PREFIX $HOME

if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
