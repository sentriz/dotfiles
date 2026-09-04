complete -c repos-do -a '(
    set -l tokens (commandline -opc) (commandline -ct)
    complete -C (string join " " -- $tokens[2..])
)'
