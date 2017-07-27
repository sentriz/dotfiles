set -x PATH /usr/local/sbin                  $PATH
set -x PATH /usr/local/bin                   $PATH
set -x PATH /usr/sbin /sbin                  $PATH
set -x PATH /bin /usr/bin                    $PATH
set -x PATH /opt/android-sdk/platform-tools/ $PATH
set -x PATH $HOME/.local/bin                 $PATH
set -x PATH $HOME/.local/lib/python3.6/site-packages/ $PATH
set -x PATH $HOME/.local/lib/python3.5/site-packages/ $PATH
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk/
#set -x GEM_HOME (ruby -e 'print Gem.user_dir')
#set -x PATH $GEM_HOME/bin   $PATH

# recurisve bin
if test -d $HOME/bin
    set -x PATH (find -L $HOME/bin -type d) $PATH
end

# keychain
source $HOME/.keychain/(hostname)-fish > /dev/null 2>&1
source $HOME/.keychain/(hostname)-fish-gpg > /dev/null 2>&1

# host specific
if test -f $HOME/.config/fish/(hostname).fish
    source $HOME/.config/fish/(hostname).fish
end

# enable virtualfish
eval (python -m virtualfish auto_activation) > /dev/null 2>&1

# misc
set -U fish_prompt_pwd_dir_length 0

# needed argument or couldn't quote
alias xkill "xkill -id \"(xwininfo | awk '/Window id:/ {print $4}')\""
alias fuzz_here "find . -readable -type f | fzf --reverse --black --multi | xclip"
alias fuzz_root "find / -readable -type f | fzf --reverse --black --multi | xclip"
alias please "eval command sudo $history[1]"

# safety/better
alias rm "rm -Iv --preserve-root"
alias sudo "sudo "
alias wget "wget -c"
alias cp "cp -aiv"
alias mkdir "mkdir -p -v"
alias du "du -d1 -h"
alias df "df -hT"

# arrangment
alias qmv "qmv --format destination-only"
alias qrm "qrm --format destination-only"

# fasd
alias p "a -e mpv"
alias v "a -e vim"

# grep
alias grep "grep --color=auto"
alias fgrep "fgrep --color=auto"
alias egrep "egrep --color=auto"

# action
alias pg "ping 8.8.8.8"
alias ascreen "screen -dRR"
alias monoff "xset dpms force off"
alias av_scan "sudo freshclam; and sudo clamscan -r --bell -i /"
alias watched "sed -i s/watched\>false/watched\>true/"
alias calc "python3 -ic 'from math import *; import cmath'"
alias ace "acestream-launcher --player mpv"

# info
alias ncs "ps aux | egrep '\sn(cat|c|etcat)\s'"
alias sshs "ps aux | grep '[s]sh'"
alias cal "cal --three --monday"
alias temp "math (cat /sys/class/thermal/thermal_zone0/temp) / 1000"
alias weather "curl --silent http://wttr.in/ | head -7"
alias latest_here "ls -Art | tail -n 1"
alias package_count "pacman -Q | wc -l"
alias speed "speedtest-cli --simple"

# with other command
alias tb "nc termbin.com 9999"
alias sedo "sudo -E"
alias sudo "sudo "

# exit
alias :wq "exit"
alias :qw "exit"
alias :q "exit"
