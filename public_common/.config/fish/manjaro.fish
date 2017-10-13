#!/usr/bin/env fish

# extra config
set -x host_prompt_colour 'green'

# java
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk/

# cargo path
set -x PATH $HOME/.cargo/bin $PATH

# python path
set -x PATH $HOME/.local/lib/python*/site-packages/ $PATH

# adb path
set -x PATH /opt/android-sdk/platform-tools/ $PATH

# ruby path
set -x GEM_HOME (ls -t -U | ruby -e 'puts Gem.user_dir')
set -x GEM_PATH $GEM_HOME
set -x PATH $GEM_HOME/bin $PATH

# sourcy stuff
source $HOME/.keychain/(hostname)-fish > /dev/null 2>&1
source $HOME/.keychain/(hostname)-fish-gpg > /dev/null 2>&1
eval (python3 -m virtualfish auto_activation)

# x login
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    xlogin
end
