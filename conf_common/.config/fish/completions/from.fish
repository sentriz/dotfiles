complete -c from -f -n 'test (count (commandline -opc)) -eq 1' -a '(__fish_complete_directories)'

complete -c from -n 'test (count (commandline -opc)) -ge 2' -a '(
    set -l tokens (commandline -opc) (commandline -ct)
    complete -C (string join " " -- $tokens[3..])
)'
