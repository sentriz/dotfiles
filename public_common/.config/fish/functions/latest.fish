# Defined in /tmp/fish.3kJaPv/latest.fish @ line 2
function latest --description 'alias latest_here ls -Art | tail -n 1'
	echo "$argv[1]/"(ls -Art "$argv[1]" | tail -n 1)
end
