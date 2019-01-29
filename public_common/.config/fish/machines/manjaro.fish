# prompt colour
set -xg fish_color_host brgreen

# startup
if status --is-login
    start_keychain
end
if status --is-interactive
    activate_virtualfish
    activate_keychain
end

# start x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
