set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

set -gx EDITOR 'nvim'
set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgreprc"
set -gx FZF_DEFAULT_OPTS "--info hidden --color bw"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GOPROXY 'https://proxy.golang.org,direct'
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
set -gx NPM_CONFIG_PREFIX "$HOME/.local"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx COMPOSE_DOCKER_CLI_BUILD '1'
set -gx DOCKER_BUILDKIT '1'
set -gx LESSKEY '-'
set -gx LESSHISTFILE '-'
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx PYTHON_VENVS_DIR "$XDG_CACHE_HOME/venvs"

# dotfiles settings
set -gx DOTS_SCRAP_DIR "$HOME/scrap"
set -gx DOTS_SCREENSHOTS_DIR "$HOME/pictures/screenshots"
set -gx DOTS_RECORDINGS_DIR "$HOME/pictures/recordings"
set -gx DOTS_RADIO_DIR "$HOME/radio"
set -gx DOTS_MOUNTS_DIR "$HOME/mounts"
set -gx DOTS_COPT_DIR '/opt/containers'
set -gx DOTS_PROJECTS_DIR "$HOME/projects"

set -gx fish_user_paths \
    $GOPATH/bin \
    $HOME/.local/bin \
    $FNM_DIR/current/bin \
    $XDG_DATA_HOME/cargo/bin \
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
    $HOME/bin/*/ \
    /usr/share/git/git-jump/ \
    $ANDROID_HOME/tools/ \
    $ANDROID_HOME/tools/bin \
    $ANDROID_HOME/platform-tools \
    $ANDROID_HOME/emulator \
    /opt/flutter/bin/
