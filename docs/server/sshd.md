### files

`/etc/ssh/sshd_config`

    AllowUsers <🤫>
    ChallengeResponseAuthentication no
    GSSAPIAuthentication no
    IgnoreRhosts yes
    MaxAuthTries 4
    PasswordAuthentication no
    PermitEmptyPasswords no
    PermitRootLogin no
    Port <🤫>
    PrintMotd no
    Protocol 2
    PubkeyAuthentication yes
    StreamLocalBindUnlink yes
    Subsystem sftp /usr/lib/openssh/sftp-server
    UseDNS no
    UsePAM yes
