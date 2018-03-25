set_prompt_colour brgreen

# homes
set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk/
set -gx GEM_HOME (ls -t -U | ruby -e 'puts Gem.user_dir')
set -gx GEM_PATH $GEM_HOME $GEM_PATH

# paths
set -gx fish_user_paths $HOME/.local/lib/python*/site-packages/ \
                        $GEM_HOME/bin \
                        $fish_user_paths

# includes
if status --is-login
    start_keychain
end
if status --is-interactive
    activate_virtualfish
    activate_keychain
end

# x
if status --is-login; and test -z $DISPLAY; and test -z $TMUX
    select_x_session
end
