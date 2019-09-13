set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc
set -gx EDITOR nvim

if which go >/dev/null 2>&1
    set -gx GOPATH $HOME/go
end

set -l possible_paths \
    $GOPATH/bin \
    $HOME/.local/bin \
    $HOME/node_modules/.bin \
    $HOME/bin \
    $HOME/bin/*/ \
    /bin \
    /opt/Etcher \
    /opt/balenaEtcher \
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
