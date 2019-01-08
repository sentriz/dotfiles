# scrap
alias go_scrap_new 'vim (mktemp -d ~/scrap/go.XXX)/main.go'
alias py_scrap_new 'vim (mktemp -d ~/scrap/python.XXX)/main.py'
alias go_scrap_find 'vim (rg -g \'**/main.go\' --line-number --no-heading --smart-case --color=never . ~/scrap/ | fzf | awk -F \':\' \'{print $1, "+" $2}\' | sed \'s/\s/\n/g\')'
alias py_scrap_find 'vim (rg -g \'**/main.py\' --line-number --no-heading --smart-case --color=never . ~/scrap/ | fzf | awk -F \':\' \'{print $1, "+" $2}\' | sed \'s/\s/\n/g\')'

# needed argument or couldn't quote
alias xkill "xkill -id \"(xwininfo | awk '/Window id:/ {print $4}')\""
alias fuzz_here "find . -readable -type f | fzf --reverse --black --multi | xclip"
alias fuzz_root "find / -readable -type f | fzf --reverse --black --multi | xclip"

# safety/better
alias rm "rm -Iv --preserve-root"
alias wget "wget -c"
alias cp "cp -aiv"
alias mkdir "mkdir -p -v"
alias pip "pip --disable-pip-version-check"
alias cat "bat"

# arrangment
alias qmv "qmv --format destination-only"
alias qrm "qrm --format destination-only"

# grep
alias grep "grep --color=auto"
alias fgrep "fgrep --color=auto"
alias egrep "egrep --color=auto"

# action
alias pg      "ping 8.8.8.8"
alias ascreen "screen -dRR"
alias monoff  "xset dpms force off"
alias av_scan "sudo freshclam; and sudo clamscan -r --bell -i /"
alias watched "sed -i s/watched\>false/watched\>true/"
alias calc    "python3 -ic 'from math import *; from cmath import *'"

# info
alias cal           "cal --three --monday"
alias temp          "math (cat /sys/class/thermal/thermal_zone0/temp) / 1000"
alias weather       "curl --silent http://wttr.in/ | head -7"
alias latest_here   "ls -Art | tail -n 1"
alias package_count "pacman -Q | wc -l"
alias speed         "speedtest-cli --simple"

# with other command
alias paste "nc -N termbin.com 9999"
alias haste "env HASTE_SERVER=https://haste.home.senan.xyz haste"

# exit
alias :wq "exit"
alias :qw "exit"
alias :q  "exit"

# abbreviations
# abbr sudo "sudo -E"
abbr sev "sudo -E vim"
abbr du "du -d1 -h"
abbr g "git"
abbr docker "sudo docker"
abbr rg "rg -g '!*node_modules*'"
