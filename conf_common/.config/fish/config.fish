set -gx HOSTNAME android
if type -q hostname >/dev/null 2>&1
    set -gx HOSTNAME (hostname)
end

source "$__fish_config_dir/base.fish" 2>/dev/null
source "$__fish_config_dir/base.$HOSTNAME.fish" 2>/dev/null

if status --is-login
    source "$__fish_config_dir/login.fish" 2>/dev/null
    source "$__fish_config_dir/login.$HOSTNAME.fish" 2>/dev/null
end

if status --is-interactive
    source "$__fish_config_dir/interactive.fish" 2>/dev/null
    source "$__fish_config_dir/interactive.$HOSTNAME.fish" 2>/dev/null
end
