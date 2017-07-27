function play
    youtube-dl ytsearch:$argv -q -f bestaudio --ignore-config --console-title --print-traffic --max-downloads 1 --no-call-home --no-playlist -o - | \
    mpv --no-terminal --no-video --cache=256 - ^&1 > /dev/null
end
