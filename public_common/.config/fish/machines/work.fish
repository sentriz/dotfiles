set -xg fish_color_host brmagenta

if status --is-login
    start_keychain &
end

if status --is-interactive
    activate_virtualfish
    activate_keychain &
end

# work aliases
alias work_paste 'curl -F c=@- pb'

if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
