complete -c watch-run -n 'not contains -- -- (commandline -opc)' -a '(
    set -l tokens (commandline -opc) (commandline -ct)
    complete -C (string join " " -- $tokens[2..])
)'
