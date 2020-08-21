if string match -q -r '^\/dev\/tty' (tty)
    set -gx TERM xterm-256color
end

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx EDITOR 'nvim'
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgreprc"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GOPRIVATE 'github.com/CPSSD/*'
set -gx GOPROXY 'https://proxy.golang.org,direct'
set -gx FNM_MULTISHELL_PATH "$HOME/.fnm/current"
set -gx FNM_DIR "$XDG_CACHE_HOME/fnm"
set -gx FNM_NODE_DIST_MIRROR 'https://nodejs.org/dist'
set -gx FNM_LOGLEVEL 'info'
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
set -gx COMPOSE_DOCKER_CLI_BUILD '1'
set -gx DOCKER_BUILDKIT '1'

# dotfiles settings
set -gx DOTS_SCRAP_DIR "$HOME/scrap"
set -gx DOTS_SCREENSHOTS_DIR "$HOME/pictures/screenshots"
set -gx DOTS_SCREENSHOTS_REMOTE 'https://image.senan.xyz'
set -gx DOTS_PASTE_REMOTE 'https://paste.senan.xyz'
set -gx DOTS_RADIO_DIR "$HOME/radio"
set -gx DOTS_MOUNTS_DIR "$HOME/mounts"
set -gx DOTS_COPT_DIR '/opt/containers'
set -gx DOTS_PROJECTS_DIR "$HOME/projects"

set -l possible_paths \
    $GOPATH/bin \
    $HOME/.local/bin \
    $FNM_DIR/current/bin \
    $HOME/.volta/bin \
    $HOME/.yarn/bin \
    /usr/local/go/bin \
    /bin \
    /opt/Etcher \
    /opt/balenaEtcher \
    /sbin \
    /usr/bin \
    /usr/bin/vendor_perl \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/sbin \
    $HOME/bin \
    $HOME/bin/*/

# not using `set -a` for backwards compatibility
for path in $possible_paths
    test -d "$path"
    and set -gx fish_user_paths "$path" $fish_user_paths
end

sh -c 'rm -r \
    $HOME/.lesshst \
    $HOME/.*_history \
    $HOME/.gore \
    $HOME/.wget-hsts \
' > /dev/null 2>&1 &
