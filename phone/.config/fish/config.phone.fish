set -gx fish_colour_host brmagenta

set -gx SSH_AUTH_SOCK "$TMPDIR/rbw-"(id -u)"/ssh-agent-socket"
