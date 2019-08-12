if not status --is-interactive
    exit
end

# scrap
alias go_scrap_new  'vim (mktemp -d ~/scrap/go.XXX)/main.go'
alias py_scrap_new  'vim (mktemp -d ~/scrap/python.XXX)/main.py'
alias go_scrap_find 'vim (rg -g \'**/main.go\' --line-number --no-heading --smart-case --color=never . ~/scrap/ | fzf | awk -F \':\' \'{print $1, "+" $2}\' | sed \'s/\s/\n/g\')'
alias py_scrap_find 'vim (rg -g \'**/main.py\' --line-number --no-heading --smart-case --color=never . ~/scrap/ | fzf | awk -F \':\' \'{print $1, "+" $2}\' | sed \'s/\s/\n/g\')'

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

# misc
alias pg 'ping 8.8.8.8'
