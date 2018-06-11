set -xg fish_color_host brmagenta

if status --is-login
    start_keychain &
end

set -gx GOPATH $HOME/go
set -gx GOBIN $GOPATH/bin
set -gx fish_user_paths $GOPATH/bin \
                        $fish_user_paths

if status --is-interactive
    # activate_virtualfish
    activate_keychain &
end

if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
