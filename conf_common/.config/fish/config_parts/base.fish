set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc
set -gx EDITOR 'nvim'
set -gx GOPRIVATE 'github.com/CPSSD/*'
set -gx GOPROXY 'https://proxy.golang.org,direct'
set -gx FNM_MULTISHELL_PATH $HOME/.fnm/current
set -gx FNM_DIR $HOME/.fnm
set -gx FNM_NODE_DIST_MIRROR https://nodejs.org/dist
set -gx FNM_LOGLEVEL info

# dotfiles settings
set -gx DOTS_SCREENSHOTS_DIR "$HOME/pictures/screenshots"
set -gx DOTS_SCREENSHOTS_REMOTE 'https://image.home.senan.xyz'
set -gx DOTS_PASTE_REMOTE 'https://paste.home.senan.xyz'
set -gx DOTS_RADIO_DIR "$HOME/radio"
set -gx DOTS_MOUNTS_DIR "$HOME/mounts"
set -gx DOTS_COPT_DIR '/opt/containers'

if which go >/dev/null 2>&1
    set -gx GOPATH $HOME/go
end

set -l possible_paths \
    $GOPATH/bin \
    $HOME/.local/bin \
    $HOME/node_modules/.bin \
    $HOME/bin \
    $HOME/bin/*/ \
    $HOME/.fnm/current/bin \
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

sh -c 'rm -r \
    $HOME/.lesshst \
    $HOME/.*_history \
    $HOME/.gore \
    $HOME/.npm \
' > /dev/null 2>&1 &
