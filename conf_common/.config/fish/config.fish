function __source_if_exists
    for possible in $argv
        test ! -f "$possible"; and continue
        source "$possible"
    end
end

if string match -q -r '.*termux.*' "$HOME"
    set -gx HOSTNAME android
else
    set -gx HOSTNAME (hostname)
end

__source_if_exists \
    ~/.config/fish/config_parts/base.fish \
    ~/.config/fish/config_parts/base.$HOSTNAME.fish

status --is-login; and __source_if_exists \
    ~/.config/fish/config_parts/login.fish \
    ~/.config/fish/config_parts/login.$HOSTNAME.fish

status --is-interactive; and __source_if_exists \
    ~/.config/fish/config_parts/interactive.fish \
    ~/.config/fish/config_parts/interactive.$HOSTNAME.fish
