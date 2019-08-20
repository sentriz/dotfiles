activate_keychain

set -gx fish_color_host brgreen

function __update_termite_title --on-variable PWD
    status --is-command-substitution; and return
    printf '\e];termite %s\a' (pwd)
end
__update_termite_title
