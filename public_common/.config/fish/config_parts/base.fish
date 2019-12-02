set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc
set -gx EDITOR 'nvim'
set -gx GOPRIVATE 'github.com/CPSSD/*'
set -gx GOPROXY 'https://proxy.golang.org,direct'

# dotfiles settings
set -gx DOTS_SCREENSHOTS_DIR "$HOME/pictures/screenshots"
set -gx DOTS_SCREENSHOTS_REMOTE 'https://image.home.senan.xyz'
set -gx DOTS_PASTE_REMOTE 'https://paste.home.senan.xyz'
set -gx DOTS_RADIO_DIR "$HOME/radio"
set -gx DOTS_MOUNTS_DIR "$HOME/mounts"

if which go >/dev/null 2>&1
    set -gx GOPATH $HOME/go
end

set -l possible_paths \
    $GOPATH/bin \
    $HOME/.local/bin \
    $HOME/node_modules/.bin \
    $HOME/bin \
    $HOME/bin/*/ \
    /usr/local/go/bin \
    /bin \
    /opt/Etcher \
    /opt/balenaEtcher \
    /sbin \
    /usr/bin \
    /usr/bin/vendor_perl \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/sbin

# not using `set -a` for backwards compatibility
for path in $possible_paths
    test -d "$path"
    and set -gx fish_user_paths "$path" $fish_user_paths
end
