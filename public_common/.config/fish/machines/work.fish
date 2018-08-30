set -xg fish_color_host brmagenta

if status --is-login
    start_keychain &
end

if status --is-interactive
    activate_virtualfish
    activate_keychain &
end

# aliases
alias work_paste "curl -sF c=@- pb | grep -Po --color=never 'url:\s\K(.*)'"

# env
set -xg ANDROID_NDK /opt/android-ndk
set -xg ANDROID_NDK_HOME /opt/android-ndk

if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
