set -l possible_paths \
    $GEM_HOME/bin \
    $GOPATH/bin \
    $HOME/.local/bin \
    $HOME/node_modules/.bin \
    (find -L $HOME/bin -type d) \
    /bin \
    /opt/Etcher \
    /sbin \
    /usr/bin \
    /usr/bin/vendor_perl \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/sbin \
    /opt/android-ndk

for path in $possible_paths
    test -d "$path"
    and set -gx fish_user_paths "$path" $fish_user_paths
end
