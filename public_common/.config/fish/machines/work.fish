# prompt colour
set -xg fish_color_host brmagenta

# startup
if status --is-login
    start_keychain > /dev/null 2>&1
end

if status --is-interactive
    activate_keychain
end

# functions
function paste_work
    curl -sF c=@- pb | grep -Po --color=never 'url:\s\K(.*)'
end

# start x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
