# safety/better
alias rm    'rm -I --verbose --preserve-root'
alias wget  'wget --continue --content-disposition'
alias cp    'cp --archive --interactive --verbose'
alias mkdir 'mkdir --parents --verbose'
alias qmv   'qmv --format destination-only'

# exit
alias :wq 'exit'
alias :qw 'exit'
alias :q  'exit'

# abbreviations
abbr sev 'sudo -E nvim'
abbr du  'du -d1 -h'
abbr g   'git'
abbr cal 'cal --three --monday'
abbr ps  'ps -axh -o pid,%cpu,cmd'

# misc
alias pg 'ping 8.8.8.8'

# keep updated with `printf "set -g %s\n" (set -U | grep fish_color)`
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_command 'normal'
set -g fish_color_comment 'red'
set -g fish_color_cwd 'green'
set -g fish_color_cwd_root 'red'
set -g fish_color_end 'brmagenta'
set -g fish_color_error 'brred'
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# plugins
fundle plugin 'jethrokuan/z' --url 'git@github.com:jethrokuan/z.git#pre27'
fundle plugin 'fisherman/done'
fundle plugin 'fisherman/fzf'
fundle plugin 'fishpkg/fish-humanize-duration'
fundle plugin 'fisherman/getopts'
# fundle plugin 'sentriz/fish-pipenv'
fundle init

# plugin settings
set -g pipenv_fish_fancy 'no'
set -g VIRTUAL_ENV_DISABLE_PROMPT 'yes'

# jump to my projects easily with completion
function p --argument project
    cd "$DOTS_PROJECTS_DIR/$project"
end

complete -x --command p --arguments ( \
    find "$DOTS_PROJECTS_DIR" \
        -maxdepth 1 -mindepth 1 \
        -type d \
        -printf '%P ' \
)

# fancy listing with relative time
function __list
    command ls -vFqrloth --group-directories-first --color=yes --time-style=long-iso $argv \
        | sed "s/"(date +%Y-%m-%d)"/\x1b[32m     today\x1b[m/; s/"(date +'%Y-%m-%d' -d yesterday)"/\x1b[33m yesterday\x1b[m/"
end

alias l  "__list $argv"
alias ll "__list -A $argv"

function __super_vim
    test \( (count $argv) -eq 1 \) -a \( ! -w $argv[1] \);
        and sudo -E nvim $argv
        or command nvim $argv
end

alias vi   __super_vim
alias vim  __super_vim
alias nvim __super_vim
