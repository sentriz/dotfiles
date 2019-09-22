### about

`gpg-agent` will act as an `ssh-agent`

notable dotfiles:

- `~/.gnupg/gpg-agent.conf`
- `~/.gnupg/sshcontrol`
- `~/.config/fish/functions/activate_keychain.fish` where some env vars for ssh are set, and gnupg's `TTY` and `X-DISPLAY` variables are updated (needed for `pinentry` to work consistently)

### packages

- gnupg

### commands

    $ gpg --import <usb-stick>/senan_kelly.asc
    $ systemctl --user enable --now gpg-agent-ssh.socket
    $ systemctl --user enable --now gpg-agent-extra.socket
    $ systemctl --user enable --now gpg-agent-browser.socket
    $ systemctl --user enable --now gpg-agent.socket
