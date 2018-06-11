set -xg fish_color_host brgreen

# homes
set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk/
set -gx ANDROID_HOME /opt/android-sdk/
set -gx GEM_HOME (ls -t -U | ruby -e 'puts Gem.user_dir')
set -gx GEM_PATH $GEM_HOME $GEM_PATH
set -gx GOPATH $HOME/go

# paths
set -gx fish_user_paths $HOME/.local/lib/python*/site-packages/ \
                        $GEM_HOME/bin \
                        /opt/Etcher \
                        $GOPATH/bin \
                        $fish_user_paths

if status --is-login
    start_keychain
end

if status --is-interactive
    activate_virtualfish
    activate_keychain
end

if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
