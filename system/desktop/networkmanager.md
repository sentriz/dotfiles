### files
`/etc/NetworkManager/NetworkManager.conf`

    [device]
    wifi.scan-rand-mac-address=no

`/etc/NetworkManager/conf.d/wifi_backend.conf`

    [device]
    wifi.backend=iwd

### packages

  - network-manager
  - network-manager-openvpn
  - network-manager-applet
