set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc
set -gx EDITOR nvim

if test -d /opt/android-sdk
    set -gx ANDROID_HOME /opt/android-sdk
end

if test -d /usr/lib/jvm
    set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk
end

if which go >/dev/null 2>&1
    set -gx GOPATH $HOME/go
end

if which ruby >/dev/null 2>&1
    set -gx GEM_HOME $HOME/.gem/ruby/2.6.0
    set -gx GEM_PATH $GEM_HOME $GEM_PATH
end

set -l possible_paths \
    $GEM_HOME/bin \
    $GOPATH/bin \
    $HOME/.gem/ruby/*/bin \
    $HOME/.local/bin \
    $HOME/node_modules/.bin \
    /opt/android-sdk/tools \
    /opt/android-sdk/tools/bin \
    $HOME/bin \
    $HOME/bin/*/ \
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
