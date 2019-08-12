activate_keychain

function paste_work
    curl -sF c=@- pb | grep -Po --color=never 'url:\s\K(.*)'
end

set -xg fish_color_host brmagenta
