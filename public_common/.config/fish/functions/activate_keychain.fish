# Defined in /tmp/fish.dxZgk4/activate_keychain.fish @ line 2
function activate_keychain
    gpgconf --launch gpg-agent
    set -gx GPG_TTY (tty)
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
