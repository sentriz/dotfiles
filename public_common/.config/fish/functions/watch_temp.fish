# Defined in /tmp/fish.zJfLyT/watch_temp.fish @ line 1
function watch_temp
	while true
        printf "\r%s, %sdegC" (date '+%H:%M:%S') (temp)
        sleep 1
    end
end
