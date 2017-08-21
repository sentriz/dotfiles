#!/usr/bin/env fish

# extra config
set -x host_prompt_colour 'green'

# java
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk/

# python path
set -x PATH $HOME/.local/lib/python*/site-packages/ $PATH

# adb path
set -x PATH /opt/android-sdk/platform-tools/ $PATH

# ruby path
set -x GEM_HOME (ls -t -U | ruby -e 'puts Gem.user_dir')
set -x GEM_PATH $GEM_HOME
set -x PATH $GEM_HOME/bin $PATH

if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    xlogin
end
