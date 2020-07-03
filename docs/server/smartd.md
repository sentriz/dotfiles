
### packages

- smartmontools

### files 

`/etc/smartd.conf`

    # first test the email is working
    DEVICESCAN ... -m <email> -M test
    # then restart smartd

    # then email as usual
    DEVICESCAN ... -m <email> -M exec <runner>

### commands

    $ systemctl enable --now smartd

### see also

 - [email](./email.md)
