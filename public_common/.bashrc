## misc ##

set -o vi

## aliases ##

# needed argument or couldn't quote
c() { cd "$@" && ls -lpAh; }
xkill() { xkill -id "$(xwininfo | awk '/Window id:/ {print $4}')"; }
fuzz_here() { find . -readable -type f 2> /dev/null | fzf --reverse --black --multi | xclip; }
fuzz_root() { find / -readable -type f 2> /dev/null | fzf --reverse --black --multi | xclip; }
find_key() { xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'; }

# listing
l() {
    test -d .git && git status && echo
    ls -vFqrloth --color=yes --time-style=long-iso "$@" \
    | sed "s/$(date +%Y-%m-%d)/\x1b[32m     TODAY\x1b[m/; s/$(date +'%Y-%m-%d' -d yesterday)/\x1b[33m YESTERDAY\x1b[m/"
}

ll() {
    ls -vFqrlothA --color=yes  --time-style=long-iso "$@" \
    | sed "s/$(date +%Y-%m-%d)/\x1b[32m     TODAY\x1b[m/; s/$(date +'%Y-%m-%d' -d yesterday)/\x1b[33m YESTERDAY\x1b[m/"
}

# safety/better
alias rm='rm -Iv --preserve-root'
alias sudo='sudo '
alias wget='wget -c'
alias cp='cp -aiv'
alias mkdir='mkdir -p -v'
alias du='du -d1 -h'
alias df='df -hT'
alias ssh="autossh"

alias qmv="qmv --format destination-only"
alias qrm="qrm --format destination-only"

# fasd
alias p='a -e mpv'
alias v='a -e vim'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# action
alias pg='ping 8.8.8.8'
alias ascreen='screen -dRR'
alias monoff="xset dpms force off"
alias av_scan="sudo freshclam && sudo clamscan -r --bell -i /"
alias watched="sed -i s/watched\>false/watched\>true/"
alias calc="python3 -ic 'from math import *; import cmath'"

# info
alias ncs="ps aux | egrep '\sn(cat|c|etcat)\s'"
alias sshs="ps aux | grep '[s]sh'"
alias cal="cal --three --monday"
alias temp='expr `cat /sys/class/thermal/thermal_zone0/temp` / 1000'
alias weather="curl --silent http://wttr.in/ | head -7"
alias latest_here="ls -Art | tail -n 1"
alias package_count="pacman -Q | wc -l"
alias speed="speedtest-cli --simple"

# with other command
alias tb="nc termbin.com 9999"
alias please='sudo $(history -p \!\!)'
alias what='clear && $(history -p \!\!)'
alias sedo="sudo -E"
alias sudo="sudo "

# exit
alias :wq="exit"
alias :qw="exit"
alias :q="exit"

## functions ##

extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1 ;;
            *.tar.gz)    tar xzf $1 ;;
            *.bz2)       bunzip2 $1 ;;
            *.rar)       unrar e $1 ;;
            *.gz)        gunzip $1 ;;
            *.tar)       tar xf $1 ;;
            *.tbz2)      tar xjf $1 ;;
            *.tgz)       tar xzf $1 ;;
            *.zip)       unzip $1 ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1 ;;
            *)           echo "can't do" ;;
        esac
    else
        echo "not a file"
    fi
}

confirm () {
    read -r -p "${1:-Are you sure? [y/N]} " response

    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;35m") \
    LESS_TERMCAP_md=$(printf "\e[1;35m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;36m") \
      man "$@"
}

play () { 
    youtube-dl ytsearch:"$@" -q -f bestaudio --ignore-config --console-title --print-traffic --max-downloads 1 --no-call-home --no-playlist -o - | \
    mpv --no-terminal --no-video --cache=256 -; 
}

function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    sudo -E ssh -Nf "$1" -D 8080

    export http_proxy="http://localhost:8080/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export FTP_PROXY=$http_proxy
    export RSYNC_PROXY=$http_proxy
}

function proxy_off(){
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
}

export -f confirm play swap proxy_on proxy_off

## colours ##

Color_Off='\e[0m'
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'
BIBlack='\e[1;90m'
BIRed='\e[1;91m'
BIGreen='\e[1;92m'
BIYellow='\e[1;93m'
BIBlue='\e[1;94m'
BIPurple='\e[1;95m'
BICyan='\e[1;96m'
BIWhite='\e[1;97m'
c_Blue='\033[38;5;39m'

## ruby
 
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export PATH=$PATH:$GEM_HOME/bin

## bash completion ##

completion_path='/usr/share/bash-completion/bash_completion'
[[ -f $completion_path ]] && . $completion_path

## PS1 ##

. ~/.bash_psone &> /dev/null

## keychain ##

. ~/.keychain/$HOSTNAME-sh &> /dev/null
. ~/.keychain/$HOSTNAME-sh-gpg &> /dev/null

## source local ##

. ~/.bash_local &> /dev/null

## show todo ##

if [ -f ~/todo ]; then
    echo "[todo]"
    cat ~/todo
    echo
fi

# start tunnels
! pgrep -f "^autossh.*shmig_tunnels$" > /dev/null 2>&1 && autossh -M 0 -T -f -N shmig_tunnels
! pgrep -f "^autossh.*osmc_tunnels$" > /dev/null 2>&1 && autossh -M 0 -T -f -N osmc_tunnels

