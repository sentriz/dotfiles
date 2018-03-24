set_prompt_colour brgreen

# homes
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk/
set -x GEM_HOME (ls -t -U | ruby -e 'puts Gem.user_dir')
set -x GEM_PATH $GEM_HOME

# paths
set -l paths $HOME/.cargo/bin \
             $HOME/.local/lib/python*/site-packages/ \
             /opt/android-sdk/platform-tools/ \
             $GEM_HOME/bin
for path in $paths
    if test -e $path
        set -x PATH $path $PATH
    end
end

# includes
activate_keychain
activate_virtualfish

# x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
