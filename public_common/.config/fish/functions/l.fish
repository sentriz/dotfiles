function l
	test -d .git; and git status; and echo
    ls -vFqrloth --color=yes --time-style=long-iso $argv \
    | sed "s/"(date +%Y-%m-%d)"/\x1b[32m     TODAY\x1b[m/; s/"(date +'%Y-%m-%d' -d yesterday)"/\x1b[33m YESTERDAY\x1b[m/"
end
