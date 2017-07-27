#!/usr/bin/env fish

set -x prompt_host_colour 'green'

# start x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    source $HOME/.config/fish/xlogin.fish
end
