set -l possible_paths \
    $GEM_HOME/bin \
    $GOPATH/bin \
    $HOME/.gem/ruby/*/bin \
    $HOME/.local/bin \
    $HOME/node_modules/.bin \
    /opt/android-sdk/tools \
    /opt/android-sdk/tools/bin \
    (find -L $HOME/bin -type d) \
    /bin \
    /opt/Etcher \
    /opt/balenaEtcher \
    /opt/android-ndk \
    /sbin \
    /usr/bin \
    /usr/bin/vendor_perl \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/sbin

for path in $possible_paths
    test -d "$path"
    and set -gx fish_user_paths "$path" $fish_user_paths
end
