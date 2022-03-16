if type -q hostname
    set -gx HOSTNAME (hostname)
end

if set -q TERMUX_VERSION
    set -gx HOSTNAME android
    set -gx XDG_RUNTIME_DIR "$HOME"
end

set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

# import user-dirs as env vars
if test -e "$XDG_CONFIG_HOME/user-dirs.dirs"
    sed -nE 's/^([^=#]+)=(.*)/set -gx \1 \2/gp' <"$XDG_CONFIG_HOME/user-dirs.dirs" | source
end

set -gx DOTS_SCRAP_DIR "$HOME/scrap"
set -gx DOTS_SCREENSHOTS_DIR "$HOME/pictures/screenshots"
set -gx DOTS_RECORDINGS_DIR "$HOME/pictures/recordings"
set -gx DOTS_RADIO_DIR "$HOME/radio"
set -gx DOTS_SECRETS_DIR "$HOME/mounts/secrets"
set -gx DOTS_COPT_DIR /opt/containers
set -gx DOTS_PROJECTS_DIR "$HOME/projects"

set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgreprc"
set -gx FZF_DEFAULT_OPTS "--info hidden --color bw"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GOPROXY 'https://proxy.golang.org,direct'
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
set -gx NPM_CONFIG_PREFIX "$HOME/.local"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx COMPOSE_DOCKER_CLI_BUILD 1
set -gx DOCKER_BUILDKIT 1
set -gx LESSKEY -
set -gx LESSHISTFILE -
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx CARGO_NET_GIT_FETCH_WITH_CLI true
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx PYTHON_VENVS_DIR "$XDG_CACHE_HOME/venvs"

set -gx fish_user_paths \
    $GOPATH/bin \
    $HOME/.local/bin \
    $HOME/.local/bin/*/ \
    $FNM_DIR/current/bin \
    $XDG_DATA_HOME/cargo/bin \
    $HOME/bin \
    $HOME/bin/*/ \
    $ANDROID_HOME/tools/ \
    $ANDROID_HOME/tools/bin \
    $ANDROID_HOME/platform-tools \
    $ANDROID_HOME/emulator \
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
    /usr/share/git/git-jump/ \
    /opt/flutter/bin/

source "$__fish_config_dir/config.$HOSTNAME.fish" 2>/dev/null

# load plugins
set plugins "$__fish_config_dir/plugins/"
set -a fish_function_path (find "$plugins" -maxdepth 2 -name "functions")
set -a fish_complete_path (find "$plugins" -maxdepth 2 -name "completions")
for file in (find "$plugins" -path "*conf.d/*" -name "*.fish")
    source "$file"
end

# safety/better
alias rm 'rm -I --verbose --preserve-root'
alias wget 'wget --continue --content-disposition'
alias cp 'cp --archive --interactive --verbose'
alias mkdir 'mkdir --parents --verbose'
alias qmv 'qmv --format destination-only'
alias wget 'wget --hsts-file /dev/null'

# exit
alias :wq exit
alias :qw exit
alias :q exit

# abbreviations
abbr g git
abbr gti git
abbr ps 'ps -axh -o pid,%cpu,cmd'

# cd   -> pushd
# cd - -> popd
abbr cd ce
function ce --wraps pushd
    if test (count $argv) -eq 0
        cd
        return $status
    end
    if test $argv[1] = -
        popd
        return $status
    end
    pushd $argv
    return $status
end

# keep updated with `printf "set -g %s\n" (set -U | grep fish_color)`
set -g fish_color_autosuggestion 555 brblack
set -g fish_color_command normal
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape bryellow --bold
set -g fish_color_history_current --bold
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match bryellow '--background=brblack'
set -g fish_color_selection white --bold '--background=brblack'
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# fancy listing with relative time
function __list
    command ls -vFqrloth --group-directories-first --color=yes --time-style=long-iso $argv \
        | sed "s/"(date +%Y-%m-%d)"/\x1b[32m     today\x1b[m/; s/"(date +'%Y-%m-%d' -d yesterday)"/\x1b[33m yesterday\x1b[m/"
end

alias l "__list $argv"
alias ll "__list -A $argv"

function __super_vim
    test (count $argv) -eq 1
    and test \( ! -e (dirname -- $argv[1]) \)
    and test (read --prompt-str 'create dir? ') = y
    and mkdir -p (dirname -- $argv[1]) >/dev/null
    test (count $argv) -eq 1
    and test \( -e $argv[1] \) -a \( ! -w $argv[1] \)
    and sudo -E nvim $argv
    or command nvim $argv
end

alias vi __super_vim
alias vim __super_vim
alias nvim __super_vim

function __package_sudo
    test (count $argv) -eq 0
    and return
    if contains -- "$argv[1]" npm yarn python python2 python3 pip3 pip go
        echo "don't do `sudo $argv[1]`"
        return 1
    end
    command sudo $argv
end

alias sudo __package_sudo
