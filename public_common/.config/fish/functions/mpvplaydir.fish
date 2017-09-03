# Defined in /tmp/fish.FQggdI/mpvplaydir.fish @ line 4
function mpvplaydir
	mpv (wget -O - "$argv[1]" | grep -oP "(?<=<li><a href=\").*\.(flac|mp3)(?=\">)" | sed -e "s@^@$argv[1]@")
end
