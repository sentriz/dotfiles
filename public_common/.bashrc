## 256 colours

export TERM=xterm-256color

## aliases

alias ls='ls --color=auto'
alias l='ls -lpAh --color=auto'
alias pg='ping 8.8.8.8'

c() { cd "$@" && ls -lpAh; }
alias please='sudo $(history -p \!\!)' 

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias temp='expr `cat /sys/class/thermal/thermal_zone0/temp` / 1000'
alias tb='nc termbin.com 9999'
alias ascreen='screen -dRR'
alias home="cd ~"

for n in `seq 1 9`; do
    alias w$n="i3-msg workspace $n";
done

## vi keybindings 

set -o vi

## functions

extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

## colours

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

## source local

export ssh_ps1_string=""

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

## ps1

git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\ \\\\\1\\/ `'
export PS1="\[$Color_Off\]\[$ssh_ps1_string\]\[$BIGreen\]\u\[$Green\]@\h \[$c_Blue\]\w\[$Red\]$git_branch \[$White\]\$\[$Color_Off\] "

## bash completion

completion_path='/usr/share/bash-completion/bash_completion'
[[ -f $completion_path ]] && . $completion_path
