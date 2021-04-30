set -gx HOSTNAME android
if type -q hostname >/dev/null 2>&1
    set -gx HOSTNAME (hostname)
end

function __source_if_exists
    for possible in $argv
        test ! -f "$possible"; and continue
        source "$possible"
    end
end

__source_if_exists \
    "$__fish_config_dir/base.fish" \
    "$__fish_config_dir/base.$HOSTNAME.fish"

status --is-login; and __source_if_exists \
    "$__fish_config_dir/login.fish" \
    "$__fish_config_dir/login.$HOSTNAME.fish"

status --is-interactive; and __source_if_exists \
    "$__fish_config_dir/interactive.fish" \
    "$__fish_config_dir/interactive.$HOSTNAME.fish"
