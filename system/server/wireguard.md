adapted from: [Wireguard VPN: Typical Setup](https://web.archive.org/web/20190715171210/https://www.ckn.io/blog/2017/11/14/wireguard-vpn-typical-setup/)

### packages

  - wireguard
  - wireguard-dkms
  - wireguard-tools
  - linux-headers-$(uname -r)
  - iptables-persistent

### files
`/etc/wireguard/wg0.conf`

    [Interface]
    Address = 10.200.200.1/24
    SaveConfig = true
    ListenPort = 1194
    PrivateKey = <versa/server_private_key>

    [Peer]
    PublicKey = <versa/client_phone_public_key>
    AllowedIPs = 10.200.200.2/32

    [Peer]
    PublicKey = <versa/client_laptop_public_key>
    AllowedIPs = 10.200.200.3/32

`/etc/sysctl.conf`

    # enable ip forwarding
    net.ipv4.ip_forward=1

### commands

    $ # load wg config
    $ chown root:root /etc/wireguard/wg0.conf
    $ chmod 600 /etc/wireguard/wg0.conf
    $ wg-quick up wg0
    $
    $ # enable on boot
    $ systemctl enable wg-quick@wg0.service
    $
    $ # enable ip forwarding
    $ sysctl -p
    $ echo 1 > /proc/sys/net/ipv4/ip_forward
    $
    $ # track vpn connection
    $ iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    $ iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    $
    $ # allow incoming vpn traffic on the listening port
    $ iptables -A INPUT -p udp -m udp --dport 1194 -m conntrack --ctstate NEW -j ACCEPT
    $
    $ # allow both tcp and udp recursive dns traffic
    $ iptables -A INPUT -s 10.200.200.0/24 -p tcp -m tcp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
    $ iptables -A INPUT -s 10.200.200.0/24 -p udp -m udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT
    $
    $ # allow forwarding of packets that stay in the vpn tunnel
    $ iptables -A FORWARD -i wg0 -o wg0 -m conntrack --ctstate NEW -j ACCEPT
    $
    $ # setup nat
    $ iptables -t nat -A POSTROUTING -s 10.200.200.0/24 -o eth0 -j MASQUERADE
    $
    $ # persist iptables
    $ systemctl enable netfilter-persistent
    $ netfilter-persistent save
