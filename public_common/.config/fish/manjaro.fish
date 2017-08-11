#!/usr/bin/env fish

# extra config
set -x host_prompt_colour 'green'

# extra path
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk/
set -x PATH $HOME/.local/lib/python3.5/site-packages/ $PATH
set -x PATH /opt/android-sdk/platform-tools/ $PATH

# start x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    source $HOME/.config/fish/xlogin.fish
end
