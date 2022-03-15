# ssh sock, make sure it's the same as `gpgconf --list-dirs agent-ssh-socket`
# if set in this file, the varible is availible for login shells, interactive shells, and the
# systemd user env via import-environment in sway config
set -gx SSH_AUTH_SOCK "$HOME/.gnupg/S.gpg-agent.ssh"
