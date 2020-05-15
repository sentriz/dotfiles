# scrap
alias go_scrap "vim (mktemp -d $DOTS_SCRAP_DIR/go.XXX)/main.go"
alias py_scrap "vim (mktemp -d $DOTS_SCRAP_DIR/python.XXX)/main.py"
alias go_scrap_find "vim (rg -g '**/main.go' --line-number --no-heading --smart-case --color=never . $DOTS_SCRAP_DIR | fzf | sed -r 's/([^:]+)\:([0-9]+).*/+\2\n\1/g')"
alias py_scrap_find "vim (rg -g '**/main.py' --line-number --no-heading --smart-case --color=never . $DOTS_SCRAP_DIR | fzf | sed -r 's/([^:]+)\:([0-9]+).*/+\2\n\1/g')"

# safety/better
alias rm    'rm -Iv --preserve-root'
alias wget  'wget -c'
alias cp    'cp -aiv'
alias mkdir 'mkdir -p -v'
alias pip   'pip --disable-pip-version-check'
alias cat   'bat'
alias vim   'nvim'
alias qmv   'qmv --format destination-only'

# grep
alias grep  'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# exit
alias :wq 'exit'
alias :qw 'exit'
alias :q  'exit'

# abbreviations
abbr sev 'sudo -E vim'
abbr du  'du -d1 -h'
abbr g   'git'
abbr cal 'cal --three --monday'
abbr cal 'cal --three --monday'
abbr ps  'ps -axh -o pid,%cpu,cmd'

# misc
alias pg 'ping 8.8.8.8'

# keep updated with `printf "set -g %s\n" (set -U | grep fish_color) > ~/.config/fish/conf.d/colours.fish`
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_command normal
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
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
fundle plugin 'fishpkg/fish-humanize-duration'
fundle plugin 'fisherman/getopts'
fundle plugin 'fisherman/fzf'
fundle plugin 'sentriz/fish-pipenv'
fundle init

# plugin settings
set -g pipenv_fish_fancy no
set -g VIRTUAL_ENV_DISABLE_PROMPT yes
