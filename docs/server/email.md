### commands

    $ apt install apt-file
    $ apt remove --purge (apt-file search (which sendmail) | grep -Eo "^[^:]+")

### packages

- msmtp     # the client
- msmtp-mta # transfer agent
- bsd-mailx # to provide the "mail" command

### files 

`~/.msmtprc`

    defaults
    port <starttls port>
    tls on
    tls_trust_file /etc/ssl/certs/ca-certificates.crt
    account default
    host <smtp host>
    from <from addr>
    auth on
    user <from user>
    password <password>

### test

    $ echo "test" | msmtp a@b.c
    $ echo "test" | mail a@b.c
