# load plugins
set plugins "$__fish_config_dir/plugins/"
set -a fish_function_path (find "$plugins" -maxdepth 3 -name "functions")
set -a fish_complete_path (find "$plugins" -maxdepth 3 -name "completions")
for file in (find "$plugins" -path "*conf.d/*" -name "*.fish")
    source "$file"
end

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
abbr g   'git'
abbr gti 'git'
abbr ps  'ps -axh -o pid,%cpu,cmd'

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

# fancy listing with relative time
function __list
    command ls -vFqrloth --group-directories-first --color=yes --time-style=long-iso $argv \
        | sed "s/"(date +%Y-%m-%d)"/\x1b[32m     today\x1b[m/; s/"(date +'%Y-%m-%d' -d yesterday)"/\x1b[33m yesterday\x1b[m/"
end

alias l  "__list $argv"
alias ll "__list -A $argv"

function __super_vim
    test (count $argv) -eq 1; and test \( ! -e (dirname $argv[1]) \); and test (read --prompt-str 'create dir? ') = 'y'
        and mkdir -p (dirname $argv[1]) >/dev/null
    test (count $argv) -eq 1; and test \( -e $argv[1] \) -a \( ! -w $argv[1] \)
        and sudo -E nvim $argv
        or command nvim $argv
end

alias vi   __super_vim
alias vim  __super_vim
alias nvim __super_vim

function __package_sudo
    test (count $argv) -eq 0; and return
    if contains -- "$argv[1]" 'npm' 'yarn' 'python' 'python2' 'python3' 'pip3' 'pip' 'go'
        echo "don't do `sudo $argv[1]`"
        return 1
    end
    command sudo $argv
end

alias sudo __package_sudo
