### packages

  - (aur) libnotify-id-git
  - dunst

### example

    noti_id=60
    while :; do
        noti_id=$(notify-send --print-id --replace-id "$noti_id" ...)
    done
