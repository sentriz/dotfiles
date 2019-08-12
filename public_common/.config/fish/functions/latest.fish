function latest
    if test (count $argv) -eq 0
        echo 'please provide a path' >&2
        return
    end
    echo "$argv[1]/"(ls -Art "$argv[1]" | tail -n 1)
end
