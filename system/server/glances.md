### packages

  - (pip) git+https://github.com/nicolargo/glances.git@develop
  - (apt) lm-sensors
  - (apt) wireless-tools

### files
`/etc/glances/glances.conf`

    [global]
    check_update=false
    
    [diskio]
    hide=sr0,sda1,sda2,sda5,sdb1,sdc1
    md0_alias=media
    sda_alias=boot
    sdb_alias=member 1
    sdc_alias=member 2
    
    [sensors]
    nouveau 1_alias=nouveau
    core 0_alias=core 1
    core 1_alias=core 2
    core 9_alias=core 3
    core 10_alias=core 4
    ambient_alias=ambient
    sda_alias=drive boot
    sdb_alias=drive media 1
    sdc_alias=drive media 2
    
    [network]
    hide=docker*,lo,_*,wg0
    
    [passwords]
    default={{ password }}

`/etc/glances/glances.conf`

    [Unit]
    Description=Glances
    After=network.target
    
    [Service]
    ExecStart=/usr/local/bin/glances \
        -w \
        -u senan
    Restart=on-abort
    
    [Install]
    WantedBy=multi-user.target

### commands

    $ systemd enable glances
    $ systemd start glances
