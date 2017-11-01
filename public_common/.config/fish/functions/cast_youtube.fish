# Defined in /tmp/fish.WvBQCq/cast_youtube.fish @ line 2
function cast_youtube
	youtube-dl "$argv[1]" -o - | castnow -
end
