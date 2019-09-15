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

### packages

- openresolv
- networkmanager
- networkmanager-wireguard-git
