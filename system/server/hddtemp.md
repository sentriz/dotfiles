### packages

  - hddtemp

### file
`/etc/systemd/system/hddtemp.service.d/override.conf`

    [Service] 
    Type=simple
    ExecStart=
    ExecStart=/usr/sbin/hddtemp -dF --listen=127.0.0.1 /dev/sda /dev/sdb /dev/sdc


### commands

    # systemctl daemon-reload
    # systemctl enable hddtemp
    # systemctl start hddtemp
