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
    ~/.config/fish/config.base.fish \
    ~/.config/fish/config.base.$HOSTNAME.fish

status --is-login; and __source_if_exists \
    ~/.config/fish/config.login.fish \
    ~/.config/fish/config.login.$HOSTNAME.fish

status --is-interactive; and __source_if_exists \
    ~/.config/fish/config.interactive.fish \
    ~/.config/fish/config.interactive.$HOSTNAME.fish
