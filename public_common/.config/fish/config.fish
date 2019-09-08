function __source_if_exists
    for possible in $argv
        test -f "$possible"; and source "$possible"
    end
end

__source_if_exists \
    ~/.config/fish/config_parts/base.fish \
    ~/.config/fish/config_parts/base.(hostname).fish

status is-login; and __source_if_exists \
    ~/.config/fish/config_parts/login.fish \
    ~/.config/fish/config_parts/login.(hostname).fish

status is-interactive; and __source_if_exists \
    ~/.config/fish/config_parts/interactive.fish \
    ~/.config/fish/config_parts/interactive.(hostname).fish
