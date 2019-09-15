### about

`gpg-agent` will act as an `ssh-agent`

notable dotfiles:

- `~/.gnupg/gpg-agent.conf`
- `~/.gnupg/sshcontrol`
- `~/.config/fish/functions/activate_keychain.fish` where some env vars for ssh are set, and gnupg's `TTY` and `X-DISPLAY` variables are updated (needed for `pinentry` to work consistently)

### packages

- keybase
- gnupg

### commands

    $ # set kbfs mount point for `private/bin/secret`
    $ keybase config set mountdir ~/mounts/kbfs
    $ # import public key
    $ keybase pgp export | gpg --import
    $ # import private key
    $ keybase pgp export --secret | gpg --allow-secret-key-import --import
    $ # setup gpg-agent
    $ systemctl --user enable --now gpg-agent-ssh.socket
    $ systemctl --user enable --now gpg-agent-extra.socket
    $ systemctl --user enable --now gpg-agent-browser.socket
    $ systemctl --user enable --now gpg-agent.socket

### see also

- [server gpg](https://github.com/sentriz/dotfiles/blob/master/server/gpg.md)
