function beside
    set -l fifo (mktemp -u)
    mkfifo "$fifo"
    tee "$fifo" | fish -c "$argv" | awk -v f=$fifo 'BEGIN{getline left < f} {printf "%s\t%s\n", left, $0; if ((getline left < f) <= 0) exit}'
    command rm -f "$fifo"
end
