# prompt colour
set -xg fish_color_host brmagenta

# startup
if status --is-interactive
    activate_keychain
end

# functions
function paste_work
    curl -sF c=@- pb | grep -Po --color=never 'url:\s\K(.*)'
end

# start x
if test (tty) = '/dev/tty1'
    start_sway
end
