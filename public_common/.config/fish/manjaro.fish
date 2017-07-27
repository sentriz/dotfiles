#!/usr/bin/env fish

set -x host_prompt_colour 'green'

# start x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    source $HOME/.config/fish/xlogin.fish
end
