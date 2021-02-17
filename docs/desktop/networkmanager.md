### files

`/etc/NetworkManager/NetworkManager.conf`

    [device]
    wifi.scan-rand-mac-address=no

`/etc/NetworkManager/conf.d/wifi_backend.conf`

    [device]
    wifi.backend=iwd

`/etc/NetworkManager/conf.d/rc-manager.conf`

    [main]
    rc-manager=resolvconf

`/etc/NetworkManager/dispatcher.d/99-wlan`

    #!/usr/bin/env bash

    if [[ "$1" =~ en.* ]]; then
        case "$2" in
            up)   nmcli radio wifi off ;;
            down) nmcli radio wifi on  ;;
        esac
    fi

### packages

- openresolv
- networkmanager
- networkmanager-wireguard-git
