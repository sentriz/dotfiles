#!/usr/bin/env fish

# extra config
set -x host_prompt_colour 'red'

# sourcy stuff
source $HOME/.keychain/(hostname)-fish > /dev/null 2>&1
source $HOME/.keychain/(hostname)-fish-gpg > /dev/null 2>&1
eval (python3 -m virtualfish auto_activation)
