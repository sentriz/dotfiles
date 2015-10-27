[[ -z $(pgrep -xU $UID mpd) ]] && mpd &
[[ -z $(pgrep -xU $UID mpdscribble) ]] && mpdscribble &
