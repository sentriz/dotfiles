set -gx HOSTNAME (uname -n)

set -q TERMUX_VERSION
and set -gx HOSTNAME android
and set -gx XDG_RUNTIME_DIR "$HOME"

set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

# import user-dirs as env vars
test -e "$XDG_CONFIG_HOME/user-dirs.dirs"
and sed -nE 's/^([^=#]+)=(.*)/set -gx \1 \2/gp' <"$XDG_CONFIG_HOME/user-dirs.dirs" | source

# import locale
type -q locale
and locale \
    | sed -nE 's/^([^=#]+)=(.*)/set -gx \1 \2/gp' \
    | source

function __tmux_env
    string match -q -r 'tmux\-\d+' "$TMUX"
    and tmux show-env
    string match -q -r 'tmate\-\d+' "$TMUX"
    and tmate show-env
end

# import tmux env
status is-interactive
and __tmux_env \
    | sed -nE 's/^(SSH_[^=]+)=(.*)/set -gx \1 "\2"/p' \
    | source

# import / start gpg env
status is-interactive
and not set -q SSH_CONNECTION
and gpgconf --launch gpg-agent
and set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
and set -gx GPG_TTY (tty)
and gpg-connect-agent updatestartuptty /bye >/dev/null

set -gx DOTS_SCRAP_DIR "$HOME/scrap"
set -gx DOTS_SCREENSHOTS_DIR "$HOME/pictures/screenshots"
set -gx DOTS_RECORDINGS_DIR "$HOME/pictures/recordings"
set -gx DOTS_RADIO_DIR "$HOME/radio"
set -gx DOTS_SECRETS_DIR "$HOME/mounts/secrets"
set -gx DOTS_COPT_DIR /opt/containers
set -gx DOTS_PROJECTS_DIR "$HOME/projects"

set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS "--info hidden --color bw"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx GOPROXY direct
set -gx GOSUMDB off
set -gx GOTELEMETRY off
set -gx GOTOOLCHAIN local
set -gx NPM_CONFIG_PREFIX "$XDG_DATA_HOME/npm"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -gx NPM_CONFIG_INIT_MODULE "$XDG_CONFIG_HOME/npm/config/npm-init.js"
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
    $HOME/.local/bin \
    $HOME/.local/bin/*/ \
    $GOPATH/bin \
    $FNM_DIR/current/bin \
    $NPM_CONFIG_PREFIX/bin \
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
set -a fish_function_path (find "$plugins" -mindepth 2 -maxdepth 2 -name "functions")
set -a fish_complete_path (find "$plugins" -mindepth 2 -maxdepth 2 -name "completions")
for file in (find "$plugins" -mindepth 3 -maxdepth 3 -path "*conf.d/*" -name "*.fish")
    source "$file"
end

# safety/better
alias rm 'rm -I --verbose --preserve-root'
alias wget 'wget --continue --content-disposition'
alias cp 'cp --archive --interactive --verbose'
alias mkdir 'mkdir --parents --verbose'
alias wget 'wget --hsts-file /dev/null'

# exit
alias :wq exit
alias :qw exit
alias :q exit

# abbreviations
abbr g git
abbr gti git
abbr ps 'ps -axh -o pid,%cpu,cmd'
abbr curl 'curl -s'
abbr less 'less -RKS#1'
abbr jq jq -r
abbr cd pushd

# extended regexp everywhere
abbr grep "grep -Ei"
abbr egrep "egrep -Ei"
abbr fgrep "fgrep -Ei"
abbr sed "sed -E"
abbr rg "rg --pcre2 --smart-case"

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

function to_prompt
    while read line
        commandline -a -- $line\n
    end
    commandline -C 999999
end

# fancy listing with relative time
function __list
    command ls -vFqrloth --group-directories-first --color=yes --time-style=long-iso --hyperlink $argv \
        | sed "s/"(date +%Y-%m-%d)"/\x1b[32m     today\x1b[m/; s/"(date +'%Y-%m-%d' -d yesterday)"/\x1b[33m yesterday\x1b[m/"
end

alias l "__list $argv"
alias ll "__list -A $argv"

function __super_vim
    if test (count $argv) -eq 1 -a \( -e "$argv[1]" \) -a \( ! -w "$argv[1]" \)
        sudo -E nvim $argv
        return
    end
    command nvim $argv
end

alias vi __super_vim
alias vim __super_vim
alias nvim __super_vim

function git
    if isatty stdout; and contains -- $argv[1] diff status log d s l
        command git -c color.status=always -c color.ui=always $argv | add-osc-8-hyperlink
        return
    end
    command git $argv
end

function rg
    if isatty stdout
        command rg --color=always --line-number $argv | add-osc-8-hyperlink
        return
    end
    command rg $argv
end

function go
    if isatty stdout; and contains -- $argv[1] test
        command go $argv | add-osc-8-hyperlink
        return
    end
    command go $argv
end
