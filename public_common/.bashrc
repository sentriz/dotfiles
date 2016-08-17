## aliases

# needed argument or couldn't quote
c() { cd "$@" && ls -lpAh; }
fuzz_here() { find . -readable -type f 2> /dev/null | fzf --reverse --black --multi | xclip; }
fuzz_root() { find / -readable -type f 2> /dev/null | fzf --reverse --black --multi | xclip; }
find_key() { xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'; }

# listing
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lpAh --color=auto --group-directories-first'
alias l='ls -lph --color=auto --group-directories-first'

# safety/better
alias rm='rm -Iv --preserve-root'
alias sudo='sudo '
alias wget='wget -c'
alias cp='cp -aiv'
alias mkdir='mkdir -p -v'
alias du='du -d1 -h'
alias df='df -hT'

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
alias tb='nc termbin.com 9999'
alias please='sudo $(history -p \!\!)' 
alias sedo="sudo -E"

# exit
alias :wq="exit"
alias :qw="exit"
alias :q="exit"


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

confirm () {
    # call with a prompt string or use a default
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

colours() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

swap()         
{
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

export -f confirm play swap


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


## bash completion
completion_path='/usr/share/bash-completion/bash_completion'
[[ -f $completion_path ]] && . $completion_path


## PS1
if [ -f ~/.bash_psone ]; then
    . ~/.bash_psone
fi


## keychain
. ~/.keychain/$HOSTNAME-sh &> /dev/null
. ~/.keychain/$HOSTNAME-sh-gpg &> /dev/null


## source local
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

## show todo
if [ -f ~/todo ]; then
    echo "[todo]"
    cat todo
    echo
fi
