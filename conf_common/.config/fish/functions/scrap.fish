function scrap
    if not test -d "$DOTS_SCRAP_DIR"
        echo "DOTS_SCRAP_DIR not found" >&2
        return 1
    end

    set -l func "__scrap_$argv[1]"

    if not type --query "$func"
        echo "command $argv[1] not found" >&2
        return 1
    end

    $func
end

function __scrap_go
    set -l dir (__scrap_setup_scrap_dir go)
    set -l file "main.go"

    __write "$file" \
        "// \$ cd \"$dir\"; and go run \"$file\"" \
        '' \
        'package main' \
        '' \
        'func main() {}' \
        '' \
        'func cerr(err error) {' \
        '   if err != nil {' \
        '       panic(err)' \
        '   }' \
        '}'

    go mod init scrap
    git init
    git add -A
    git commit -m init

    $EDITOR "$file"
end

function __scrap_python
    set -l dir (__scrap_setup_scrap_dir python)
    set -l file "main.py"

    __write "$file" \
        "# \$ cd \"$dir\"; and python \"$file\"" \
        '' \
        '' \
        'def main():' \
        '    pass' \
        '' \
        '' \
        'if __name__ == "__main__":' \
        '    main()'

    git init
    git add -A
    git commit -m init

    $EDITOR "$file"
end

function __scrap_typescript
    set -l dir (__scrap_setup_scrap_dir ts)
    set -l file "main.ts"

    __write "$file" \
        "// \$ cd \"$dir\"; and deno run \"$file\"" \
        ''

    npm init --yes >/dev/null
    touch deno.json
    git init
    git add -A
    git commit -m init

    $EDITOR "$file"
end

function __scrap_find
    rg -g '**/*.go' -g '**/*.py' -g '**/*.ts' --line-number --no-heading --smart-case --color=never . "$DOTS_SCRAP_DIR" \
        | sed -r 's/([^:]+)\:([0-9]+):/\1\t\2\t/g' \
        | fzf \
        | read -d \t path num rest
    test -z "$path"; and return

    $EDITOR "$path" "+$num"
end

function __scrap_setup_scrap_dir
    set -l prefix $argv[1]
    set -l dir (mktemp -d "$DOTS_SCRAP_DIR/$prefix.XXXX")
    cd "$dir"; or return 1

    function unscrap --inherit-variable dir
        cd
        rm -rf "$dir"
    end

    echo "$dir"
end

function __write
    printf "%s\n" $argv[2..] >$argv[1]
end
