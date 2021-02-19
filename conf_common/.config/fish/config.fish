set -gx HOSTNAME android
if type -qp hostname >/dev/null 2>&1
    set -gx HOSTNAME (hostname)
end

function __source_if_exists
    for possible in $argv
        test ! -f "$possible"; and continue
        source "$possible"
    end
end

__source_if_exists \
    "$__fish_config_dir/config.base.fish" \
    "$__fish_config_dir/config.base.$HOSTNAME.fish"

status --is-login; and __source_if_exists \
    "$__fish_config_dir/config.login.fish" \
    "$__fish_config_dir/config.login.$HOSTNAME.fish"

status --is-interactive; and __source_if_exists \
    "$__fish_config_dir/config.interactive.fish" \
    "$__fish_config_dir/config.interactive.$HOSTNAME.fish"
