complete -c from -f -n 'test (count (commandline -opc)) -eq 1' -a '(__fish_complete_directories)'

complete -c from -n 'test (count (commandline -opc)) -ge 2' -a '(
    set -l tokens (commandline -opc) (commandline -ct)
    fish -c "cd \$argv[1]; and complete -C \"\$argv[2]\"" -- $tokens[2] (string join " " -- $tokens[3..])
)'
