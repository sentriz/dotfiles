function l
	test -d .git; and git status; and echo
    ls -vFqrloth --group-directories-first --color=yes --time-style=long-iso $argv \
    | sed "s/"(date +%Y-%m-%d)"/\x1b[32m     today\x1b[m/; s/"(date +'%Y-%m-%d' -d yesterday)"/\x1b[33m yesterday\x1b[m/"
end
