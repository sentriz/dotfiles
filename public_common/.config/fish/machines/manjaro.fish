set -gx EDITOR nvim

# prompt colour
set -xg fish_color_host brgreen

# startup
if status --is-interactive
    activate_keychain
end

# start x
if test (tty) = '/dev/tty1'
    start_sway
end
