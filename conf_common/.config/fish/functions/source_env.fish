function source_env
    set -l env_file $argv[1]
    test -f "$env_file"; or return 1

    cat "$env_file" | grep -v "^#" | shlex | while read line
        set parts (echo "$line" | string split -m 1 =)
        set -gx "$parts[1]" "$parts[2]"
    end
end
